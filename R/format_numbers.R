# Internal functions not exported:

# Obtain size macro
get_size_markup <- function(size) {
  # Default is no size markup
  size_markup  <- NULL
  # Allow shorthand and markup style
  if (isTRUE(!is.na(size)) & isTRUE(!is.null(size))) {
    if(size == "huge"       | size == "\\huge")       size_markup  <- "\\huge "
    if(size == "large"      | size == "\\large")      size_markup  <- "\\large "
    if(size == "normalsize" | size == "\\normalsize") size_markup  <- "\\normalsize "
    if(size == "small"      | size == "\\small")      size_markup  <- "\\small "
    if(size == "scriptsize" | size == "\\scriptsize") size_markup  <- "\\scriptsize "
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
  if (isTRUE(!is_null_or_na(set_power))) {
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
  return(DT)
}

get_units_suffix <- function(char) {
  # u_suffix <- x
  if (length(char) > 0) {
    # regex to find: optional - sign, followed by any number of digits
    u_regex <- "-?[0-9]+"
    # units exponents, if any
    u_unbraced <- regmatches(char, gregexec(u_regex, char))[[1]]
    if (length(u_unbraced) > 0) {
      # add braces and exponent symbol
      u_braced <- paste0("^{", u_unbraced, "}")
      # substitute each braced exponent for each un-braced exponent
      regmatches(char, gregexec(u_regex, char))[[1]] <- u_braced
    }
  }
  return(char)
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
#' form `"$a$"`. All strings include markup delimiters `$...$` for rendering the
#' result as an inline equation in a R markdown document.
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
#' @param x              `r param_x`
#' @param digits         `r param_digits`
#' @param format         `r param_format`
#' @param ...            `r param_dots`
#' @param omit_power     `r param_omit_power`
#' @param set_power      `r param_set_power`
#' @param delim          `r param_delim`
#' @param size           `r param_size`
#' @param decimal_mark   `r param_decimal_mark`
#' @param big_mark       `r param_big_mark`
#' @param big_interval   `r param_big_interval`
#' @param small_mark     `r param_small_mark`
#' @param small_interval `r param_small_interval`
#'
#' @return A character vector in which numbers are formatted in power-of-ten
#' or decimal notation and delimited for rendering as inline equations
#' in an R markdown document.
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
                           delim          = formatdown_options("delim"),
                           size           = formatdown_options("size"),
                           decimal_mark   = formatdown_options("decimal_mark"),
                           big_mark       = formatdown_options("big_mark"),
                           big_interval   = formatdown_options("big_interval"),
                           small_mark     = formatdown_options("small_mark"),
                           small_interval = formatdown_options("small_interval")) {

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
  u_input <- NULL
  u_regex <- NULL
  u_braced <- NULL
  u_unbraced <- NULL

  # Assign arguments -------------------------------------------------------

  # omit_power
  if (is_null_or_na(omit_power))             omit_power <- c(0.5, 0.5)
  if (is_numeric_and_length_one(omit_power)) omit_power <- rep(omit_power, 2)
  if (isTRUE(format == "dcml"))              omit_power <- c(-Inf, Inf)

  # set_power
  if (is_null_or_na(set_power) | isTRUE(format == "dcml")) set_power <- NA_real_

  # size
  if (is_null_or_na(size)) size <- NA_character_

  # grouping digits
  if (is_null_or_na(big_mark))   big_mark   <- ""
  if (is_null_or_na(small_mark)) small_mark <- ""

  # Argument checks ---------------------------------------------------------

  # x: class "units" or "numeric" both allowed
  if (FALSE) {
    checkmate::assert(
      checkmate::check_class(x, "units"),
      checkmate::check_class(x, "numeric"),
      combine = "or"
    )
  }
  # x: numeric, length at least 1
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
    choices = c(NA_character_, "scriptsize", "small", "normalsize", "large", "huge", "\\scriptsize", "\\small", "\\normalsize", "\\large", "\\huge")
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

  # If x is class units, store units separately and drop the units
  u_input <- NULL
  if (checkmate::test_class(x, classes = c("units"))) {
    u_input  <- deparse_unit(x)
    units(x) <- NULL
  }

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
                             format         = "fg",
                             digits         = digits,
                             decimal.mark   = decimal_mark,
                             big.mark       = big_mark,
                             big.interval   = big_interval,
                             small.mark     = small_mark,
                             small.interval = small_interval,
                             flag           = "#")]

  # Remove trailing decimal point and spaces created by formatC() if any
  # (see utils.R)
  DT <- omit_formatC_extras(DT, col_name = "char_coeff")

  # Construct various string values
  DT[non_pow, value := char_coeff]
  DT[pow_10, value := paste0(char_coeff, " \\times ", "10^{", exponent, "}")]
  DT[is.na(x), value := "\\mathrm{NA}"]

  # Prep for output
  output <- prepare_output_vector(DT, size_markup, delim)

  # Add formatted units suffix if any
  u_suffix <- get_units_suffix(u_input)
  u_suffix <- formatdown::format_text(u_suffix, size = size, delim = delim)
  output <- paste0(output, u_suffix)

  if (length(u_suffix) > 0) {
    # possibly remove back to back $$
    # $ and any no. of spaces followed by $, two backslashes and any number of
    # letters, expecting the \\small, for example
    r <- "\\$ +\\$\\\\[a-zA-Z]+"
    double_dollar <- regmatches(output, gregexec(r, output))[[1]]
    output <- gsub(double_dollar, "\\>", output, fixed = TRUE)
  }

  # enable printing (see data.table FAQ 2.23)
  output[]
  return(output)
}







