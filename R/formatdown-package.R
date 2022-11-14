


#' @importFrom checkmate assert_data_frame assert_int qassert
#' @importFrom checkmate assert_subset assert_names
#'
#' @importFrom data.table setkey setkeyv setcolorder setnames setorderv setorder
#' @importFrom data.table fcase fifelse copy as.data.table shift
#' @importFrom data.table setDF setDT
#' @importFrom data.table %chin% %like% .SD .N := %between%
#'
#' @importFrom stats na.omit reorder


NULL


#' Formatting Tools for R Markdown Documents
#'
#' Provides a small set of tools for common formatting tasks when writing
#' documents in R markdown or Quarto markdown. Works with outputs in html,
#' pdf, docx and possibly others.
#'
#'
#'
#' @docType package
#' @name formatdown-package
#'
#'
#'
#' @keyword internal
#'
#'
#'
NULL


# bind names due to NSE notes in R CMD check
if (getRversion() >= "2.15.1") {
  utils::globalVariables(c(
    "."
  ))
}
