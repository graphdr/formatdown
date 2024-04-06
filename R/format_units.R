
#' Format numbers with measurement units
#'
#' Format a vector of numbers with measurement units appended via the 'units'
#' R package and convert to character strings within math delimiters for
#' rendering in an R Markdown document.
#'
#' This function is a wrapper for [units::as_units()] and [base::format()].
#' Numeric class input is converted to units class. Units class input, if
#' convertible, is converted to the specified measurement units; if none are
#' specified, the existing measurement units are retained. The result in all
#' cases is converted to class character using `base::format()` with preset
#' arguments: `trim = TRUE` and `scientific = FALSE`. The output has the form
#' `"a [u]"`, where `a` is the number in decimal notation and `u` is a
#' measurement units label.
#'
#' @param x Vector of class numeric or class units.
#'
#' @param digits Integer scalar from 1 through 20 that controls the number of
#'   significant digits in printed numeric values; see `signif()`. Default is 4.
#'
#' @param unit Character scalar, units label compatible with 'units' package.
#'   For `x` class numeric, transform to class units in `unit` measurement
#'   units. For `x` class units, convert to `unit` measurement units. If empty,
#'   existing class units retained.
#'
#' @param ... Not used, force later arguments to be used by name.
#'
#' @param unit_form Character scalar. Possible values are "standard" (default)
#'   and "implicit" (implicit exponent form). In standard form, units are
#'   related with arithmetic symbols for multiplication, division, and powers,
#'   e.g., `"kg/m^3"` or `"W/(m*K)"`. In implicit exponent form, symbols are
#'   separated by spaces and numbers represent exponents, e.g., `"kg m-3"` or
#'   `"W m-1 K-1"`.
#'
#' @param decimal_mark Character. Possible values are a period (`"."`, default)
#'   or a comma (`","`) to denote the numeric decimal point; applied as the
#'   `decimal.mark` argument of `formatC()`.
#'
#' @param big_mark Character. Possible values are empty (`""`, default) or
#'   "thin" to produce a LaTeX-style thin space (`"\\\\,"`) to separate numbers
#'   into groups of three to the left of the decimal mark; applied as the
#'   `big.mark` argument of `formatC()`.
#'
#' @param size Font size. Possible values are "scriptsize", "small" (default),
#'   "normalsize", "large", and "huge", which correspond to selected LaTeX font
#'   size values.
#'
#' @param delim Character vector of length one or two defining the math markup
#'   delimiters. Possible values include `c("$", "$")` or `c("\\(", "\\)")`.
#'   Alternatively, one can use `"$"` (default) or `"\\("`, both of which
#'   create appropriate left and right delimiters. If required by one's markup
#'   environment, custom 2-element (left and right) delimiters can be assigned.
#'
#'
#' @return A character vector of numbers with appended measurement units.
#' @family format_*
#' @example man/examples/examples_format_units.R
#' @export
format_units <- function(x,
                         digits = NULL,
                         unit = NULL,
                         ...,
                         unit_form = NULL,
                         size = NULL,
                         delim = NULL,
                         big_mark = NULL,
                         decimal_mark = NULL) {

  # Overhead ----------------------------------------------------------------

  # On exit, reset user's options values
  user_digits <- getOption("digits")
  on.exit(options(digits = user_digits))

  # Arguments after dots must be named
  stop_if_dots_text <- paste(
    "Arguments after ... must be named.\n",
    "* Did you forget to write `unit_form = `, etc.\n *"
  )
  wrapr::stop_if_dot_args(substitute(list(...)), stop_if_dots_text)

  # More informative error for digits/unit specifically
  if (!isTRUE(class(digits) == "numeric")) {stop(stop_if_dots_text)}

  # Default for NULL values using wrapr coalesce
  digits       <- digits %?% 4
  unit_form    <- unit_form %?% "standard"
  big_mark     <- big_mark %?% ""
  decimal_mark <- decimal_mark %?% "."
  size         <- size %?% "small"
  delim        <- delim %?% "$"

  # Default for NULL unit if x is class units
  if(isTRUE(is.null(unit) & class(x) == "units")) unit <- deparse_unit(x)

  # Indicate these are not unbound symbols (R CMD check Note)
  # value <- NULL

  # Argument checks ---------------------------------------------------------

  # x: numeric, not empty. length 1 or more
  checkmate::qassert(x, "N+")

  # digits: numeric, not empty, length 1, between 1 and 20
  checkmate::qassert(digits, "N1")
  checkmate::assert_choice(digits, choices = c(1:20))

  # big_mark: character, length 1, can be empty
  checkmate::qassert(big_mark, "s1")

  # unit: character, length 1, not empty
  checkmate::qassert(unit, "S1")

  # unit_form, character, length 1, not empty, one of two choices
  checkmate::qassert(big_mark, "S1")
  checkmate::assert_choice(unit_form, choices = c("standard", "implicit"))

  # Unit notation --------------------------------------------------------

  # Set significant digits before processing
  x <- signif(x, digits = digits)

  # Assign or convert units
  units(x) <- unit

  # Construct the implicit exponent form of units
  if (unit_form == "implicit") {
    label <- paste0("[", deparse_unit(x), "]")
    units(x) <- NULL
  }

  # Adjust the decimal mark if big_mark is a period
  # decimal_mark <- ifelse(big_mark == ".", ",", ".")

  # Format number as character. Enough decimal places are included such that
  # the smallest magnitude value has "digits" many significant digits.
  x_char <- format(x,
                   trim = TRUE,
                   digits     = digits,
                   scientific = FALSE,
                   big.mark   = big_mark,
                   decimal.mark = decimal_mark)

  # Join the implicit units to the output string
  if (unit_form == "implicit") {
    x_char <- paste0(x_char, " ", label)
  }

  # Output ------------------------------------------------------------------

  x_char <- format_text(x_char,
                       face = NULL,
                       size = size,
                       delim = delim)


  return(x_char)
}

