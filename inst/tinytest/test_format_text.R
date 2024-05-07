test_format_text<- function() {

  # All tests, e.g., expect_equal, expect_error, etc., are from the
  # tinytest package. Possible test functions listed at
  # https://github.com/markvanderloo/tinytest/blob/master/pkg/README.md

  # usage
  # format_text(x, ..., face = NULL, size = NULL, delim = "$")
  # arguments after dots must be named

  # correct behaviors

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

  # Data frame, one column as vector
  x   <- air_meas[, (humid)]
  ans10 <- c("$\\mathrm{low}$",
           "$\\mathrm{high}$",
           "$\\mathrm{med}$",
           "$\\mathrm{low}$",
           "$\\mathrm{high}$")
  expect_equal(format_text(x), ans10)

  # ERRORS  ------------------------
  x <- "hello world"

  # arguments of incorrect class
  expect_error(format_text(x = air_meas))
  expect_error(format_text(x, face = TRUE))

  # arguments not among allowed choices
  expect_error(format_text(x, face = c("plain", "bold")))
  expect_error(format_text(x, face = "bold.italic"))

  # arguments after dots must be named
  expect_error(format_text(x, "plain", "small"))
  expect_error(format_text(x, "plain", size = "small", "$"))
  expect_error(format_text(x, "plain", size = "small", delim = "$", "\\\\>"))

  # function output not printed
  invisible(NULL)
}

test_format_text()
