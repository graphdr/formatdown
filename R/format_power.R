
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

  # Check argument types, x not "Date" class
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

  # Indicate these are not unbound symbols. (R CMD check Note)
  exponent <- NULL
  coeff <- NULL
  value <- NULL

  # Do the work

  # Convert vector to data.table for processing
  DT <- copy(data.frame(x))
  setDT(DT)

  # Choose divisor: scientific or engineering notation
  exp_divisor<- fcase(
    format == "engr", 3,
    format == "sci",  1
  )

  # Create coeff and exponent
  DT[, exponent := floor(floor(log10(abs(x))) / exp_divisor) * exp_divisor]
  DT[, coeff := formatC(signif(x / (10^exponent), digits = digits),
                           format = "fg",
                           digits = digits,
                           flag = "#")]

  # Omit decimal at the end of a coeff, if any
  DT[coeff %like% "[:.:]$", coeff := sub("[:.:]", "", coeff)]

  # Construct output character
  DT[, value := fifelse(
    abs(x) %between% limits,
    # Disabled-exponent values
    formatC(signif(x, digits = digits),
            format = "fg",
            digits = digits,
            flag = "#"),
    # Power of ten values
    paste0(coeff, "\\times", "{10}^{", exponent, "}")
  )]

  # Omit decimal at the end of value, if any
  DT[value %like% "[:.:]$", value := sub("[:.:]", "", value)]

  # Surround with $$ for math printout
  DT[, value := paste0("$", value, "$")]

  # # Convert to vector output
  DT <- DT[, (value)]

  # enable printing (see data.table FAQ 2.23)
  DT[]
}
