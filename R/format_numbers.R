

# size can now be NA. Removes \\size from markup
get_size_markup <- function(size) {
  # Size format for math markup
  if(isTRUE(is.na(size)) & isTRUE(!is.null(size))) {
    size_markup  <- NULL
  } else {
    if(size == "huge")       size_markup  <- "\\huge "
    if(size == "large")      size_markup  <- "\\large "
    if(size == "normalsize") size_markup  <- "\\normalsize "
    if(size == "small")      size_markup  <- "\\small "
    if(size == "scriptsize") size_markup  <- "\\scriptsize "
  }
  return(size_markup)
}

# Determine indices to decimal (non-power) rows
assign_non_power_rows <- function(DT, format, omit_power, set_power) {

  # Indicate these are not unbound symbols (R CMD check Note)
  exponent <- NULL
  exp_raw <- NULL
  omit <- NULL

  DT[, omit := FALSE]

  # Cases for omit TRUE
  DT[exponent %between% omit_power, omit := TRUE]
  if (format == "engr") {
    DT[, exponent := floor(exp_raw / 3) * 3]
    DT[exponent %between% omit_power, omit := TRUE]
  }
  # DT[is.na(x), omit := TRUE]

  # Identify the non-power rows
  non_pow <- DT$omit

  # Override all if set_power has been assigned
  if (isTRUE(!is.null(set_power)) & isTRUE(!is.na(set_power))) {
    DT[, exponent := set_power]
    non_pow <- FALSE
  }
  return(non_pow)
}

# Prepare result with size, delim, and back to vector form
prepare_output_vector <- function(DT, size_markup, delim) {
  # DT$value is a power-of-ten or decimal character

  # Indicate these are not unbound symbols (R CMD check Note)
  value <- NULL

  # Add font size prefix
  DT[, value := paste0(size_markup, value)]

  # Surround with math delimiters (see utils.R)
  DT <- add_delim(DT, col_name = "value", delim = delim)

  # Convert to vector output
  DT <- DT[, (value)]

  # enable printing (see data.table FAQ 2.23)
  DT[]
  return(DT)
}

# Logical. Is any element of x NA or NULL?
is_null_or_na <- function(x) {
  sum(c(is.null(x), is.na(x))) > 0
}

# Logical. Is x numeric and length 1?
is_numeric_and_length_one <- function (x) {
  is.numeric(x) & length(x) == 1
}


