
#' Format decimal or integer values
#'
#' Convert the elements of a numerical vector to character strings in which the
#' numbers are formatted using decimal notation and delimited for rendering as
#' inline equations in an R Markdown document.
#'
#' Given a number, a numerical vector, or a numerical column from a data frame,
#' `format_decimal()` converts the numbers to character strings of the form,
#' `"$a$"`, where `a` is the number in decimal notation. The user can specify
#' the number of decimal places.
#'
#' Delimiters for inline math markup can be edited if necessary. If the default
#' argument fails, the `"\\("` alternative is available. If using a custom
#' delimiter to suit the markup environment, be sure to escape all special
#' symbols.
#'
#' @param x Numeric vector to be formatted.
#' @param digits Numeric scalar, decimal places to report, integer between 0 and
#'   20. Zero returns an integer.
#' @param ... Not used, force later arguments to be used by name.
#' @param big_mark Character. If not empty, used as mark between every three
#'   digits before the decimal point. Applied as the `big.mark` argument of
#'   `formatC()`.
#' @param delim Character vector (length 1 or 2) defining the delimiters for
#'   marking up inline math. Possible values include `"$"` or `"\\("`, both of
#'   which create appropriate left and right delimiters. Alternatively, left and
#'   right can be defined explicitly in a character vector of length two, e.g.,
#'   `c("$", "$")` or `c("\\(", "\\)")`. Custom delimiters can be assigned to
#'   suit the markup environment. Use argument by name.
#' @return A character vector with the following properties:
#' \itemize{
#'   \item Numbers represented in integer or decimal notation.
#'   \item Elements delimited as inline math markup.
#' }
#' @family format_*
#' @example man/examples/examples_format_decimal.R
#' @export
format_decimal <- function(x,
                           digits = 4,
                           ...,
                           big_mark = NULL,
                           delim = "$") {

  # Overhead ----------------------------------------------------------------

  # On exit, reset user's options values
  user_digits <- getOption("digits")
  on.exit(options(digits = user_digits))

  # Arguments after dots must be named
  stop_if_dots_text <- paste(
    "Arguments after ... must be named.\n",
    "* Did you forget to write `big_mark = `, etc.\n *"
  )
  wrapr::stop_if_dot_args(substitute(list(...)), stop_if_dots_text)

  # Default for NULL argument values using wrapr coalesce
  big_mark <- big_mark %?% ""

  # Indicate these are not unbound symbols (R CMD check Note)
  value <- NULL

  # Argument checks ---------------------------------------------------------

  # x: not "Date" class, length at least one, numeric
  checkmate::assert_disjunct(class(x), c("Date", "POSIXct", "POSIXt"))
  checkmate::qassert(x, "n+")

  # digits: numeric, not missing, length 1, between 0 and 20
  checkmate::qassert(digits, "N1")
  checkmate::assert_choice(digits, choices = c(0:20))

  # big_mark: character, length 1, can be empty
  checkmate::qassert(big_mark, "s1")

  # delim: character, not missing, length 1 or 2, not empty
  checkmate::qassert(delim, "S+")
  checkmate::assert_true(!"" %in% delim)
  checkmate::assert_true(length(delim) <= 2)

  # Initial processing ------------------------------------------------------

  # Convert vector to data.table for processing
  DT <- data.table::copy(data.frame(x))
  data.table::setDT(DT)

  # Decimal notation --------------------------------------------------------

  # Create the character value to number of decimal places
  if(isTRUE(digits == 0)) {

    # Format as integer
    DT[, value := formatC(x, format = "d", big.mark = big_mark)]

  } else {

    # Format with decimals (digits > 0)
    DT[, value := formatC(x, format = "f", digits = digits, big.mark = big_mark)]

  }

  # Remove trailing decimal point and spaces created by formatC() if any
  # (see utils.R)
  DT <- omit_formatC_extras(DT, col_name = "value")

  # Output ------------------------------------------------------------------

  # Surround with math delimiters (see utils.R)
  DT <- add_delim(DT, col_name = "value", delim = delim)

  # Convert to vector output
  DT <- DT[, (value)]

  # enable printing (see data.table FAQ 2.23)
  DT[]
  return(DT)
}
