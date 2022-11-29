test_format_decimal <- function() {

  # usage
  # format_decimal(x, digits = 4, ..., big_mark = NULL, delim = "$")
  # arguments after dots must be named

  # Needed for tinytest::build_install_test()
  suppressPackageStartupMessages(library(data.table))

  # Equivalent usage, named, unnamed, default
  x <- 1.12344
  ans <- "$1.1234$"
  expect_equal(format_decimal(x = x, digits = 4), ans)
  expect_equal(format_decimal(x, 4), ans)
  expect_equal(format_decimal(x), ans)

  # Decimal digits
  x <- 1.12344
  expect_equal(format_decimal(x, digits = 3), "$1.123$")
  expect_equal(format_decimal(x, digits = 0), "$1$")

  # big_mark
  x <- 123456789.123
  expect_equal(format_decimal(x, 0), "$123456789$")
  expect_equal(format_decimal(x, 0, big_mark = ","), "$123,456,789$")

  # Delimiter options
  x <- 1.1234321
  ans <- "$1.1234$"
  expect_equal(format_decimal(x, delim = "$"), ans)
  expect_equal(format_decimal(x, delim = c("$", "$")), ans)

  ans <- "\\(1.1234\\)"
  expect_equal(format_decimal(x, delim = "\\("), ans)
  expect_equal(format_decimal(x, delim = c("\\(", "\\)")), ans)

  ans <- "\\[1.1234\\]"
  expect_equal(format_decimal(x, delim = c("\\[", "\\]")), ans)

  # Data frame column
  ans <- data.table(wrapr::build_frame(
    "dens" |
      "$1.198$"  |
      "$1.196$"  |
      "$1.196$"  |
      "$1.200$"  |
      "$1.199$"  ))
  DT <- air_meas[, .(dens)]
  DT[, dens := lapply(.SD, function(x) format_decimal(x, 3))]
  expect_equal(DT, ans)

  # Data frame column as vector
  ans <- ans[, (dens)]
  vec <- air_meas[, (dens)]
  vec <- format_decimal(vec, 3)

  # Negative number are OK
  x <- c(-1.02, -0.18)
  ans <- c("$-1.02$", "$-0.18$")
  expect_equal(format_decimal(x, 2), ans)

  # Zero is OK
  x <- 0L
  expect_equal(format_decimal(x, 0), "$0$")
  x <- c(0, 0.1)
  expect_equal(format_decimal(x, 1), c("$0.0$", "$0.1$"))


  # x argument type errors
  expect_error(format_decimal(x = as.Date("2020-11-24")))
  expect_error(format_decimal(x = as.factor(1)))
  expect_error(format_decimal(x = TRUE))
  expect_error(format_decimal(x = NULL))
  expect_error(format_decimal(x = "1"))
  expect_error(format_decimal(x = NA))

  # digits argument type and length errors
  x <- 1.1234
  expect_error(format_decimal(x, digits = as.Date("2020-11-24")))
  expect_error(format_decimal(x, digits = as.factor(1)))
  expect_error(format_decimal(x, digits = c(1, 2)))
  expect_error(format_decimal(x, digits = TRUE))
  expect_error(format_decimal(x, digits = NULL))
  expect_error(format_decimal(x, digits = "1"))
  expect_error(format_decimal(x, digits = NA))

  # big_mark argument type and length errors
  x <- 101202
  expect_error(format_decimal(x, 0, big_mark = as.Date("2020-11-24")))
  expect_error(format_decimal(x, 0, big_mark = as.factor(1)))
  expect_error(format_decimal(x, 0, big_mark = c(",", ".")))
  expect_error(format_decimal(x, 0, big_mark = TRUE))
  expect_error(format_decimal(x, 0, big_mark = 1))

  # delim argument type and length errors
  x <- 101202
  expect_error(format_decimal(x, 0, delim = as.Date("2020-11-24")))
  expect_error(format_decimal(x, 0, delim = c("$", "$", "$")))
  expect_error(format_decimal(x, 0, delim = as.factor(1)))
  expect_error(format_decimal(x, 0, delim = c(1, 2)))
  expect_error(format_decimal(x, 0, delim = TRUE))
  expect_error(format_decimal(x, 0, delim = NULL))
  expect_error(format_decimal(x, 0, delim = NA))

  # arguments after dots must be named
  expect_error(format_decimal(x, 0, ","))
  expect_error(format_decimal(x, 0, big_mark = ",", "$"))

  # function output not printed
  invisible(NULL)
}

test_format_decimal()
