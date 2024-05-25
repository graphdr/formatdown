# Internal functions, not exported

# Typeface
get_math_markup <- function(face) {

  # Default is plain
  math_markup  <- "\\mathrm"

  # Allow shorthand and markup style
  if (isTRUE(!is.na(face)) & isTRUE(!is.null(face))) {
    if(face == "plain"  | face == "\\mathrm") math_markup  <- "\\mathrm"
    if(face == "italic" | face == "\\mathit") math_markup  <- "\\mathit"
    if(face == "bold"   | face == "\\mathbf") math_markup  <- "\\mathbf"
    if(face == "sans"   | face == "\\mathsf") math_markup  <- "\\mathsf"
    if(face == "mono"   | face == "\\mathtt") math_markup  <- "\\mathtt"
  }
  return(math_markup)
}

#' Format text
#'
#' Convert a character vector to "math text" delimited for rendering as inline
#' equations in an R markdown document. Particularly useful for matching the
#' font face of character columns to that of numerical columns in a table.
#'
#' Given a scalar, vector, or data frame column, `format_text()` converts its
#' argument to a character string of the form `"$\\mathxx{a}$"` where `a`
#' is the element to be formatted and `\\mathxx` determines the font face:
#' plain type is set by `\\mathrm`; italic by `\\mathit`;
#' bold by `\\mathbf`; sans serif by `\\mathsf`; and monospace (typewriter
#' text) by `\\mathtt`. All strings include markup delimiters `$...$` for
#' rendering (in an R markdown or Quarto markdown document) as an inline
#' equation.
#'
#' @param x Vector to be formatted.
#'
#' @param ... Not used, force later arguments to be used by name.
#'
#' @param face Font face. Determines the font face macro inside the math
#'   delimiters. Possible values are "plain" (default), "italic", "bold",
#'   "sans", or "mono". One may assign instead the corresponding LaTeX-style
#'   markup itself, e.g., `\\mathrm`, `\\mathit`, `\\mathbf`, `\\mathsf`, or
#'   `\\mathtt`.
#'
#' @param size,delim,whitespace Used to format the math-delimited character
#'   strings. For details, see the help page for `formatdown_options()`.
#'
#' @return A character vector with elements delimited as inline math markup
#'  in plain, italic, sans serif, bold, or monospace font face.
#'
#' @family format_*
#' @example man/examples/examples_format_text.R
#' @export
format_text <- function(x,
                        face = "plain",
                        ...,
                        size = formatdown_options("size"),
                        delim = formatdown_options("delim"),
                        whitespace = formatdown_options("whitespace")) {

  # Overhead ----------------------------------------------------------------

  # Arguments after dots must be named
  wrapr::stop_if_dot_args(substitute(list(...)), "format_text()")

  # Indicate these are not unbound symbols (R CMD check Note)
  value <- NULL
  math_markup <- NULL
  size_markup <- NULL

  # Assign arguments -------------------------------------------------------

  # size
  if (is_null_or_na(size)) size <- NA_character_

  # Argument checks ---------------------------------------------------------

  # x: coercible to character
  checkmate::qassert(as.character(x), "s*")

  # face: character, not missing, length 1, element of set
  checkmate::qassert(face, "S1")
  checkmate::assert_choice(
    face,
    choices = c("plain", "italic", "bold", "sans", "mono", "\\mathrm", "\\mathit", "\\mathbf", "\\mathsf", "\\mathtt")
    )

  # Assertions on options (in utils.R)
  param_assert_delim(delim)
  param_assert_size(size)
  param_assert_whitespace(whitespace)

  # Initial processing ------------------------------------------------------

  # Assign markup parameters
  size_markup <- get_size_markup(size)
  math_markup <- get_math_markup(face)

  # Begin ------------------------------------------------------

  # Convert vector to data.table for processing
  DT <- data.table::copy(data.frame(x))
  setDT(DT)

  # To retain spaces within x, sub LaTeX "\:"
  DT[, value := as.character(x)]
  DT[, value := gsub(" ", whitespace, value)]
  DT[is.na(x), value := NA_character_]

# Add math markup
  DT[, value := paste0(math_markup, "{", value, "}")]

  # Prep for output
  output_vector <- prepare_output_vector(DT, size_markup, delim)
  output_vector[]
  return(output_vector)
}
