
#' Remove trailing decimal point and spaces, if any, added by formatC()
#'
#' @param DT data.table
#' @param col_name Character, length 1, column name to work on
#' @noRd
omit_formatC_extras <- function(DT, col_name) {

  # Logical. Identify rows with trailing decimal points
  rows_we_want <- DT[, get(col_name)] %like% "[:.:]$"

  # Delete trailing decimal points if any
  DT[rows_we_want, (col_name) := sub("[:.:]", "", get(col_name))]

  # Trim space added by formatC if any
  DT[, (col_name) := trimws(get(col_name), which = "l")]
  return(DT)
}

#' Surround elements of character vector with inline math delimiters
#'
#' @param DT data.table
#' @param col_name Character, length 1, column name to work on
#' @param delim Character, delimiter, length 1 or 2
#' @noRd
add_delim <- function(DT, col_name, delim) {
  if (length(delim) == 1) {
    if (delim == "\\(" | delim == "\\)") {
      DT[, (col_name) := paste0("\\(", get(col_name), "\\)")]
    } else {
      DT[, (col_name) := paste0(delim, get(col_name), delim)]
    }
  } else {
    DT[, (col_name) := paste0(delim[1], get(col_name), delim[2])]
  }
}

#' Is an element of x NA or NULL, true/false
#'
#' @param x Vector
#' @noRd
is_null_or_na <- function(x) {
  sum(c(is.null(x), is.na(x))) > 0
}

#' Is x numeric and length 1?
#'
#' @param x Vector
#' @noRd
is_numeric_and_length_one <- function (x) {
  isTRUE(is.numeric(x) & length(x) == 1)
}

#' Param check delim
#'
#' Character, length 1 or two, not empty, not missing
#' @param delim Character
#' @noRd
param_assert_delim <- function(delim) {
  checkmate::qassert(delim, "S+")
  checkmate::assert_true(!"" %in% delim)
  checkmate::assert_true(length(delim) <= 2)
  if (length(delim) < 2) {
    checkmate::assert_choice(delim, choices = c("$", "\\("))
  }
}

#' Param check size
#'
#' @param size Character, not missing, length 1, element of set
#' @noRd
param_assert_size <- function(size) {
  checkmate::qassert(size, "s1")
  checkmate::assert_choice(
    size,
    choices = c(NA_character_, "scriptsize", "small", "normalsize", "large", "huge", "\\scriptsize", "\\small", "\\normalsize", "\\large", "\\huge")
  )
}

#' Param check whitespace
#'
#' @param whitespace Character, not missing, length 1
#' @noRd
param_assert_whitespace <- function(whitespace) {
  checkmate::qassert(whitespace, "S1")
}

#' Param check mark
#'
#' For big_mark, small_mark
#' @param mark Character, length 1, can be empty.
#' @noRd
param_assert_mark <- function(mark) {
  checkmate::qassert(mark, "s1")
  checkmate::assert_choice(mark, choices = c("thin", "\\\\,", "")
  )
}

# Arguments after dots must be named
#'
#' @param ... Not used
#' @noRd
arg_after_dots_named <- function(...){
stop_if_dots_text <- paste(
  "Arguments after ... must be named.\n",
  "* Did you forget to write `arg_name = value`\n",
  "  for one of the arguments after the dots?*"
)
wrapr::stop_if_dot_args(substitute(list(...)), stop_if_dots_text)
}
