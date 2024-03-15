test_format_text<- function() {

  # usage
  # format_text(x, ..., face = NULL, size = NULL, delim = "$")
  # arguments after dots must be named

  # Needed for tinytest::build_install_test()
  suppressPackageStartupMessages(library(data.table))

  # character vector
  x <- c("a", "b", "c")
  ans1 <- c("$\\small\\mathrm{a}$", "$\\small\\mathrm{b}$", "$\\small\\mathrm{c}$")
  expect_equal(format_text(x), ans1)

  # character vector
  x <- c("1.2E-3", "3.4E+0", "5.6E+3")
  ans2 <- c("$\\small\\mathrm{1.2E-3}$", "$\\small\\mathrm{3.4E+0}$", "$\\small\\mathrm{5.6E+3}$")
  expect_equal(format_text(x), ans2)

  # numeric coerced to text
  x <- c(1.2, 2.3, 3.4)
  ans3 <- c("$\\small\\mathrm{1.2}$", "$\\small\\mathrm{2.3}$", "$\\small\\mathrm{3.4}$")
  expect_equal(format_text(x), ans3)

  # logical coerced to text
  x <- c(TRUE, FALSE, TRUE)
  ans4 <- c("$\\small\\mathrm{TRUE}$", "$\\small\\mathrm{FALSE}$", "$\\small\\mathrm{TRUE}$")
  expect_equal(format_text(x), ans4)

  # NA treated as character, NULL ignored
  x <- c(NA, NULL)
  ans5a <- c("$\\small\\mathrm{NA}$")
  expect_equal(format_text(x), ans5a)

  # NULL alone
  x <- c(NULL)
  ans5b <- c("$\\small\\mathrm{}$")
  expect_equal(format_text(x), ans5b)

  # face options c("plain", "italic", "bold", "sans", "mono")
  x <- "A"
  expect_equal(format_text(x), format_text(x, face = "plain"))
  ans6a <-"$\\small\\mathrm{A}$"
  expect_equal(format_text(x, face = "plain"),  ans6a)
  ans6b <-"$\\small\\mathit{A}$"
  expect_equal(format_text(x, face = "italic"), ans6b)
  ans6c <-"$\\small\\mathbf{A}$"
  expect_equal(format_text(x, face = "bold"),   ans6c)
  ans6d <-"$\\small\\mathsf{A}$"
  expect_equal(format_text(x, face = "sans"),   ans6d)
  ans6e <-"$\\small\\mathtt{A}$"
  expect_equal(format_text(x, face = "mono"),   ans6e)

  # size options, choices = c("scriptsize", "small", "normalsize", "large", "huge")
  x <- "A"
  expect_equal(format_text(x), format_text(x, size = "small"))
  ans7a <-"$\\scriptsize\\mathrm{A}$"
  expect_equal(format_text(x, size = "scriptsize"), ans7a)
  ans7b <-"$\\small\\mathrm{A}$"
  expect_equal(format_text(x, size = "small"),      ans7b)
  ans7c <-"$\\normalsize\\mathrm{A}$"
  expect_equal(format_text(x, size = "normalsize"), ans7c)
  ans7d <-"$\\large\\mathrm{A}$"
  expect_equal(format_text(x, size = "large"),      ans7d)
  ans7e <-"$\\huge\\mathrm{A}$"
  expect_equal(format_text(x, size = "huge"),       ans7e)

  # Delimiter options
  x   <- "a"
  ans8 <- c("$\\small\\mathrm{a}$")
  expect_equal(format_text(x, delim = "$"), ans8)
  expect_equal(format_text(x, delim = c("$", "$")), ans8)

  ans9 <- c("\\(\\small\\mathrm{a}\\)")
  expect_equal(format_text(x, delim = "\\("), ans9)
  expect_equal(format_text(x, delim = c("\\(", "\\)")), ans9)

  # Data frame, one column as vector
  x   <- air_meas[, (humid)]
  ans10 <- c("$\\small\\mathrm{low}$",
           "$\\small\\mathrm{high}$",
           "$\\small\\mathrm{med}$",
           "$\\small\\mathrm{low}$",
           "$\\small\\mathrm{high}$")
  expect_equal(format_text(x), ans10)

  # OPTIONS ------------------------
  # size
  opt <- getOption("formatdown.font.size")
  options(formatdown.font.size = "large")

  ans11 <- getOption("formatdown.font.size")
  expect_equal("large", ans11)

  x <- "A"
  ans12 <- "$\\large\\mathrm{A}$"
  expect_equal(format_text(x), ans12)

  # reset to current setting
  options(formatdown.font.size = opt)

  # face
  opt <- getOption("formatdown.font.face")
  options(formatdown.font.face = "mono")

  ans13 <- getOption("formatdown.font.face")
  expect_equal("mono", ans13)

  x <- "A"
  ans14 <- "$\\small\\mathtt{A}$"
  expect_equal(format_text(x), ans14)

  # reset to current setting
  options(formatdown.font.face = opt)

  # ERRORS  ------------------------
  # Errors for incorrect x argument
  expect_error(format_text(x = air_meas))

  # Errors for incorrect face argument
  expect_error(format_text(x, face = c(3, 4)))
  expect_error(format_text(x, face = "bold.italic"))
  expect_error(format_text(x, face = TRUE))
  expect_error(format_text(x, face = NA_character_))

  # Errors for incorrect size argument
  expect_error(format_text(x, size = c(3, 4)))
  expect_error(format_text(x, size = "Huge"))
  expect_error(format_text(x, size = TRUE))
  expect_error(format_text(x, size = NA_character_))

  # Errors for incorrect delim argument
  expect_error(format_text(x, delim = c("")))
  expect_error(format_text(x, delim = 1))
  expect_error(format_text(x, delim = c("$", "$", "$")))
  expect_error(format_text(x, delim = NA_character_))

  # arguments after dots must be named
  expect_error(format_text(x, "plain"))
  expect_error(format_text(x, face = "plain", "small"))
  expect_error(format_text(x, face = "plain", size = "small", "$"))

  # function output not printed
  invisible(NULL)
}

test_format_text()
