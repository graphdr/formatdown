
#' Format values with measurement units
#'
#' Format a vector of numbers as character strings with measurement units
#' appended via the 'units' package.
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
#' @param digits Numeric scalar, a positive integer. Applied as the `digits`
#'   argument of `base::format()`. Enough decimal places are included such that
#'   the smallest magnitude value has this many significant digits.
#' @param ... Not used, force later arguments to be used by name.
#' @param unit Character scalar, units label compatible with 'units' package.
#'   For `x` class numeric, transform to class units in `unit` measurement
#'   units. For `x` class units, convert to `unit` measurement units. If empty,
#'   existing class units retained.
#' @param unit_form Character scalar. Possible values are "standard" (default)
#'   and "implicit" (implicit exponent form). In standard form, units are
#'   related with arithmetic symbols for multiplication, division, and powers,
#'   e.g., `"kg/m^3"` or `"W/(m*K)"`. In implicit exponent form, symbols are
#'   separated by spaces and numbers represent exponents, e.g., `"kg m-3"` or
#'   `"W m-1 K-1"`.
#' @param big_mark Character. Applied as the `big.mark` argument of
#'   `base::format()`. Default is `""`. If a period is selected for `big_mark`,
#'   the decimal mark is changed to a comma.
#' @return A character vector of numbers with appended measurement units.
#' @family format_*
#' @example man/examples/examples_format_units.R
#' @export
format_units <- function(x,
                         digits = 1,
                         ...,
                         unit = NULL,
                         unit_form = NULL,
                         big_mark = NULL) {

  # Overhead ----------------------------------------------------------------

  # On exit, reset user's options values
  user_digits <- getOption("digits")
  on.exit(options(digits = user_digits))

  # Arguments after dots must be named
  stop_if_dots_text <- paste(
    "Arguments after ... must be named.\n",
    "* Did you forget to write `unit = `, etc.\n *"
  )
  wrapr::stop_if_dot_args(substitute(list(...)), stop_if_dots_text)

  # More informative error for digits/unit specifically
  if (!isTRUE(class(digits) == "numeric")) {stop(stop_if_dots_text)}

  # Default for NULL values using wrapr coalesce
  big_mark  <- big_mark %?% ""
  unit_form <- unit_form %?% "standard"

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

  # Assign or convert units
  units(x) <- unit

  # Construct the implicit exponent form of units
  if (unit_form == "implicit") {
    label <- paste0("[", deparse_unit(x), "]")
    units(x) <- NULL
  }

  # Adjust the decimal mark if big_mark is a period
  decimal.mark <- ifelse(big_mark == ".", ",", ".")

  # Format number as character. Enough decimal places are included such that
  # the smallest magnitude value has "digits" many significant digits.
  x_char <- format(x,
                   trim = TRUE,
                   digits     = digits,
                   scientific = FALSE,
                   big.mark   = big_mark,
                   decimal.mark = decimal.mark)

  # Join the implicit units to the output string
  if (unit_form == "implicit") {
    x_char <- paste0(x_char, " ", label)
  }

  # Output ------------------------------------------------------------------

  return(x_char)
}

