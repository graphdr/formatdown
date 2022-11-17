
#' Format powers of ten
#'
#' Convert the elements of a numerical vector to character strings in which
#' the numbers are formatted using powers-of-ten notation in scientific or
#' engineering form and delimited for rendering as inline equations in an
#' R Markdown document.
#'
#' Given a number, a numerical vector, or a numerical column from a data frame,
#' \code{format_power()} converts the numbers to character strings of the form,
#' \code{"$a\\\\times{10}^{n}$"}, where \code{a} is the coefficient and \code{n}
#' is the exponent. The string includes markup delimiters \code{$...$} for
#' rendering the result as an inline equation in R Markdown or Quarto Markdown
#' document. The user can specify the number of significant digits, scientific
#' or engineering format, and the range over which decimal notation is enforced.
#'
#' @param x Numeric vector to be formatted.
#' @param digits Numeric scalar, nonzero positive integer to specify the
#'        number of significant digits in the output coefficient.
#' @param ... Not used, force later arguments to be used by name.
#' @param format Character. Possible values are "engr" (engineering notation)
#'        and "sci" (scientific notation). Use by name.
#' @param limits Numeric vector, length two, specifying the range over which
#'        power of ten notation is disabled and numbers are represented
#'        in decimal notation. Use by name.
#'
#' @return A character vector with the following properties:
#' \itemize{
#'     \item Numbers within the \code{limits} range represented in decimal
#'           notation; all others represented in powers of ten notation.
#'     \item Elements delimited with \code{$...$} for rendering as
#'           inline math in an R Markdown or Quarto Markdown document.
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
                         limits = c(0.1, 1000)) {

  # Arguments after dots must be named
  wrapr::stop_if_dot_args(
    substitute(list(...)),
    paste(
      "Arguments after ... must be named.\n",
      "* Did you forget to write `format = ` or `limits = `?\n *"
    )
  )

  # Check argument types, not "Date" class
  checkmate::assert_disjunct(class(x), c("Date", "POSIXct", "POSIXt"))
  # length at least one, numeric
  checkmate::qassert(x, "n+")
  # numeric, not missing, length 1
  checkmate::qassert(digits, "N1")
  # character, not missing, length 1
  checkmate::qassert(format, "S1")
  # element of a set
  checkmate::assert_choice(format, c("engr", "sci"))
  # numeric, not missing, length 2
  checkmate::qassert(limits, "N2")

  # Indicate these are not unbound symbols (R CMD check Note)
  char_coeff <- NULL
  exponent <- NULL
  coeff <- NULL
  value <- NULL



  # ----- Initial processing

  # Convert vector to data.table for processing
  DT <- copy(data.frame(x))
  setDT(DT)

  # Exponent multiple for scientific or engineering notation
  exp_multiple <- fcase(
    format == "engr", 3,
    format == "sci",  1
  )

  # Initialize variables
  DT[, c("exponent", "coeff") := NA_real_]
  DT[, c("value", "char_coeff") := NA_character_]

  # Indices to rows for decimal and powers-of-ten notation
  decimal <- abs(DT$x) %between% limits
  pow_10  <- !decimal



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
# Internal functions

# Remove trailing decimal point, if any, introduced by formatC()
omit_trailing_decimal <- function(DT, col_name) {

  # Logical. Identify rows with trailing decimal points
  rows_we_want <- DT[, get(col_name)] %like% "[:.:]$"

  # Delete trailing decimal points if any
  DT[rows_we_want, (col_name) := sub("[:.:]", "", get(col_name))]
}
