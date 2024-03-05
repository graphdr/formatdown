test_format_power<- function() {

  # usage
  # format_power(x, digits = 3, ..., format = "engr", omit_power = c(-1, 2))
  # arguments after dots must be named

  # Needed for tinytest::build_install_test()
  suppressPackageStartupMessages(library(data.table))

  # Avogadro's number
  avogadro <- 6.0221E+23

  # Equivalent usage, named, unnamed, default
  x   <- avogadro
  ans <- "$602.2 \\times 10^{21}$"
  expect_equal(format_power(x = x, digits = 4), ans)
  expect_equal(format_power(x, 4), ans)
  expect_equal(format_power(x), ans)

  # Significant digits
  x   <- avogadro
  ans <- "$602 \\times 10^{21}$"
  expect_equal(format_power(x, 3), ans)

  # Scientific format
  x   <- avogadro
  ans <- "$6.022 \\times 10^{23}$"
  expect_equal(format_power(x, format = "sci"), ans)

  # Values smaller than machine eps format correctly
  x <- 2e-20
  ans <- "$2.0 \\times 10^{-20}$"
  expect_equal(format_power(x, 2, format = "sci"), ans)

  # Set power
  x   <- avogadro
  ans <- "$0.6022 \\times 10^{24}$"
  expect_equal(format_power(x, set_power = 24, format = "engr"), ans)
  expect_equal(format_power(x, set_power = 24, format = "sci"), ans)
  expect_equal(format_power(x, set_power = 24L), ans)

  x   <- 0.633
  ans <- "$6.33 \\times 10^{-1}$"
  expect_equal(format_power(x, 3, set_power = -1, omit_power = NULL), ans)
  ans <- "$0.633$"
  expect_equal(format_power(x, 3, set_power = -1, omit_power = c(-1, 2)), ans)
  expect_equal(format_power(x, 3, set_power = NA), ans)
  expect_equal(format_power(x, 3, set_power = NULL), ans)

  # Omit power
  x   <- 0.633
  ans <- "$0.633$"
  expect_equal(format_power(x, 3, omit_power = c(-1, 2)), ans)

  x   <- 0.633
  ans <- "$633 \\times 10^{-3}$"
  expect_equal(format_power(x, 3, omit_power = c(0, 2)), ans)

  x   <- 633
  ans <- "$633 \\times 10^{0}$"
  expect_equal(format_power(x, 3, omit_power = c(0, 0)), ans)
  expect_equal(format_power(x, 3, omit_power = NA), ans)
  expect_equal(format_power(x, 3, omit_power = NULL), ans)

  # Omitting a single power of ten
  x <- c(1.2e-4, 3.4e-3, 5.6e-2)
  ans <- c("$1.200 \\times 10^{-4}$", "$0.003400$", "$5.600 \\times 10^{-2}$")
  expect_equal(format_power(x, format = "sci", omit_power = c(-3, -3)), ans)

  # Delimiter options
  x   <- avogadro
  ans <- "$602.2 \\times 10^{21}$"
  expect_equal(format_power(x, delim = "$"), ans)
  expect_equal(format_power(x, delim = c("$", "$")), ans)

  ans <- "\\(602.2 \\times 10^{21}\\)"
  expect_equal(format_power(x, delim = "\\("), ans)
  expect_equal(format_power(x, delim = c("\\(", "\\)")), ans)

  ans <- "\\[602.2 \\times 10^{21}\\]"
  expect_equal(format_power(x, delim = c("\\[", "\\]")), ans)

  # Data frame,one column as vector
  x   <- air_meas[, (pres)]
  ans <- c("$101.1 \\times 10^{3}$",
           "$101.0 \\times 10^{3}$",
           "$101.1 \\times 10^{3}$",
           "$101.0 \\times 10^{3}$",
           "$101.1 \\times 10^{3}$")
  expect_equal(format_power(x), ans)

  # Data frame, selected column in place
  DT  <- air_meas[, .(trial, pres)]
  ans <- data.table(wrapr::build_frame(
    "trial"  , "pres"               |
      "a"    , "$101.1 \\times 10^{3}$" |
      "b"    , "$101.0 \\times 10^{3}$" |
      "c"    , "$101.1 \\times 10^{3}$" |
      "d"    , "$101.0 \\times 10^{3}$" |
      "e"    , "$101.1 \\times 10^{3}$" ))
  cols_we_want <- c("pres")
  DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_power(x)),
           .SDcols = cols_we_want]
  expect_equal(DT, ans)

  # Spaces inserted by formatC are trimmed. In this test, the first number
  # has four characters (the decimal point is a character); formatC() adds
  # spaces to store "800" as " 800". format_power() removes the extra spaces
  # ####### Change to format() from formatC() eliminates this issue.
  x <- 1.0E-6 * c(1.02, 0.8)
  ans <- c("$1.02 \\times 10^{-6}$", "$800 \\times 10^{-9}$")
  expect_equal(format_power(x, 3), ans)

  # Negative number are OK
  x <- -1.0E-6 * c(1.02, 0.8)
  ans <- c("$-1.02 \\times 10^{-6}$", "$-800 \\times 10^{-9}$")
  expect_equal(format_power(x, 3), ans)

  # Errors for incorrect x argument
  expect_error(format_power(x = air_meas))
  expect_error(format_power(x = air_meas$date))
  expect_error(format_power(x = air_meas$trial))
  expect_error(format_power(x = air_meas$humid))
  expect_error(format_power(x = c(TRUE, FALSE)))
  expect_error(format_power(x = NA))
  expect_error(format_power(x = NULL))

  # Errors for incorrect digits argument
  expect_error(format_power(avogadro, digits = c(3, 4)))
  expect_error(format_power(avogadro, digits = NA))
  expect_error(format_power(avogadro, digits = NULL))
  expect_error(format_power(avogadro, digits = "3"))
  expect_error(format_power(avogadro, digits = TRUE))

  # Errors for incorrect format argument
  expect_error(format_power(avogadro, format = NA_character_))
  expect_error(format_power(avogadro, format = NULL))
  expect_error(format_power(avogadro, format = TRUE))
  expect_error(format_power(avogadro, format = 3))
  expect_error(format_power(avogadro, format = c("engr", "sci")))

  # Errors for incorrect set_power argument
  expect_error(format_power(avogadro, set_power = TRUE))
  expect_error(format_power(avogadro, set_power = c(1, 2)))
  expect_error(format_power(avogadro, set_power = "1"))
  expect_error(format_power(avogadro, set_power = as.Date(2020-11-24)))
  expect_error(format_power(avogadro, set_power = as.factor(1)))

  # Errors for incorrect omit_power argument
  expect_error(format_power(avogadro, omit_power = 1))
  expect_error(format_power(avogadro, omit_power = TRUE))
  expect_error(format_power(avogadro, omit_power = c(1, 2, 3)))
  expect_error(format_power(avogadro, omit_power = c(2, -1)))

  # Errors for incorrect delim argument
  expect_error(format_power(x, delim = c("")))
  expect_error(format_power(x, delim = 1))
  expect_error(format_power(x, delim = c("$", "$", "$")))

  # arguments after dots must be named
  expect_error(format_power(avogadro, 4, "engr"))
  expect_error(format_power(avogadro, 4, format = "engr", c(0.1, 1)))

  # function output not printed
  invisible(NULL)
}

test_format_power()
