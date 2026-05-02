test_multiply_mark <- function() {

  # Option: multiply_mark
  #         format_numbers(..., format = c("sci", "engr"))
  #         format_sci()
  #         format_engr()

  # Possible values are
  #         "\\times"
  #         "\\cdot""

  x <- 6.0221e+23
  ans101 <- "$6.022 \\times 10^{23}$"
  expect_equal(ans101, format_sci(x))
  expect_equal(ans101, format_sci(x, multiply_mark = "\\times"))

  ans102 <- "$6.022 \\cdot 10^{23}$"
  expect_equal(ans102, format_sci(x, multiply_mark = "\\cdot"))

  # vector input
  x <- c(1.2, 103400)
  ans103 <- c("$1.200$", "$103.4 \\times 10^{3}$")
  expect_equal(ans103, format_engr(x, decimal_mark = ".", multiply_mark = "\\times"))
  ans104 <- c("$1,200$", "$103,4 \\cdot 10^{3}$")
  expect_equal(ans104, format_engr(x, decimal_mark = ",", multiply_mark = "\\cdot"))

  # errors
  expect_error(format_sci(x, multiply_mark = NA))
  expect_error(format_sci(x, multiply_mark = NULL))
  expect_error(format_sci(x, multiply_mark = 0))
  expect_error(format_sci(x, multiply_mark = TRUE))

  # function output not printed
  invisible(NULL)
}

test_multiply_mark()
