test_formatdown_options <- function() {

  # All tests, e.g., expect_equal, expect_error, etc., are from the
  # tinytest package. Possible test functions listed at
  # https://github.com/markvanderloo/tinytest/blob/master/pkg/README.md

  # defaults              possibles
  # delim = "$".          "\(" or c("$", "$") or c("\\(", "\\)")
  # size = NULL.          "scriptsize", "small", "normalsize", "large", and "huge"
  # decimal_mark = "."    ","
  # big_mark = ""         "thin" or "\\\\,"
  # big_interval = 3      any positive integer
  # small_mark = ""       "thin" or "\\\\,"
  # small_interval = 5    any positive integer
  # whitespace = "\\\\>"  "\\\\:" or "⁠\\\\ ⁠".

  # Store existing settings
  prior_settings <- formatdown_options()

  # Reset to default settings
  formatdown_options(reset = TRUE)

  x <- 6.0221e+23

  # delim
  ans901 <- "$"
  expect_equal(ans901, formatdown_options("delim"))

  formatdown_options(delim = "\\(")
  ans902 <- "\\(602.2 \\times 10^{21}\\)"
  expect_equal(ans902, format_numbers(x))
  formatdown_options(reset = TRUE)

  # size
  ans903 <- NULL
  expect_equal(ans903, formatdown_options("size"))

  formatdown_options(size = "small")
  ans904 <- "$\\small 602.2 \\times 10^{21}$"
  expect_equal(ans904, format_numbers(x))
  formatdown_options(reset = TRUE)

  # decimal_mark
  ans905 <- "."
  expect_equal(ans905, formatdown_options("decimal_mark"))

  formatdown_options(decimal_mark = ",")
  ans906 <- "$602,2 \\times 10^{21}$"
  expect_equal(ans906, format_numbers(x))
  formatdown_options(reset = TRUE)

  # big_mark
  x <- 123400
  ans907 <- ""
  expect_equal(ans907, formatdown_options("big_mark"))

  formatdown_options(big_mark = "thin")
  ans908 <- "$123\\,400$"
  expect_equal(ans908, format_dcml(x))
  formatdown_options(reset = TRUE)

  # big_interval
  ans909 <- 3
  expect_equal(ans909, formatdown_options("big_interval"))

  formatdown_options(big_interval = 4)
  ans910 <- "$12\\,3400$"
  expect_equal(ans910, format_dcml(x, big_mark = "thin"))
  formatdown_options(reset = TRUE)

  # small_mark
  x <- 0.9876543211
  ans911 <- ""
  expect_equal(ans911, formatdown_options("small_mark"))

  formatdown_options(small_mark = "thin")
  ans912 <- "$0.98765\\,43211$"
  expect_equal(ans912, format_dcml(x, 10))
  formatdown_options(reset = TRUE)

  # small_interval
  ans913 <- 5
  expect_equal(ans913, formatdown_options("small_interval"))

  formatdown_options(small_interval = 4)
  ans914 <- "$0.9876\\,5432\\,11$"
  expect_equal(ans914, format_dcml(x, 10, small_mark = "thin"))
  formatdown_options(reset = TRUE)

  # whitespace
  ans915 <- "\\\\ "
  expect_equal(ans915, formatdown_options("whitespace"))

  x <- "hello world"
  formatdown_options(whitespace = "\\\\:")
  ans916 <- "$\\mathrm{hello\\:world}$"
  expect_equal(ans916, format_text(x))

  x <- pi
  units(x) <- "m s-2"
  ans917 <- "$3.142\\:\\mathrm{m\\:s^{-2}}$"
  expect_equal(ans917, format_dcml(x))
  formatdown_options(reset = TRUE)

  # set multiple options
  x <- 0.9876543211
  formatdown_options(decimal_mark = ",", small_mark = "thin", small_interval = 4)
  ans918 <- "$0,9876\\,5432\\,11$"
  expect_equal(ans918, format_dcml(x, 10))
  formatdown_options(reset = TRUE)

  # ERRORS  ------------------------
  expect_error(formatdown_options("x"))
  expect_error(formatdown_options("digits"))
  expect_error(formatdown_options("format"))
  expect_error(formatdown_options("omit_power"))
  expect_error(formatdown_options("set_power"))
  expect_error(formatdown_options("face"))
  formatdown_options(reset = TRUE)

  # reset options to those before this test
  do.call(formatdown_options, prior_settings)

  # confirm that rest-settings equal prior-settings
  do_call_settings <- formatdown_options()
  expect_equal(do_call_settings, prior_settings)



  # function output not printed
  invisible(NULL)
}

test_formatdown_options()
