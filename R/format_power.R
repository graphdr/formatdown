
#' Format powers of ten
#'
#' Format a numerical vector as a character string with power of ten notation
#' in mathematical form or engineering form.
#'
#' In engineering notation, exponents are multiples of three. Compatible with
#' many of the output formats of R Markdown and Quarto Markdown. Can be applied
#' to the numerical columns of a data frame via \code{lapply()}.
#'
#' @param x Numerical vector to be formatted.
#' @param sig_dig Scalar integer, number of significant digits, default 3.
#' @param ... Not used, force later arguments to be used by name.
#' @param engr_notation Logical, default TRUE. Places decimal points such that
#'        exponents are multiples of three. If FALSE, result has one digit to
#'        the left of the decimal point.
#' @param disable_exponent Numeric vector of length two with the lower and
#'        upper limits over which scientific notation is disabled, default
#'        c(0.1, 1000).
#'
#' @return A character vector with the following properties:
#' \itemize{
#'     \item Math powers of ten notation substituted for computer notation.
#'     \item Delimited with \code{$...$} for output as a mathematical
#'           expression to R Markdown or Quarto Markdown document.
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
                         sig_dig = 3,
                         ...,
                         engr_notation = TRUE,
                         disable_exponent = c(0.1, 1000)) {

    # Convert vector to data.table for processing
    DT <- copy(data.frame(x))
    setDT(DT)

    # Correct for R CMD check "no visible global function definition"
    exponent <- NULL
    mantissa <- NULL
    value <- NULL

    # Option flags
    exp_divisor <- fifelse(isTRUE(engr_notation), 3, 1)

    # Create mantissa and exponent
    DT[, exponent := floor(floor(log10(abs(x))) / exp_divisor) * exp_divisor]
    DT[, mantissa := formatC(signif(x / (10^exponent), digits = sig_dig),
                             format = "fg",
                             digits = sig_dig,
                             flag = "#")]

    # Omit decimal at the end of a mantissa, if any
    DT[mantissa %like% "[:.:]$", mantissa := sub("[:.:]", "", mantissa)]

    # Construct output character
    DT[, value := fifelse(
        abs(x) %between% disable_exponent,
        # Disabled-exponent values
        formatC(signif(x, digits = sig_dig),
                format = "fg",
                digits = sig_dig,
                flag = "#"),
        # Power of ten values
        paste0(mantissa, "\\times", "10^{", exponent, "}")
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
