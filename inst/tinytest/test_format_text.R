test_format_text<- function() {

  # usage
  # format_text(x, ..., face = NULL, size = NULL, delim = "$")
  # arguments after dots must be named

  # Needed for tinytest::build_install_test()
  suppressPackageStartupMessages(library(data.table))

  # character vector
  x <- c("a", "b", "c")
  ans1 <- c("$\\mathrm{a}$", "$\\mathrm{b}$", "$\\mathrm{c}$")
  expect_equal(format_text(x), ans1)

  # character vector
  x <- c("1.2E-3", "3.4E+0", "5.6E+3")
  ans2 <- c("$\\mathrm{1.2E-3}$", "$\\mathrm{3.4E+0}$", "$\\mathrm{5.6E+3}$")
  expect_equal(format_text(x), ans2)

  # numeric coerced to text
  x <- c(1.2, 2.3, 3.4)
  ans3 <- c("$\\mathrm{1.2}$", "$\\mathrm{2.3}$", "$\\mathrm{3.4}$")
  expect_equal(format_text(x), ans3)

  # logical coerced to text
  x <- c(TRUE, FALSE, TRUE)
  ans4 <- c("$\\mathrm{TRUE}$", "$\\mathrm{FALSE}$", "$\\mathrm{TRUE}$")
  expect_equal(format_text(x), ans4)

  # NA treated as character, NULL ignored
  x <- c(NA, NULL)
  ans5a <- c("$\\mathrm{NA}$")
  expect_equal(format_text(x), ans5a)

  # NULL alone, character, length 0
  x <- NULL
  ans5b <- 0
  expect_equal(length(format_text(x)), ans5b)

  # face options c("plain", "italic", "bold", "sans", "mono")
  x <- "A"
  expect_equal(format_text(x), format_text(x, face = "plain"))
  # expect_equal(format_text(x), format_text(x, face = NA_character_))
  ans6a <-"$\\mathrm{A}$"
  expect_equal(format_text(x, face = "plain"),  ans6a)
  ans6b <-"$\\mathit{A}$"
  expect_equal(format_text(x, face = "italic"), ans6b)
  ans6c <-"$\\mathbf{A}$"
  expect_equal(format_text(x, face = "bold"),   ans6c)
  ans6d <-"$\\mathsf{A}$"
  expect_equal(format_text(x, face = "sans"),   ans6d)
  ans6e <-"$\\mathtt{A}$"
  expect_equal(format_text(x, face = "mono"),   ans6e)

  # size options, choices = c("scriptsize", "small", "normalsize", "large", "huge")
  x <- "A"
  ans7z <-"$\\mathrm{A}$"
  expect_equal(format_text(x),                       ans7z)
  expect_equal(format_text(x, size = NA_character_), ans7z)

  ans7a <-"$\\scriptsize \\mathrm{A}$"
  expect_equal(format_text(x, size = "scriptsize"),  ans7a)

  ans7b <-"$\\small \\mathrm{A}$"
  expect_equal(format_text(x, size = "small"),       ans7b)

  ans7c <-"$\\normalsize \\mathrm{A}$"
  expect_equal(format_text(x, size = "normalsize"),  ans7c)

  ans7d <-"$\\large \\mathrm{A}$"
  expect_equal(format_text(x, size = "large"),       ans7d)

  ans7e <-"$\\huge \\mathrm{A}$"
  expect_equal(format_text(x, size = "huge"),        ans7e)

  # Delimiter options
  x   <- "a"
  ans8 <- c("$\\mathrm{a}$")
  expect_equal(format_text(x, delim = "$"), ans8)
  expect_equal(format_text(x, delim = c("$", "$")), ans8)

  ans9 <- c("\\(\\mathrm{a}\\)")
  expect_equal(format_text(x, delim = "\\("), ans9)
  expect_equal(format_text(x, delim = c("\\(", "\\)")), ans9)

  # Data frame, one column as vector
  x   <- air_meas[, (humid)]
  ans10 <- c("$\\mathrm{low}$",
           "$\\mathrm{high}$",
           "$\\mathrm{med}$",
           "$\\mathrm{low}$",
           "$\\mathrm{high}$")
  expect_equal(format_text(x), ans10)

  # OPTIONS ------------------------
  formatdown_options(size = "large", delim = "\\(")

  ans11 <- formatdown_options("size")
  expect_equal("large", ans11)

  ans12 <- formatdown_options("delim")
  expect_equal("\\(", ans12)

  x <- "A"
  ans13 <- "\\(\\large \\mathrm{A}\\)"
  expect_equal(format_text(x), ans13)

  # reset to defaults
  reset_formatdown_options()

  # ERRORS  ------------------------
  # Errors for incorrect x argument
  expect_error(format_text(x = air_meas))

  # Errors for incorrect face argument
  expect_error(format_text(x, face = c(3, 4)))
  expect_error(format_text(x, face = "bold.italic"))
  expect_error(format_text(x, face = TRUE))


  # Errors for incorrect size argument
  expect_error(format_text(x, size = c(3, 4)))
  expect_error(format_text(x, size = "Huge"))
  expect_error(format_text(x, size = TRUE))


  # Errors for incorrect delim argument
  expect_error(format_text(x, delim = c("")))
  expect_error(format_text(x, delim = 1))
  expect_error(format_text(x, delim = c("$", "$", "$")))
  expect_error(format_text(x, delim = NA_character_))

  # arguments after dots must be named
  expect_error(format_text(x, face = "plain", "small"))
  expect_error(format_text(x, face = "plain", size = "small", "$"))

  # function output not printed
  invisible(NULL)
}

test_format_text()
