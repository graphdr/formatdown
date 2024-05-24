test_size <- function() {

  # Option: size
  #         format_numbers()
  #         format_sci()
  #         format_engr()
  #         format_dcml()
  #         format_text()

  # Possible values are
  #         NA_character_
  #         "scriptsize"
  #         "small"
  #         "normalsize"
  #         "large"
  #         "huge"

  # correct behaviors
  x <- 123
  ans101 <- "$123$"
  expect_equal(ans101, format_numbers(x, 3))
  expect_equal(ans101, format_numbers(x, 3, size = NULL))
  expect_equal(ans101, format_numbers(x, 3, size = NA_character_))

  ans102 <- "$\\scriptsize 123$"
  expect_equal(ans102, format_numbers(x, 3, size = "scriptsize"))
  expect_equal(ans102, format_sci(x, 3, size = "scriptsize"))
  expect_equal(ans102, format_engr(x, 3, size = "scriptsize"))
  expect_equal(ans102, format_dcml(x, 3, size = "scriptsize"))

  ans103 <- "$\\small 123$"
  expect_equal(ans103, format_numbers(x, 3, size = "small"))
  expect_equal(ans103, format_sci(x, 3, size = "small"))
  expect_equal(ans103, format_engr(x, 3, size = "small"))
  expect_equal(ans103, format_dcml(x, 3, size = "small"))

  ans104 <- "$\\normalsize 123$"
  expect_equal(ans104, format_numbers(x, 3, size = "normalsize"))
  expect_equal(ans104, format_sci(x, 3, size = "normalsize"))
  expect_equal(ans104, format_engr(x, 3, size = "normalsize"))
  expect_equal(ans104, format_dcml(x, 3, size = "normalsize"))

  ans105 <- "$\\large 123$"
  expect_equal(ans105, format_numbers(x, 3, size = "large"))
  expect_equal(ans105, format_sci(x, 3, size = "large"))
  expect_equal(ans105, format_engr(x, 3, size = "large"))
  expect_equal(ans105, format_dcml(x, 3, size = "large"))

  ans106 <- "$\\huge 123$"
  expect_equal(ans106, format_numbers(x, 3, size = "huge"))
  expect_equal(ans106, format_sci(x, 3, size = "huge"))
  expect_equal(ans106, format_engr(x, 3, size = "huge"))
  expect_equal(ans106, format_dcml(x, 3, size = "huge"))

  x <- "hello world"

  ans107 <- "$\\scriptsize \\mathrm{hello\\ world}$"
  expect_equal(ans107, format_text(x, size = "scriptsize"))

  ans108 <- "$\\small \\mathrm{hello\\ world}$"
  expect_equal(ans108, format_text(x, size = "small"))

  ans109 <- "$\\normalsize \\mathrm{hello\\ world}$"
  expect_equal(ans109, format_text(x, size = "normalsize"))

  ans110 <- "$\\large \\mathrm{hello\\ world}$"
  expect_equal(ans110, format_text(x, size = "large"))

  ans111 <- "$\\huge \\mathrm{hello\\ world}$"
  expect_equal(ans111, format_text(x, size = "huge"))

  # vector input
  x <- c(123, 4.56e+11)
  ans112 <- c("$\\small 123$", "$\\small 456 \\times 10^{9}$")
  expect_equal(ans112, format_numbers(x, 3, size = "small"))

  # errors
  expect_error(format_numbers(11, size = ""))
  expect_error(format_numbers(11, size = "LARGE"))
  expect_error(format_text("A"  , size = ""))

  # function output not printed
  invisible(NULL)
}

test_size()
