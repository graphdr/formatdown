# Internal functions, not exported

# Typeface format for math markup ------------------------------------------
get_math_markup <- function(face) {
  # Face format for math markup
  if(face == "plain")  math_markup  <- "\\mathrm"
  if(face == "italic") math_markup  <- "\\mathit"
  if(face == "bold")   math_markup  <- "\\mathbf"
  if(face == "sans")   math_markup  <- "\\mathsf"
  if(face == "mono")   math_markup  <- "\\mathtt"
  return(math_markup)
}




#' Format text
#'
#' Convert a character vector to "math text" delimited for rendering as inline
#' equations in an R markdown document. The formatting is particularly useful
#' for text columns in a table in which numerical columns are formatted using
#' `format_numbers()`.
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
#' Using `options()` to assign a value to `formatdown.face` affects only
#' that text formatted using `format_text()`. However, using `options` to assign
#' `formatdown.size` affects output formatted by `format_text()` and
#' `format_numbers()`.
#'
#' Delimiters for inline math markup can be edited if necessary. If the default
#' argument fails, try using `"\\("` as an alternative. If using a custom
#' delimiter to suit the markup environment, be sure to escape all special
#' symbols.
#'
#' @param x Vector to be formatted.
#'
#' @param ... Not used, force later arguments to be used by name.
#'
#' @param face Font face. Possible values are "plain" (default), "italic",
#'   "bold", "sans", or "mono". Adds a prefix to the markup to invoke the macros
#'   `\mathrm`, `\mathit`, `\mathbf`, `\mathsf`, or `\mathtt`.
#'
#' @param size,delim,word_space Used to format the math-delimited character
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
                        word_space = formatdown_options("word_space")) {

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
    choices = c("plain", "italic", "bold", "sans", "mono")
    )

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

  # word_space: character, not missing, length 1,
  checkmate::qassert(word_space, "S1")


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
  DT[, value := gsub(" ", word_space, value)]
  DT[is.na(x), value := NA_character_]

# Add math markup
  DT[, value := paste0(math_markup, "{", value, "}")]

  # Prep for output
  output_vector <- prepare_output_vector(DT, size_markup, delim)
  output_vector[]
  return(output_vector)
}
