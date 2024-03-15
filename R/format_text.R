
#' Format text to match the math font
#'
#' Format a vector as character strings within math delimiters for
#' rendering in an R Markdown document. The formatting is particularly useful
#' for formatting text columns in a table in which numerical columns
#' have been formatted using `format_power()` or `format_decimal()`.
#'
#' Given a scalar, vector, or data frame column, `format_text()` converts its
#' argument to a character string of the form `"$\\mathxx{a}$"` where `a`
#' is the element to be formatted and `\\mathxx` determines the font face:
#' plain type is set by `\\mathrm`; italic by `\\mathit`;
#' bold by `\\mathbf`; sans serif by `\\mathsf`; and monospace (typewriter
#' text) by `\\mathtt`. The string includes markup delimiters `$...$` for
#' rendering as an inline equation in R Markdown or Quarto Markdown document.
#'
#' Using `options()` to assign a value to `formatdown.font.face` affects only
#' that text formatted using `format_text()`. However, using `options` to assign
#' `formatdown.font.size` affects output formatted by `format_text()` and
#' `format_power()`.
#'
#' Delimiters for inline math markup can be edited if necessary. If the default
#' argument fails, try using `"\\("` as an alternative. If using a custom
#' delimiter to suit the markup environment, be sure to escape all special
#' symbols.
#'
#' @param x Vector to be formatted.
#' @param ... Not used, force later arguments to be used by name.
#' @param face Font face. Possible values are "plain", "italic", "bold", "sans",
#'   or "mono". Can also be set as a global option, for example,
#'   `options(formatdown.font.face = "sans")` that can be overwritten in an
#'   individual function call.
#' @param size Font size. Possible values are "scriptsize", "small" (default),
#'   "normalsize", "large", and "huge". which correspond to selected
#'   LaTeX font size values. Can also be set as a global option, for example,
#'   `options(formatdown.font.size = "normalsize")` that can be overwritten
#'   in an individual function call.
#' @param delim Character vector (length 1 or 2) defining the delimiters for
#'   marking up inline math. Possible values include `"$"` or `"\\("`, both of
#'   which create appropriate left and right delimiters. Alternatively, left and
#'   right can be defined explicitly in a character vector of length two, e.g.,
#'   `c("$", "$")` or `c("\\(", "\\)")`. Custom delimiters can be assigned to
#'   suit the markup environment. Use argument by name.
#' @return A character vector with elements delimited as inline math markup
#'  in plain, italic, or bold font face.
#'
#' @family format_*
#' @example man/examples/examples_format_text.R
#' @export
format_text <- function(x,
                        ...,
                        face = NULL,
                        size = NULL,
                        delim = "$") {

  # Overhead ----------------------------------------------------------------

  # Arguments after dots must be named
  stop_if_dots_text <- paste(
    "Arguments after ... must be named.\n",
    "* Did you forget to write `face = ` or `size = ` ?\n *"
  )
  wrapr::stop_if_dot_args(substitute(list(...)), stop_if_dots_text)

  # Determine the value assigned to size
  if (isTRUE(!is.null(size))) {
    # Use the value from the argument list
    size <- size
  } else {
    # Use the value assigned as an option, otherwise use default
    size <- getOption("formatdown.font.size", default = "small")
  }

  # Determine the value assigned to face
  if (isTRUE(!is.null(face))) {
    # Use the value from the argument list
    face <- face
  } else {
    # Use the value assigned as an option, otherwise use default
    face <- getOption("formatdown.font.face", default = "plain")
  }

  # Indicate these are not unbound symbols (R CMD check Note)
  value <- NULL
  math_markup <- NULL
  size_markup <- NULL

  # Argument checks ---------------------------------------------------------

  # face: character, not missing, length 1, element of set
  checkmate::qassert(face, "S1")
  checkmate::assert_choice(
    face,
    choices = c("plain", "italic", "bold", "sans", "mono")
    )

  # size: character, not missing, length 1, element of set
  checkmate::qassert(size, "S1")
  checkmate::assert_choice(
    size,
    choices = c("scriptsize", "small", "normalsize", "large", "huge")
  )

  # delim: character, not missing, length 1 or 2, not empty
  checkmate::qassert(delim, "S+")
  checkmate::assert_true(!"" %in% delim)
  checkmate::assert_true(length(delim) <= 2)

  # Initial processing ------------------------------------------------------

  # Convert vector to data.table for processing
  DT <- data.table::copy(data.frame(x))
  setDT(DT)

  # Typeface format for math markup ------------------------------------------
  if(face == "plain")  math_markup  <- "\\mathrm"
  if(face == "italic") math_markup  <- "\\mathit"
  if(face == "bold")   math_markup  <- "\\mathbf"
  if(face == "sans")   math_markup  <- "\\mathsf"
  if(face == "mono")   math_markup  <- "\\mathtt"

  # Size format for math markup ----------------------------------------------
  if(size == "huge")       size_markup  <- "\\huge"
  if(size == "large")      size_markup  <- "\\large"
  if(size == "normalsize") size_markup  <- "\\normalsize"
  if(size == "small")      size_markup  <- "\\small"
  if(size == "scriptsize") size_markup  <- "\\scriptsize"

  # Construct character string
  DT[, value := paste0(size_markup, math_markup, "{", x, "}")]

  # Surround with math delimiters (see utils.R)
  DT <- add_delim(DT, col_name = "value", delim = delim)

  # Output ------------------------------------------------------

  # Convert to vector output
  DT <- DT[, (value)]

  # enable printing (see data.table FAQ 2.23)
  DT[]
  return(DT)
}
