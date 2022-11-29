
#' Format powers of ten
#'
#' Convert the elements of a numerical vector to character strings in which the
#' numbers are formatted using powers-of-ten notation in scientific or
#' engineering form and delimited for rendering as inline equations in an R
#' Markdown document.
#'
#' Given a number, a numerical vector, or a numerical column from a data frame,
#' `format_power()` converts the numbers to character strings of the form, `"$a
#' \\times 10^{n}$"`, where `a` is the coefficient and `n` is the exponent. The
#' string includes markup delimiters `$...$` for rendering as an inline equation
#' in R Markdown or Quarto Markdown document. The user can specify the number of
#' significant digits and scientific or engineering format.
#'
#' Powers-of-ten notation is omitted over a range of exponents via `omit_power`
#' such that numbers are converted to character strings of the form, `"$a$"`,
#' where `a` is the number in decimal notation. The default `omit_power = c(-1,
#' 2)` formats numbers such as 0.123, 1.23, 12.3, and 123 in decimal form. To
#' cancel these exceptions and convert all numbers to powers-of-ten notation,
#' set the `omit_power` argument to NULL.
#'
#' Delimiters for inline math markup can be edited if necessary. If the default
#' argument fails, the `"\\("` alternative is available. If using a custom
#' delimiter to suit the markup environment, be sure to escape all special
#' symbols.
#'
#' @param x Numeric vector to be formatted.
#' @param digits Numeric scalar, significant digits in coefficient, integer
#'   between 1 and 20.
#' @param ... Not used, force later arguments to be used by name.
#' @param format Character. Possible values are "engr" (engineering notation)
#'   and "sci" (scientific notation). Use argument  by name.
#' @param omit_power Numeric vector `c(p, q)` specifying the range of exponents
#'   over which power of ten notation is omitted, where `p <= q`. If NULL all
#'   numbers are formatted in powers of ten notation. Use argument by name.
#' @param set_power Numeric scalar integer. Assigned exponent that overrides
#'   `format`. Default NULL makes no notation changes.
#' @param delim Character vector (length 1 or 2) defining the delimiters for
#'   marking up inline math. Possible values include `"$"` or `"\\("`, both of
#'   which create appropriate left and right delimiters. Alternatively, left and
#'   right can be defined explicitly in a character vector of length two, e.g.,
#'   `c("$", "$")` or `c("\\(", "\\)")`. Custom delimiters can be assigned to
#'   suit the markup environment. Use argument by name.
#' @return A character vector with the following properties:
#' \itemize{
#'   \item Numbers represented in powers of ten notation except for those
#'           with exponents in the range specified in `omit_power`
#'   \item Elements delimited as inline math markup.
#' }
#' @family format_*
#' @example man/examples/examples_format_power.R
#' @export
format_power <- function(x,
                         digits = 4,
                         ...,
                         format = "engr",
                         omit_power = c(-1, 2),
                         set_power = NULL,
                         delim = "$") {

  # Overhead ----------------------------------------------------------------

  # On exit, reset user's options values
  user_digits <- getOption("digits")
  on.exit(options(digits = user_digits))

  # Arguments after dots must be named
  stop_if_dots_text <- paste(
    "Arguments after ... must be named.\n",
    "* Did you forget to write `format = `, etc.\n *"
  )
  wrapr::stop_if_dot_args(substitute(list(...)), stop_if_dots_text)

  # More informative error for digits/format specifically
  if (!isTRUE(class(digits) == "numeric")) {stop(stop_if_dots_text)}

  # Default for NULL argument values using wrapr coalesce
  set_power <- set_power %?% NA_real_

  # set omit_power to handle NULL or NA case
  if (sum(isTRUE(is.null(omit_power))) > 0 | sum(isTRUE(is.na(omit_power))) > 0 ) {
    # Assign equal fractional values and
    # no integer exponents can lie on this range
    omit_power <- c(0.1, 0.1)
  }

  # Indicate these are not unbound symbols (R CMD check Note)
  char_coeff <- NULL
  exponent <- NULL
  coeff <- NULL
  value <- NULL

  # Argument checks ---------------------------------------------------------

  # x: not "Date" class,length at least 1, numeric
  checkmate::assert_disjunct(class(x), c("Date", "POSIXct", "POSIXt"))
  checkmate::qassert(x, "n+")

  # digits: numeric, not missing, length 1, between 1 and 20
  checkmate::qassert(digits, "N1")
  checkmate::assert_choice(digits, choices = c(1:20))


  # format: character, not missing, length 1, element of set
  checkmate::qassert(format, "S1")
  checkmate::assert_choice(format, choices = c("engr", "sci"))

  # set_power: numeric, length 1 (can be NA)
  checkmate::qassert(set_power, "n1")

  # omit_power: numeric, not missing, length 2, c(p, q) with p <= q
  checkmate::qassert(omit_power, "N2")
  if (!isTRUE(all(omit_power == cummax(omit_power)))) {
    stop("In `omit_power = c(p, q)`, `p` must be less than or equal to `q`.")
  }

  # delim: character, not missing, length 1 or 2, not empty
  checkmate::qassert(delim, "S+")
  checkmate::assert_true(!"" %in% delim)
  checkmate::assert_true(length(delim) <= 2)

  # Initial processing ------------------------------------------------------

  # Convert vector to data.table for processing
  DT <- data.table::copy(data.frame(x))
  setDT(DT)

  # Set exponent to 0 if x close to zero
  DT[, exponent := data.table::fifelse(
    abs(x) > .Machine$double.eps,
    log10(abs(x)),
    0)]

  # Obtain row indices to separate powers-of-ten from non-powers-of-ten
  non_pow <- DT$exponent %between% omit_power
  pow_10  <- !non_pow

  # Exponent multiple for scientific or engineering notation
  exp_multiple <- data.table::fcase(
    format == "engr", 3,
    format == "sci",  1
  )

  # non_pow rows ------------------------------------------------------------

  # Create the character value to significant digits
  DT[non_pow, value := formatC(x,
                               format = "fg",
                               digits = digits,
                               flag = "#")]

  # Remove trailing decimal point and spaces created by formatC() if any
  # (see utils.R)
  DT[non_pow] <- omit_formatC_extras(DT[non_pow], col_name = "value")

  # Power rows ------------------------------------------------------

  # Determine exponent
  if (isTRUE(!is.na(set_power))) {

    # User-supplied exponent
    DT[pow_10, exponent := floor(set_power)]

  } else {

    # Round to multiple of 1 (scientific) or 3 (engineering)
    # Set exponent to 0 if x close to zero
    DT[pow_10, exponent := data.table::fifelse(
      abs(x) > .Machine$double.eps,
      exp_multiple * floor(log10(abs(x)) / exp_multiple),
      0)]

  }

  # Use exponent to determine coefficient
  DT[pow_10, coeff := x / 10^exponent]

  # Create character coefficient to significant digits
  DT[pow_10, char_coeff := formatC(coeff,
                                   format = "fg",
                                   digits = digits,
                                   flag = "#")]

  # Remove trailing decimal point and spaces created by formatC() if any
  # (see utils.R)
  DT[pow_10] <- omit_formatC_extras(DT[pow_10], col_name = "char_coeff")

  # Construct powers-of-ten character string
  DT[pow_10, value := paste0(char_coeff, " \\times ", "10^{", exponent, "}")]

  # Output ------------------------------------------------------

  # Surround with math delimiters (see utils.R)
  DT <- add_delim(DT, col_name = "value", delim = delim)

  # Convert to vector output
  DT <- DT[, (value)]

  # enable printing (see data.table FAQ 2.23)
  DT[]
  return(DT)
}
