test_small_mark <- function() {

  # Options: small_mark and small_interval
  #         format_dcml()

  # Possible values are:   default ,  or:
  #         small_mark            "" , "thin" , "\\\\,"
  #         small_interval         5 ,  any positive integer

  # correct behaviors
  x <- 0.9876543211

  # small_mark
  ans601 <- "$0.9877$"
  expect_equal(ans601, format_dcml(x))
  expect_equal(ans601, format_dcml(x, small_mark = ""))
  expect_equal(ans601, format_dcml(x, small_mark = NULL))
  expect_equal(ans601, format_dcml(x, small_mark = NA))

  ans602 <- "$0.98765\\,43211$"
  expect_equal(ans602, format_dcml(x, 10, small_mark = "thin"))
  expect_equal(ans602, format_dcml(x, 10, small_mark = "\\\\,"))

  # small_interval
  ans603 <- "$0.98765\\,43211$"
  expect_equal(ans603, format_dcml(x, 10, small_mark = "thin"))
  expect_equal(ans603, format_dcml(x, 10, small_mark = "thin", small_interval = 5))
  expect_equal(ans603, format_dcml(x, 10, small_mark = "thin", small_interval = 5L))

  ans604 <- "$0.987\\,654\\,321\\,1$"
  expect_equal(ans604, format_dcml(x, 10, small_mark = "thin", small_interval = 3))

  # interactions
  # empty mark ignores interval
  ans605 <- "$0.9877$"
  expect_equal(ans605, format_dcml(x, small_mark = "", small_interval = 3))
  # zero interval overrides mark
  expect_equal(ans605, format_dcml(x, small_mark = "thin", small_interval = 0))
  # mark ignored if interval > no. of digits
  expect_equal(ans605, format_dcml(x, small_mark = "thin", small_interval = 5))

  # vector input
  x <- c(1.9876, 0.54321)
  ans606 <- c("$1.987\\,6$", "$0.543\\,21$")
  expect_equal(ans606, format_dcml(x, 5, small_mark = "thin", small_interval = 3))

  # errors
  expect_error(format_dcml(x, small_mark = ","))
  expect_error(format_dcml(x, small_mark = 0))
  expect_error(format_dcml(x, small_mark = "\\,"))
  expect_error(format_dcml(x, small_mark = "thin", small_interval = 1.5))
  expect_error(format_dcml(x, small_mark = "thin", small_interval = -1))
  expect_error(format_dcml(x, small_mark = "thin", small_interval = Inf))
  expect_error(format_dcml(x, small_mark = "thin", small_interval = NA))
  expect_error(format_dcml(x, small_mark = "thin", small_interval = NULL))

  # function output not printed
  invisible(NULL)
}

test_small_mark()
