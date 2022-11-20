
#' Format powers of ten
#'
#' Convert the elements of a numerical vector to character strings in which
#' the numbers are formatted using powers-of-ten notation in scientific or
#' engineering form and delimited for rendering as inline equations in an
#' R Markdown document.
#'
#' Given a number, a numerical vector, or a numerical column from a data frame,
#' \code{format_power()} converts the numbers to character strings of the form,
#' \code{"\\\\(a\\\\times{10}^{n}\\\\)"}, where \code{a} is the coefficient and
#' \code{n}
#' is the exponent. The string includes markup delimiters \code{\\\\(...\\\\)}
#' for
#' rendering as an inline equation in R Markdown or Quarto Markdown
#' document. The user can specify the number of significant digits and scientific
#' or engineering format.
#'
#' Powers-of-ten notation is omitted over a range of exponents via
#' \code{omit_power} such that numbers are converted to character strings of
#' the form, \code{"\\\\(a\\\\)"}, where \code{a} is the number in decimal notation.
#' The default \code{omit_power = c(-1, 2)} formats numbers such as 0.123, 1.23,
#' 12.3, and 123 in decimal form. To cancel these exceptions and convert all
#' numbers to powers-of-ten notation, set the \code{omit_power} argument to
#' NULL.
#'
#' Delimiters for inline math markup can be edited if necessary. If the default
#' argument fails, the \code{"$"} alternative is available. If using a custom
#' delimiter to suit the markup environment, be sure to escape all special
#' symbols.
#'
#' @param x Numeric vector to be formatted.
#' @param digits Numeric scalar, nonzero positive integer to specify the
#'        number of significant digits in the output coefficient.
#' @param ... Not used, force later arguments to be used by name.
#' @param format Character. Possible values are "engr" (engineering notation)
#'        and "sci" (scientific notation). Use argument  by name.
#' @param omit_power Numeric vector \code{c(p, q)} specifying the range of
#'        exponents over which power of ten notation is omitted, where
#'        \code{p <= q}. If NULL all numbers are formatted in powers of ten
#'        notation. Use argument by name.
#' @param delim Character vector (length 1 or 2) defining the delimiters for
#'        marking up inline math.
#'        Possible values include \code{c("$")} or
#'        \code{c("\\\\(")}, both of which create appropriate left and right
#'        delimiters. Alternatively, left and right can be defined
#'        explicitly, e.g., \code{c("$", "$")} or \code{c("\\\\(", "\\\\)")}.
#'        Custom delimiters can be assigned to suit the markup environment. Use
#'        argument by name.
#'
#' @return A character vector with the following properties:
#' \itemize{
#'     \item Numbers represented in powers of ten notation except for those
#'           with exponents in the range specified in \code{omit_power}
#'     \item Elements delimited as inline math markup.
#' }
#'
#'
#' @family format_*
#'
#'
#' @example man/examples/examples_format_power.R
#'
#'
#' @export
#'
#'
format_power <- function(x,
                         digits = 3,
                         ...,
                         format = "engr",
                         omit_power = c(-1, 2),
                         delim = "\\(") {

  # On exit, reset user's options values
  user_digits <- getOption("digits")
  on.exit(options(digits = user_digits))

  # Arguments after dots must be named
  wrapr::stop_if_dot_args(
    substitute(list(...)),
    paste(
      "Arguments after ... must be named.\n",
      "* Did you forget to write `format = ` or `omit_power = `?\n *"
    )
  )

  # set omit_power to handle NULL or NA case
  if (sum(isTRUE(is.null(omit_power))) > 0 | sum(isTRUE(is.na(omit_power))) > 0 ) {
   # Assign equal fractional values and no integer exponents
   # can lie on this range
    omit_power <- c(0.1, 0.1)
    }

  # x: not "Date" class
  checkmate::assert_disjunct(class(x), c("Date", "POSIXct", "POSIXt"))

  # x: length at least one, numeric
  checkmate::qassert(x, "n+")

  # digits: numeric, not missing, length 1
  checkmate::qassert(digits, "N1")

  # ========== digits between 1 and 20?

  # format: character, not missing, length 1
  checkmate::qassert(format, "S1")

  # format: element of a set
  checkmate::assert_choice(format, c("engr", "sci"))

  # omit_power: numeric, not missing, length 2
  checkmate::qassert(omit_power, "N2")

  # omit_power: range (p, q) requirement p <= q
  if (!isTRUE(all(omit_power == cummax(omit_power)))) {
    stop("In `omit_power = c(p, q)`, `p` must be less than or equal to `q`.")
  }

  # Indicate these are not unbound symbols (R CMD check Note)
  char_coeff <- NULL
  exponent <- NULL
  coeff <- NULL
  value <- NULL



  # ----- Initial processing

  # Convert vector to data.table for processing
  DT <- copy(data.frame(x))
  setDT(DT)

  # Indices to rows, separating decimal from exponential notation
  DT[, exponent := floor(log10(abs(x)))]
  decimal <- DT$exponent %between% omit_power
  pow_10  <- !decimal

  # Exponent multiple for scientific or engineering notation
  exp_multiple <- fcase(
    format == "engr", 3,
    format == "sci",  1
  )



  # ----- Rows with numbers in decimal notation

  # Create the character value to significant digits
  DT[decimal, value := formatC(x, format = "fg", digits = digits, flag = "#")]

  # Remove trailing decimal point created by formatC() if any
  DT[decimal] <- omit_trailing_decimal(DT[decimal], "value")



  # ----- Rows with numbers in powers-of-ten notation

  # Determine numerical coefficient and exponent
  DT[pow_10, exponent := exp_multiple * floor(log10(abs(x)) / exp_multiple)]
  DT[pow_10, coeff := x / 10^exponent]

  # Create the character coefficient to significant digits
  DT[pow_10, char_coeff := formatC(coeff, format = "fg", digits = digits, flag = "#")]

  # Remove trailing decimal point created by formatC() if any
  DT[pow_10] <- omit_trailing_decimal(DT[pow_10], "char_coeff")

  # Construct powers-of-ten character string
  DT[pow_10, value := paste0(char_coeff, "\\times", "{10}^{", exponent, "}")]



  # ----- Complete the conversion for all value strings

  # Surround with $...$ for math printout
  DT[, value := paste0("$", value, "$")]

  # Convert to vector output
  DT <- DT[, (value)]

  # enable printing (see data.table FAQ 2.23)
  DT[]
}



# ---------------------------------------------------
# Appendix: Internal functions

# Remove trailing decimal point, if any, introduced by formatC()
omit_trailing_decimal <- function(DT, col_name) {

  # Logical. Identify rows with trailing decimal points
  rows_we_want <- DT[, get(col_name)] %like% "[:.:]$"

  # Delete trailing decimal points if any
  DT[rows_we_want, (col_name) := sub("[:.:]", "", get(col_name))]
}
