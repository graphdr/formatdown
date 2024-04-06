# Internal function not exported:

PKG_OPTIONS <- settings::options_manager(
  size = NA_character_,
  delim = "$",
  decimal_mark = ".",
  big_mark = "",
  small_mark = "",
  word_space = "\\\\>"
  )

# User function is exported:

#' Options settings
#'
#' Set and examine several global options which affect the way in which
#' formatdown displays its results.
#'
#' Global options are provided for those arguments most likely to be used
#' throughout a document. For example, some users prefer a period (".") as a
#' decimal marker, others prefer a comma (","). A user would likely prefer to
#' set this option once rather than restating it in every function call.
#'
#' Globally-set arguments can be overridden locally by assigning them in a
#' function call.
#'
#' @param ... One or more `name = value` pairs to set values; or one or more
#'     quoted option names to get values.
#'
#' @section formatdown options:
#' \describe{
#'
#'    \item{`size`}{Font size. Possible values are NA (default), "scriptsize",
#'    "small", "normalsize", "large", and "huge". If not NA, adds a prefix to
#'    the markup to invoke the macros `\scriptsize`, `\small`, `\normalsize`,
#'    etc.}
#'
#'    \item{`delim`}{Character vector of length one or two defining the math markup
#'    delimiters. Possible values include `c("$", "$")` or `c("\\(", "\\)")`.
#'    Alternatively, one can use `"$"` (default) or `"\\("`, both of which
#'    create appropriate left and right delimiters. If required by one's markup
#'    environment, custom 2-element (left and right) delimiters can be assigned.}
#'
#'    \item{`decimal_mark`}{Character. Possible values are a period (`"."`,
#'    default) or a comma (`","`) to denote the numeric decimal point; passed
#'    to `formatC(decimal.mark)`.}
#'
#'    \item{`big_mark`}{Character. Possible values are empty (`""`, default)
#'    or "thin" to produce a LaTeX-style thin space (`"\\\\,"`) to separate
#'    numbers into groups of three to the left of the decimal mark; passed to
#'    `formatC(big.mark)`.}
#'
#'    \item{`small_mark`}{c}
#'
#'    \item{`word_space`}{Character. Defines the LaTeX-style math-mode macro to
#'    preserve a horizontal space between words. Default is (`"\\\\>"`).
#'    Alternatives include (`"\\\\:"`) or ("`\\\\ `").}
#'
#' }
#'
#' @family *_options
#' @example man/examples/examples_formatdown_options.R
#' @export
formatdown_options <- function(...){
  # protect against the use of reserved words.
  settings::stop_if_reserved(...)
  PKG_OPTIONS(...)
}


#' Reset formatdown options
#'
#' Reset formatdown options to their default values.
#'
#' @family *_options
#' @export
reset_formatdown_options <- function(){
  settings::reset(PKG_OPTIONS)
}
