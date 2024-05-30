# Internal function not exported:

formatdown_opts <- settings::options_manager(
  delim = "$",
  size = NULL,
  decimal_mark = ".",
  big_mark = "",
  big_interval = 3,
  small_mark = "",
  small_interval = 5,
  whitespace = "\\\\ ",
  multiply_mark = "\\times"
)

# User function is exported:

#' Get and set function arguments via options
#'
#' Changes the default values of function arguments which affect the markup and
#' appearance of formatdown results.
#'
#' Global options are provided for arguments that users would likely prefer to
#' set once in a document instead of repeating in every function call. For
#' example, some users prefer a comma decimal marker (",") throughout a
#' document.
#'
#' Globally-set arguments can be overridden locally by assigning them in a
#' function call.
#'
#' The arguments that can be set with this function are as follows:
#'
#' - `delim`:          `r param_delim`
#' - `size`:           `r param_size`
#' - `decimal_mark`:   `r param_decimal_mark`
#' - `big_mark`:       `r param_big_mark`
#' - `big_interval`:   `r param_big_interval`
#' - `small_mark`:     `r param_small_mark`
#' - `small_interval`: `r param_small_interval`
#' - `whitespace`:     `r param_whitespace`
#' - `multiply_mark`:  `r param_multiply_mark`
#'
#' @param reset Logical vector of length 1; if TRUE, reset all options to their
#'     default values.
#'
#' @param ... One or more `name = value` pairs to set values; or one or more
#'     quoted option names to get values.
#'
#' @return Nothing; used for its side-effect.
#' @example man/examples/examples_formatdown_options.R
#' @export
formatdown_options <- function(..., reset = FALSE) {
  # rest is Boolean, not missing, length 1
  checkmate::qassert(reset, "B1")
  if (reset) {
    settings::reset(formatdown_opts)
  } else {
    formatdown_opts(...)
  }
}