#' Format numbers
#'
#' Convert a numeric vector to a character vector in which the numbers are
#' formatted in power-of-ten notation in scientific or engineering form and
#' delimited for rendering as inline equations in an R markdown document.
#' Decimal numbers can be similarly formatted, without the power-of-ten
#' notation.
#'
#' Given a number, a numerical vector, or a numerical column from a data frame,
#' `format_numbers()` converts the numbers to character strings of the form,
#' `"$a \\times 10^{n}$"`, where `a` is the coefficient to a specified
#' number of significant digits and `n` is the exponent. When used for decimal
#' notation, `format_numbers()` converts numbers to character strings of the
#' form `"$a$"`. All strings include markup delimiters `$...$` for rendering
#' (in an R markdown or Quarto markdown document) as an inline equation.
#'
#' Powers-of-ten notation is omitted over a range of exponents via `omit_power`
#' such that numbers so specified are converted to decimal notation. For
#' example, the default `omit_power = c(-1, 2)` formats numbers such as 0.123,
#' 1.23, 12.3, and 123 in decimal form. To cancel these exceptions and convert
#' all numbers to powers-of-ten notation, set the `omit_power` argument to NULL
#' or NA.
#'
#' Delimiters for inline math markup can be edited if necessary. If the default
#' argument fails, try using `"\\("` as an alternative. If using a custom
#' delimiter to suit the markup environment, be sure to escape all special
#' symbols.
#'
#' Arguments after the dots (`...`) must be referred to by name.
#'
#' @param x Numerical vector to be formatted. Can be a scalar, a vector, or a
#'   column from a data frame. Ca include NA elements.
#'
#' @param digits Integer scalar from 1 through 20 that controls the number of
#'   significant digits in printed numeric values; see `signif()`. Default is 4.
#'
#' @param format Type of notation. Possible values are "engr" (default) for
#'   engineering power-of-ten notation, "sci" for scientific power-of-ten
#'   notation, and "dcml" for decimal notation.
#'
#' @param ... Not used for values, forces subsequent arguments to be referable
#'   only by name.
#'
#' @param omit_power Numeric vector `c(p, q)` with `p <= q`, specifying the
#'   range of exponents over which power-of-ten notation is omitted in either
#'   scientific or engineering power-of-ten format. Default is `c(-1, 2)`. If a
#'   single value is assigned, i.e., `omit_power = p`, the argument is
#'   interpreted as `c(p, p)`. If `NULL` or `NA`, all elements are formatted in
#'   power-of-ten notation. Argument is overridden by a non-empty `set_power`
#'   or if decimal notation is specified (`format = "dcml"`).
#'
#' @param set_power Integer scalar. Formats all values in `x` with the same
#'   power-of-ten exponent. Default NULL. Assigning a value to set_power
#'   overrides `format` and `omit_power` arguments.
#'
#' @param size,delim,decimal_mark,big_mark,small_mark Formatting options. For
#'   details, see the help page for `formatdown_options()`.
#'
#' @return A character vector with the following properties:
#' \itemize{
#'   \item Numbers represented in powers of ten notation or decimal notation.
#'   \item Elements delimited as inline math markup.
#' }
#'
#' @family format_*
#' @example man/examples/examples_format_numbers.R
#' @export
format_numbers <- function(x,
                         digits = 4,
                         format = "engr",
                         ...,
                         omit_power = c(-1, 2),
                         set_power = NULL,
                         size = formatdown_options("size"),
                         delim = formatdown_options("delim"),
                         decimal_mark = formatdown_options("decimal_mark"),
                         big_mark = formatdown_options("big_mark"),
                         small_mark = formatdown_options("small_mark")) {

  # Overhead ----------------------------------------------------------------

  # On exit, anything to reset?
  # on.exit()

  # Arguments after dots must be named
  stop_if_dots_text <- paste(
    "Arguments after ... must be named.\n",
    "* Did you forget to write `arg_name = value`\n",
    "  for one of the arguments after the dots?*"
  )
  wrapr::stop_if_dot_args(substitute(list(...)), stop_if_dots_text)

  # Indicate these are not unbound symbols (R CMD check Note)
  size_markup <- NULL
  char_coeff <- NULL
  exponent <- NULL
  exp_raw <- NULL
  coeff <- NULL
  value <- NULL


  # Assign arguments -------------------------------------------------------

  # size
  if (is_null_or_na(size)) size <- NA_character_

  # omit_power
  if (is_null_or_na(omit_power)) omit_power <- c(0.5, 0.5)
  if (is_numeric_and_length_one(omit_power)) omit_power <- rep(omit_power, 2)
  if (format == "dcml") omit_power <- c(-Inf, Inf)

  # set_power
  if (is_null_or_na(set_power)) set_power <- NA_real_
  if (format == "dcml") set_power <- NA_real_




  # Argument checks ---------------------------------------------------------

  # x: not Date-class,length at least 1, numeric
  checkmate::assert_disjunct(class(x), c("Date", "POSIXct", "POSIXt"))
  checkmate::qassert(x, "n+")

  # digits: numeric, not missing, length 1, between 1 and 20
  checkmate::qassert(digits, "N1")
  checkmate::assert_choice(digits, choices = c(1:20))

  # format: character, not missing, length 1, element of set
  checkmate::qassert(format, "S1")
  checkmate::assert_choice(format, choices = c("engr", "sci", "dcml"))

  # omit_power: numeric, not missing, length 2, c(p, q) with p <= q
  checkmate::qassert(omit_power, "N2")
  if (!isTRUE(all(omit_power == cummax(omit_power)))) {
    stop("In `omit_power = c(p, q)`, `p` must be less than or equal to `q`.")
  }

  # set_power: numeric, length 1 (can be NA)
  checkmate::qassert(set_power, "n1")

  # size: character, not missing, length 1, element of set
  checkmate::qassert(size, "s1")
  checkmate::assert_choice(
    size,
    choices = c(NA_character_, "scriptsize", "small", "normalsize", "large", "huge")
  )

  # delim: character, not missing, length 1 or 2, not empty
  checkmate::qassert(delim, "S+")
  checkmate::assert_true(!"" %in% delim)
  checkmate::assert_true(length(delim) <= 2)

  # decimal_mark: character, not missing, length 1
  checkmate::qassert(decimal_mark, "S1")

  # big_mark: character, length 1, can be empty
  checkmate::qassert(big_mark, "s1")
  checkmate::assert_choice(
    big_mark,
    choices = c("thin", "\\\\,", "")
  )

  # small_mark: character, length 1, can be empty
  checkmate::qassert(small_mark, "s1")
  checkmate::assert_choice(
    small_mark,
    choices = c("thin", "\\\\,", "")
  )

  # big_mark and decimal_mark may not be the same character
  if (sum(isTRUE(big_mark == decimal_mark)) > 0) {
    stop("`big_mark` and `decimal_mark` may not be assigned the same symbol.")
  }

  # Initial processing -----------------------------------------

  # Set significant digits before processing
  x <- signif(x, digits = digits)

  # Assign markup parameters
  size_markup <- get_size_markup(size)
  if(big_mark   == "thin") big_mark   <- "\\\\,"
  if(small_mark == "thin") small_mark <- "\\\\,"

  # Begin ------------------------------------------------------

  # Convert vector to data.table for processing
  DT <- data.table::copy(data.frame(x))
  setDT(DT)

  # Raw decimal exponent and integer exponent
  DT[, exp_raw := log10(abs(x))]
  DT[, exponent := floor(exp_raw)]

  # Determine power and non-power rows
  non_pow <- assign_non_power_rows(DT, format, omit_power, set_power)
  pow_10  <- !non_pow

  # Create the decimal coefficient
  DT[non_pow, coeff := x]
  DT[pow_10,  coeff := x / 10^exponent]

  # Format the coefficient as character
  DT[, char_coeff := formatC(coeff,
                             format = "fg",
                             digits = digits,
                             big.mark = big_mark,
                             decimal.mark = decimal_mark,
                             small.mark = small_mark,
                             small.interval = 3,
                             flag = "#")]


  # Remove trailing decimal point and spaces created by formatC() if any
  # (see utils.R)
  DT <- omit_formatC_extras(DT, col_name = "char_coeff")

  # Construct various string values
  DT[non_pow, value := char_coeff]
  DT[pow_10, value := paste0(char_coeff, " \\times ", "10^{", exponent, "}")]
  DT[is.na(x), value := "\\mathrm{NA}"]

  # Prep for output
  result <- prepare_output_vector(DT, size_markup, delim)
  result[]
  return(result)
}







