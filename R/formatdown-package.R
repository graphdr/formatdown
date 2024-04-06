
#' @importFrom checkmate qassert assert_disjunct assert_choice assert_true
#'
#' @importFrom data.table copy setDT fifelse fcase :=  %like% %between%
#'
#' @importFrom settings options_manager stop_if_reserved reset
#'
#' @importFrom units as_units deparse_unit
#'
#' @importFrom wrapr stop_if_dot_args %?%
#'
NULL

#' Formatting Tools for R Markdown Documents
#'
#' Provides a small set of tools for formatting tasks when creating
#' documents in R Markdown or Quarto Markdown. Convert the elements of a
#' numerical vector to character strings in decimal form or power-of-ten form
#' using engineering or scientific notation, all delimited for rendering as inline
#' equations; or as numbers with measurement units (non-delimited) where units
#' can be selected to eliminate the need for power-of-ten notation. Useful for
#' rendering a numerical scalar in an inline R code chunk as well as formatting
#' columns of data frames displayed in a table.
#'
#'
#'
#' @docType package
#' @name formatdown-package
#' @aliases formatdown
#'
#'
#' @keywords internal
#'
#'
#'
NULL
