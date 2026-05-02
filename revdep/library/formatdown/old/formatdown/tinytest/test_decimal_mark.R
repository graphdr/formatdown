test_decimal_mark <- function() {

  # Option: decimal_mark
  #         format_numbers()
  #         format_sci()
  #         format_engr()
  #         format_dcml()

  # Possible values are
  #         "."
  #         ","

  # correct behaviors
  x <- 6.0221e+23

  ans101 <- "$602.2 \\times 10^{21}$"
  expect_equal(ans101, format_numbers(x))
  expect_equal(ans101, format_numbers(x, decimal_mark = "."))

  ans102 <- "$602,2 \\times 10^{21}$"
  expect_equal(ans102, format_numbers(x, decimal_mark = ","))

  x <- pi

  ans103 <- "$3.142$"
  expect_equal(ans103, format_numbers(x))
  expect_equal(ans103, format_numbers(x, decimal_mark = "."))
  expect_equal(ans103, format_engr(x   , decimal_mark = "."))
  expect_equal(ans103, format_sci(x    , decimal_mark = "."))
  expect_equal(ans103, format_dcml(x   , decimal_mark = "."))

  ans104 <- "$3,142$"
  expect_equal(ans104, format_numbers(x, decimal_mark = ","))
  expect_equal(ans104, format_engr(x   , decimal_mark = ","))
  expect_equal(ans104, format_sci(x    , decimal_mark = ","))
  expect_equal(ans104, format_dcml(x   , decimal_mark = ","))

  # vector input
  x <- c(pi, pi*1e+11)
  ans105 <- c("$3,142$", "$314,2 \\times 10^{9}$")
  expect_equal(ans105, format_numbers(x, decimal_mark = ","))

  # errors

  expect_error(format_numbers(pi, decimal_mark = ""))
  expect_error(format_numbers(pi, decimal_mark = " "))
  expect_error(format_numbers(pi, decimal_mark = NULL))
  expect_error(format_numbers(pi, decimal_mark = NA))
  expect_error(format_numbers(pi, decimal_mark = "\\,"))

  # function output not printed
  invisible(NULL)
}

test_decimal_mark()