#' Format scientific notation
#'
#' Convert a numeric vector to a character vector in which the numbers are
#' formatted in power-of-ten notation in scientific form and delimited for
#' rendering as inline equations in an R markdown document.
#'
#' A convenience function to create scientific power-of-ten notation with a
#' minimal set of arguments by wrapping `format_numbers()`. Use
#' `formatdown_options()` to globally set `size`, `delim`, `decimal_mark`,
#' `big_mark`, or `small_mark` for use with this convenience function.
#' Otherwise, use `format_numbers()` for direct local access to all arguments.
#'
#' Arguments after the dots (`...`) must be referred to by name.
#'
#' @param x Numerical vector to be formatted. Can be a scalar, a vector, or a
#'   column from a data frame.
#'
#' @param digits Integer scalar from 1 through 20 that controls the number of
#'   significant digits in printed numeric values; passed to `signif()`.
#'   Default is 4.
#'
#' @param ... Not used for values, forces subsequent arguments to be referable
#'   only by name.
#'
#' @param omit_power Numeric vector `c(p, q)` with `p <= q`, specifying the
#'   range of exponents over which power-of-ten notation is omitted in either
#'   scientific or engineering power-of-ten format. Default is `c(-1, 2)`. If a
#'   single value is assigned, i.e., `omit_power = p`, the argument is
#'   interpreted as `c(p, p)`. If `NULL` or `NA`, all elements are formatted in
#'   power-of-ten notation. Argument is overridden by a non-empty `set_power`.
#'
#' @param set_power Integer scalar. Formats all values in `x` with the same
#'   power-of-ten exponent. Default NULL. Assigning a value to set_power
#'   overrides `omit_power` arguments.
#'
#' @param size,delim,decimal_mark,big_mark,small_mark Formatting options. For
#'   details, see the help page for `formatdown_options()`.
#'
#' @return A character vector with the following properties:
#' \itemize{
#'   \item Numbers represented in scientific powers of ten notation.
#'   \item Elements delimited as inline math markup.
#' }
#'
#' @family format_*
#' @export
format_sci <- function(x,
                       digits = 4,
                       ...,
                       omit_power = c(-1, 2),
                       set_power = NULL,
                       size = formatdown_options("size"),
                       delim = formatdown_options("delim"),
                       decimal_mark = formatdown_options("decimal_mark"),
                       big_mark = formatdown_options("big_mark"),
                       small_mark = formatdown_options("small_mark")) {

  # wrapper for format_numbers()
  result <- format_numbers(x = x,
                           digits = digits,
                           format = "sci",
                           omit_power = omit_power,
                           set_power = set_power,

                           size = size,
                           delim = delim,
                           decimal_mark = decimal_mark,
                           big_mark = big_mark,
                           small_mark = small_mark)

  result[]
  return(result)
}






