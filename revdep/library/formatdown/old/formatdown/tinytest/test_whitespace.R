test_whitespace <- function() {

  # Option: whitespace
  #         format_numbers() with input class units
  #         format_sci()
  #         format_engr()
  #         format_dcml()
  #         format_text()

  # Possible values are
  #         "\\\\>"
  #         "\\\\:"
  #         "⁠\\\\ ⁠"

  # correct behaviors
  x <- "hello world"

  ans701 <- "$\\mathrm{hello\\>world}$"
  expect_equal(ans701, format_text(x))
  expect_equal(ans701, format_text(x, whitespace = "\\\\>"))

  ans702 <- "$\\mathrm{hello\\:world}$"
  expect_equal(ans702, format_text(x, whitespace = "\\\\:"))

  ans703 <- "$\\mathrm{hello\\ world}$"
  expect_equal(ans703, format_text(x, whitespace = "\\\\ "))

  # numeric input with units
  x <- pi
  units(x) <- "rad/s"

  ans704 <- "$3.142\\>\\mathrm{rad\\>s^{-1}}$"
  expect_equal(ans704, format_dcml(x))

  ans705 <- "$3.142\\:\\mathrm{rad\\:s^{-1}}$"
  expect_equal(ans705, format_dcml(x, whitespace = "\\\\:"))

  ans706 <- "$3.142\\ \\mathrm{rad\\ s^{-1}}$"
  expect_equal(ans706, format_dcml(x, whitespace = "\\\\ "))

  # vector input
  x <- c("hello world", "goodbye farm")
  ans707 <- c("$\\mathrm{hello\\>world}$", "$\\mathrm{goodbye\\>farm}$")
  expect_equal(ans707, format_text(x, whitespace = "\\\\>"))

  # errors
  expect_error(format_text(x, whitespace = NA))
  expect_error(format_text(x, whitespace = NULL))
  expect_error(format_text(x, whitespace = 0))
  expect_error(format_text(x, whitespace = TRUE))

  # function output not printed
  invisible(NULL)
}

test_whitespace()
