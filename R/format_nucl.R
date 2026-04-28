
#' Format isotopes in nuclear notation
#'
#' Convert chemical element or isotope from from hyphenated notation to
#' nuclear notation.
#'
#' We start with a character string in hyphenated form _X-A_ where _X_ is the
#' chemical symbol of an element and _A_ is its mass number.
#' For example, carbon 12 would be written as the string `"C-12"`.
#'
#' Given a character scalar, vector, or data frame column of isotopes in
#' this form, `format_nucl()` constructs the form `"$\\mathxx{^{A}X}$"` where
#' `\\mathxx` determines the font face: plain type is set by `\\mathrm`; italic
#' by `\\mathit`; bold by `\\mathbf`; sans serif by `\\mathsf`; and monospace
#' (typewriter text) by `\\mathtt`. The result includes markup delimiters `$...$`
#' for rendering (in an R markdown or Quarto markdown document) as an inline
#' code chunk.
#'
#' Unlike other functions in formatdown, `format_nucl()` does not support a
#' `size` argument.
#'
#' @param x Character. Hyphenated form of chemical elements or isotopes.
#'          Can be a single character string or a vector of strings. Must
#'          include a single hyphen between the element symbol and the mass
#'          number. For example, carbon 12 in hyphenated notation is the
#'          character string `"C-12"`.
#'
#' @param face `r param_face`
#'
#' @param ... `r param_dots`
#'
#' @param Z T/F add the atomic number. For details,
#'         see the help page for `formatdown_options()`.
#'
#' @param warn T/F issue warning for incorrect input `x`. For details,
#'         see the help page for `formatdown_options()`.
#'
#' @param delim The math-delimiter. For details, see the help page for
#'        `formatdown_options()`.
#'
#' @return A character vector of isotopes in nuclear notation with elements
#'         delimited as inline math markup in plain, italic, sans serif,
#'         bold, or monospace font face.
#'
#' @family format_*
#' @export
format_nucl <- function(x,
                        face = "plain",
                        ...,
                        Z = formatdown_options("Z"),
                        warn = formatdown_options("warn"),
                        delim = formatdown_options("delim")) {

  # Arguments after dots must be named
  wrapr::stop_if_dot_args(substitute(list(...)), "format_nucl()")

  # Indicate these are not unbound symbols (R CMD check Note)
  hyphenated <- NULL
  atomic_number <- NULL
  mass_number <- NULL
  symbol <- NULL
  value <- NULL
  element_set <- element_set # built-in data set

  # Argument checks ---------------------------------------------------------

  # x: character, missing values prohibited, length at least 1
  checkmate::qassert(x, "S+")

  # Z & warn: logical, missing values prohibited, length exactly 1
  checkmate::qassert(Z, "B1")
  checkmate::qassert(warn, "B1")

  # face: character, not missing, length 1, element of set
  checkmate::qassert(face, "S1")
  checkmate::assert_choice(face, choices = c("plain",
                                             "italic",
                                             "bold",
                                             "sans",
                                             "mono"))

  # do the work ---------------------------------------------------------
  df <- data.frame(x)
  DT <- data.frame(tstrsplit(df$x,
                             split = '-',
                             fixed = TRUE,
                             names = c("symbol", "mass_number")))
  setDT(DT)

  # left-join atomic numbers
  DT <- element_set[DT, , on = c("symbol", "mass_number")]

  # identify rows with errors
  z_na <- is.na(DT$atomic_number)

  # replace NA atomic numbers with "Z" for output
  DT <- DT[z_na, atomic_number := "Z"]

  # error warning if any
  if (isTRUE(warn) & sum(z_na) > 0){

    # reassemble hyphenated form for warning statement
    err_rows <- DT[z_na, list(symbol, mass_number)]
    err_rows <- err_rows[, hyphenated := paste0(symbol, "-", mass_number)]
    err_vals <- err_rows[, list(hyphenated)]

    warning(paste("Incorrect chemical symbol or mass number in ", err_vals))
  }

  if (Z) {# include atomic number

    DT[, value := paste0("\\^{\\small ", mass_number  , "}",
                         "\\_{\\small ", atomic_number, "}",
                         symbol)]

  } else {# omit atomic number

    DT[, value := paste0("\\^{\\small ", mass_number, "}", symbol)]

  }

  # then call format_text()
  DT <- DT[, value := format_text(value, face = face)]

  # Convert to vector output
  DT <- DT[, (value)]
  DT[]

}
