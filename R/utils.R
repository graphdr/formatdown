
#' Remove trailing decimal point and spaces, if any, added by formatC()
#'
#' @param DT data.table
#' @param col_name Character, length 1, column name to work on
#'
#' @noRd
#'
omit_formatC_extras <- function(DT, col_name) {

  # Logical. Identify rows with trailing decimal points
  rows_we_want <- DT[, get(col_name)] %like% "[:.:]$"

  # Delete trailing decimal points if any
  DT[rows_we_want, (col_name) := sub("[:.:]", "", get(col_name))]

  # Trim space added by formatC if any
  DT[, (col_name) := trimws(get(col_name), which = "both")]
}

#' Surround elements of character vector with inline math delimiters
#'
#' @param DT data.table
#' @param col_name Character, length 1, column name to work on
#' @param delim Character, delimiter, length 1 or 2
#'
#' @noRd
#'
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
#'
#' @noRd
#'
is_null_or_na <- function(x) {
  sum(c(is.null(x), is.na(x))) > 0
}

#' Is x numeric and length 1?
#'
#' @param x Vector
#'
#' @noRd
#'
is_numeric_and_length_one <- function (x) {
  isTRUE(is.numeric(x) & length(x) == 1)
}