#' Format engineering notation
#'
#' Convert a numeric vector to a character vector in which the numbers are
#' formatted in power-of-ten notation in engineering form and delimited for
#' rendering as inline equations in an R markdown document.
#'
#' A convenience function to create engineering power-of-ten notation with a
#' minimal set of arguments by wrapping `format_numbers()`. Use
#' `formatdown_options()` to globally set `size`, `delim`, `decimal_mark`,
#' `big_mark`, or `small_mark` for use with this convenience function.
#' Otherwise, use `format_numbers()` for direct local access to all arguments.
#'
#' Arguments after the dots (`...`) must be referred to by name.
#'
#' @param x Numerical vector to be formatted. Can be a scalar, a vector, or a
#'   column from a data frame.
#'
#' @param digits Integer scalar from 1 through 20 that controls the number of
#'   significant digits in printed numeric values; passed to `signif()`.
#'   Default is 4.
#'
#' @param ... Not used for values, forces subsequent arguments to be referable
#'   only by name.
#'
#' @param omit_power Numeric vector `c(p, q)` with `p <= q`, specifying the
#'   range of exponents over which power-of-ten notation is omitted in either
#'   scientific or engineering power-of-ten format. Default is `c(-1, 2)`. If a
#'   single value is assigned, i.e., `omit_power = p`, the argument is
#'   interpreted as `c(p, p)`. If `NULL` or `NA`, all elements are formatted in
#'   power-of-ten notation. Argument is overridden by a non-empty `set_power`.
#'
#' @param set_power Integer scalar. Formats all values in `x` with the same
#'   power-of-ten exponent. Default NULL. Assigning a value to set_power
#'   overrides `omit_power` arguments.
#'
#' @param size,delim,decimal_mark,big_mark,small_mark Formatting options. For
#'   details, see the help page for `formatdown_options()`.
#'
#' @return A character vector with the following properties:
#' \itemize{
#'   \item Numbers represented in engineering powers of ten notation.
#'   \item Elements delimited as inline math markup.
#' }
#'
#' @family format_*
#' @export
format_engr <- function(x,
                        digits = 4,
                        ...,
                        omit_power = c(-1, 2),
                        set_power = NULL,
                        size = formatdown_options("size"),
                        delim = formatdown_options("delim"),
                        decimal_mark = formatdown_options("decimal_mark"),
                        big_mark = formatdown_options("big_mark"),
                        small_mark = formatdown_options("small_mark")) {


  # wrapper for format_numbers()
  result <- format_numbers(x = x,
                           digits = digits,
                           format = "engr",
                           omit_power = omit_power,
                           set_power = set_power,

                           size = size,
                           delim = delim,
                           decimal_mark = decimal_mark,
                           big_mark = big_mark,
                           small_mark = small_mark)

  result[]
  return(result)
}






#' Format decimal notation
#'
#' Convert a numeric vector to a character vector in which the numbers are
#' formatted in decimal form and delimited for rendering as inline equations
#' in an R markdown document.
#'
#' A convenience function to create decimal notation with a
#' minimal set of arguments by wrapping `format_numbers()`. Use
#' `formatdown_options()` to globally set `size`, `delim`, `decimal_mark`,
#' `big_mark`, or `small_mark` for use with this convenience function.
#' Otherwise, use `format_numbers()` for direct local access to all arguments.
#'
#' Arguments after the dots (`...`) must be referred to by name.
#'
#' @param x Numerical vector to be formatted. Can be a scalar, a vector, or a
#'   column from a data frame.
#'
#' @param digits Integer scalar from 1 through 20 that controls the number of
#'   significant digits in printed numeric values; passed to `signif()`.
#'   Default is 4.
#'
#' @param ... Not used for values, forces subsequent arguments to be referable
#'   only by name.
#'
#' @param size,delim,decimal_mark,big_mark,small_mark Formatting options. For
#'   details, see the help page for `formatdown_options()`.
#'
#' @return A character vector with the following properties:
#' \itemize{
#'   \item Numbers represented in decimal notation.
#'   \item Elements delimited as inline math markup.
#' }
#'
#' @family format_*
#' @export
format_dcml <- function(x,
                        digits = 4,
                        ...,
                        size = formatdown_options("size"),
                        delim = formatdown_options("delim"),
                        decimal_mark = formatdown_options("decimal_mark"),
                        big_mark = formatdown_options("big_mark"),
                        small_mark = formatdown_options("small_mark")) {

  # wrapper for format_numbers() with format set to "dcml"
  result <- format_numbers(x = x,
                           digits = digits,
                           format = "dcml",

                           # arguments not used for decimal notation
                           omit_power = NULL,
                           set_power = NULL,

                           # optional arguments
                           size = size,
                           delim = delim,
                           decimal_mark = decimal_mark,
                           big_mark = big_mark,
                           small_mark = small_mark)

  result[]
  return(result)
}