#' Format scientific notation
#'
#' Convert a numeric vector to a character vector in which the numbers are
#' formatted in power-of-ten notation in scientific form and delimited for
#' rendering as inline equations in an R markdown document.
#'
#' `format_sci()` is a wrapper for the more general function `format_numbers()`.
#' Where defaults are defined by `formatdown_options()`, users may reassign
#' the arguments locally in the function call or globally using
#' `format_down_options()`.
#'
#' Arguments after the dots (`...`) must be referred to by name.
#'
#' @return A character vector in which numbers are formatted in power-of-ten
#' notation in scientific form and delimited for rendering as inline equations
#' in an R markdown document.
#'
#' @inherit format_numbers
#'
#' @family format_*
#' @export
format_sci <- function(x,
                       digits = 4,
                       ...,
                       omit_power = c(-1, 2),
                       set_power = NULL,

                       # argument defaults in formatdown_options
                       delim          = formatdown_options("delim"),
                       size           = formatdown_options("size"),
                       decimal_mark   = formatdown_options("decimal_mark"),
                       small_mark     = formatdown_options("small_mark"),
                       small_interval = formatdown_options("small_interval")) {

                       # wrapper for format_numbers()
  output <- format_numbers(x              = x,
                           digits         = digits,
                           omit_power     = omit_power,
                           set_power      = set_power,
                           delim          = delim,
                           size           = size,
                           decimal_mark   = decimal_mark,
                           small_mark     = small_mark,
                           small_interval = small_interval,

                           # pre-sets for this wrapper
                           format         = "sci",
                           big_mark       = formatdown_options("big_mark"),
                           big_interval   = formatdown_options("big_interval")
                           )

  # enable printing (see data.table FAQ 2.23)
  output[]
  return(output)
}




#' Format engineering notation
#'
#' Convert a numeric vector to a character vector in which the numbers are
#' formatted in power-of-ten notation in engineering form and delimited for
#' rendering as inline equations in an R markdown document.
#'
#' In engineering notation, all exponents are multiples of three.
#' `format_engr()` is a wrapper for the more general function `format_numbers()`.
#' Where defaults are defined by `formatdown_options()`, users may reassign
#' the arguments locally in the function call or globally using
#' `format_down_options()`.
#'
#' Arguments after the dots (`...`) must be referred to by name.
#'
#' @inherit format_numbers
#'
#' @return A character vector in which numbers are formatted in power-of-ten
#' notation in engineering form and delimited for rendering as inline equations
#' in an R markdown document.
#'
#' @family format_*
#' @export
format_engr <- function(x,
                        digits = 4,
                        ...,
                        omit_power = c(-1, 2),
                        set_power = NULL,

                        # argument defaults in formatdown_options
                        delim          = formatdown_options("delim"),
                        size           = formatdown_options("size"),
                        decimal_mark   = formatdown_options("decimal_mark"),
                        small_mark     = formatdown_options("small_mark"),
                        small_interval = formatdown_options("small_interval")) {

  # wrapper for format_numbers()
  output <- format_numbers(x              = x,
                           digits         = digits,
                           omit_power     = omit_power,
                           set_power      = set_power,
                           delim          = delim,
                           size           = size,
                           decimal_mark   = decimal_mark,
                           small_mark     = small_mark,
                           small_interval = small_interval,

                           # pre-sets for this wrapper
                           format         = "engr",
                           big_mark       = formatdown_options("big_mark"),
                           big_interval   = formatdown_options("big_interval")
  )

  # enable printing (see data.table FAQ 2.23)
  output[]
  return(output)
}






#' Format decimal notation
#'
#' Convert a numeric vector to a character vector in which the numbers are
#' formatted in decimal form and delimited for rendering as inline equations
#' in an R markdown document.
#'
#' `format_dcml()` is a wrapper for the more general function `format_numbers()`.
#' Where defaults are defined by `formatdown_options()`, users may reassign
#' the arguments locally in the function call or globally using
#' `format_down_options()`.
#'
#' Arguments after the dots (`...`) must be referred to by name.
#'
#' @inherit format_numbers
#'
#' @return A character vector in which numbers are formatted in decimal form
#' and delimited for rendering as inline equations in an R markdown document.
#'
#' @family format_*
#' @export
format_dcml <- function(x,
                        digits = 4,
                        ...,

                        # argument defaults in formatdown_options
                        delim          = formatdown_options("delim"),
                        size           = formatdown_options("size"),
                        decimal_mark   = formatdown_options("decimal_mark"),
                        big_mark       = formatdown_options("big_mark"),
                        big_interval   = formatdown_options("big_interval"),
                        small_mark     = formatdown_options("small_mark"),
                        small_interval = formatdown_options("small_interval")) {

  # wrapper for format_numbers() with format set to "dcml"
  output <- format_numbers(x              = x,
                           digits         = digits,
                           delim          = delim,
                           size           = size,
                           decimal_mark   = decimal_mark,
                           big_mark       = big_mark,
                           big_interval   = big_interval,
                           small_mark     = small_mark,
                           small_interval = small_interval,

                           # pre-sets for this wrapper
                           format     = "dcml",
                           omit_power = NULL,
                           set_power  = NULL)

  # enable printing (see data.table FAQ 2.23)
  output[]
  return(output)
}
