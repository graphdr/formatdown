test_format_numbers <- function() {

  # usage
  # format_numbers(x,
  #                digits = 4,
  #                format = "engr",
  #                ...,
  #                omit_power = c(-1, 2),
  #                set_power = NULL,
  #                size = formatdown_options("size"),
  #                delim = formatdown_options("delim"),
  #                decimal_mark = formatdown_options("decimal_mark"),
  #                big_mark = formatdown_options("big_mark"),
  #                small_mark = formatdown_options("small_mark"))

  # Needed for tinytest::build_install_test()
  suppressPackageStartupMessages(library(data.table))

  # Avogadro's number
  avogadro <- 6.0221E+23

  # Equivalent usage, named, unnamed, default
  x   <- avogadro
  ans1 <- "$602.2 \\times 10^{21}$"
  expect_equal(format_numbers(x = x, digits = 4), ans1)
  expect_equal(format_numbers(x, 4), ans1)
  expect_equal(format_numbers(x), ans1)
  expect_equal(format_numbers(x), format_numbers(x, size = NULL))

  # Significant digits
  x   <- avogadro
  ans2 <- "$602 \\times 10^{21}$"
  expect_equal(format_numbers(x, 3), ans2)

  # Scientific format
  x   <- avogadro
  ans3 <- "$6.022 \\times 10^{23}$"
  expect_equal(format_numbers(x, format = "sci"), ans3)

  # Convenience functions
  x   <- avogadro
  expect_equal(format_numbers(x, format = "sci"), format_sci(x))
  expect_equal(format_numbers(x, format = "engr"), format_engr(x))
  expect_equal(format_numbers(x, format = "dcml"), format_dcml(x))

  # Small values format correctly
  x <- 2e-20
  ans4 <- "$2.0 \\times 10^{-20}$"
  expect_equal(format_numbers(x, 2, format = "sci"), ans4)

  # Set power
  x   <- avogadro
  ans5 <- "$0.6022 \\times 10^{24}$"
  expect_equal(format_numbers(x, set_power = 24, format = "engr"), ans5)
  expect_equal(format_numbers(x, set_power = 24, format = "sci"), ans5)
  expect_equal(format_numbers(x, set_power = 24L), ans5)

  x   <- 0.633
  ans6 <- "$6.33 \\times 10^{-1}$"
  expect_equal(format_numbers(x, 3, set_power = -1, omit_power = NULL), ans6)
  expect_equal(format_numbers(x, 3, set_power = -1, omit_power = c(-1, 2)), ans6)
  ans7 <- "$0.633$"
  expect_equal(format_numbers(x, 3, set_power = NA), ans7)
  expect_equal(format_numbers(x, 3, set_power = NULL), ans7)

  # Omit power
  x   <- 0.633
  ans8 <- "$0.633$"
  expect_equal(format_numbers(x, 3, omit_power = c(-1, 2)), ans8)

  x   <- 0.633
  ans9 <- "$633 \\times 10^{-3}$"
  expect_equal(format_numbers(x, 3, omit_power = c(0, 2)), ans9)
  expect_equal(format_numbers(x, 3, omit_power = 0), ans9)

  x   <- 633
  ans10a <- "$633$"
  expect_equal(format_numbers(x, 3, omit_power = 0), ans10a)

  x   <- 633
  ans10b <- "$633 \\times 10^{0}$"
  expect_equal(format_numbers(x, 3, omit_power = NA), ans10b)
  expect_equal(format_numbers(x, 3, omit_power = NULL), ans10b)

  # Combinations of format, set_power, and omit_power
  x <- c(0.00021, 0.0032, 0.043, 0.54, 6.5)
  ans11a <- "$2.1 \\times 10^{-4}$"
  expect_equal(format_numbers(x[1], 2, format = "sci", omit_power = NULL), ans11a)
  expect_equal(format_numbers(x[1], 2, format = "sci", omit_power = -3), ans11a)

  ans11b <- "$210 \\times 10^{-6}$"
  expect_equal(format_numbers(x[1], 2, format = "engr", omit_power = NULL), ans11b)
  expect_equal(format_numbers(x[1], 2, format = "engr", omit_power = -3), ans11b)

  ans11c <- "$3.2 \\times 10^{-3}$"
  expect_equal(format_numbers(x[2], 2, format = "sci", omit_power = NULL), ans11c)
  expect_equal(format_numbers(x[2], 2, format = "engr", omit_power = NULL), ans11c)

  ans11d <- "$0.0032$"
  expect_equal(format_numbers(x[2], 2, format = "sci", omit_power = -3), ans11d)
  expect_equal(format_numbers(x[2], 2, format = "engr", omit_power = -3), ans11d)

  ans11e <- "$4.3 \\times 10^{-2}$"
  expect_equal(format_numbers(x[3], 2, format = "sci", omit_power = -3), ans11e)

  ans11f <- "$43 \\times 10^{-3}$"
  expect_equal(format_numbers(x[3], 2, format = "engr", omit_power = NULL), ans11f)

  ans11g <- "$0.043$"
  expect_equal(format_numbers(x[3], 2, format = "engr", omit_power = -3), ans11g)

  ans11h <- "$6.5 \\times 10^{0}$"
  expect_equal(format_numbers(x[5], 2, format = "sci", omit_power = NULL), ans11h)
  expect_equal(format_numbers(x[5], 2, format = "sci", omit_power = -3), ans11h)
  expect_equal(format_numbers(x[5], 2, format = "engr", omit_power = NULL), ans11h)
  expect_equal(format_numbers(x[5], 2, format = "engr", omit_power = -3), ans11h)

  # set_power overrides omit_power
  x <- 101300
  ans11i <- format_numbers(x, 4, "sci", set_power = 2)
  ans11j <- format_numbers(x, 4, "sci", omit_power = 5, set_power = 2)
  ans11k <- format_numbers(x, 4, "sci", omit_power = 2, set_power = 2)
  expect_equal(ans11i, ans11j)
  expect_equal(ans11i, ans11k)

  # dcml ignores set_power
  x <- 101300
  ans11m <- format_numbers(x, 4, "dcml")
  ans11n <- format_numbers(x, 4, "dcml", set_power = 2)
  # omit_power creates a decimal
  ans11p <- format_numbers(x, 4, "sci", omit_power = 5)
  expect_equal(ans11m, ans11n)
  expect_equal(ans11m, ans11p)

  # Delimiter options
  x   <- avogadro
  ans12 <- "$602.2 \\times 10^{21}$"
  expect_equal(format_numbers(x, delim = "$"), ans12)
  expect_equal(format_numbers(x, delim = c("$", "$")), ans12)

  ans13 <- "\\(602.2 \\times 10^{21}\\)"
  expect_equal(format_numbers(x, delim = "\\("), ans13)
  expect_equal(format_numbers(x, delim = c("\\(", "\\)")), ans13)

  ans14 <- "\\[602.2 \\times 10^{21}\\]"
  expect_equal(format_numbers(x, delim = c("\\[", "\\]")), ans14)

  # Data frame,one column as vector
  x   <- air_meas[, (pres)]
  ans15 <- c("$101.1 \\times 10^{3}$",
           "$101.0 \\times 10^{3}$",
           "$101.1 \\times 10^{3}$",
           "$101.0 \\times 10^{3}$",
           "$101.1 \\times 10^{3}$")
  expect_equal(format_numbers(x), ans15)

  # Data frame, selected column in place
  DT  <- air_meas[, .(trial, pres)]
  ans16 <- data.table(wrapr::build_frame(
    "trial"  , "pres"               |
      "a"    , "$101.1 \\times 10^{3}$" |
      "b"    , "$101.0 \\times 10^{3}$" |
      "c"    , "$101.1 \\times 10^{3}$" |
      "d"    , "$101.0 \\times 10^{3}$" |
      "e"    , "$101.1 \\times 10^{3}$" ))
  cols_we_want <- c("pres")
  DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_numbers(x)),
           .SDcols = cols_we_want]
  expect_equal(DT, ans16)

  # Spaces inserted by formatC are trimmed. In this test, the first number
  # has four characters (the decimal point is a character); formatC() adds
  # spaces to store "800" as " 800". format_numbers() removes the extra spaces
  # ####### Change to format() from formatC() eliminates this issue.
  x <- 1.0E-6 * c(1.02, 0.8)
  ans17 <- c("$1.02 \\times 10^{-6}$", "$800 \\times 10^{-9}$")
  expect_equal(format_numbers(x, 3), ans17)

  # Negative number are OK
  x <- -1.0E-6 * c(1.02, 0.8)
  ans18 <- c("$-1.02 \\times 10^{-6}$", "$-800 \\times 10^{-9}$")
  expect_equal(format_numbers(x, 3), ans18)

  # Decimal separator
  x <- 43.21
  ans19 <- "$43.21$"
  expect_equal(format_numbers(x, decimal_mark = "."), ans19)
  ans20 <- "$43,21$"
  expect_equal(format_numbers(x, decimal_mark = ","), ans20)


  # Thousands separator
  x <- 123400
  ans22 <- "$123400$"
  expect_equal(format_numbers(x, big_mark = "", omit_power = c(-Inf, Inf)), ans22)
  ans24 <- "$123\\,400$"
  expect_equal(format_numbers(x, big_mark = "thin", omit_power = c(-Inf, Inf)), ans24)

  # x <- 123456.789259
  # ans25 <- "$123\\,456,78925\\,9$"
  # expect_equal(format_numbers(x, 12, format = "dcml", big_mark = "thin", decimal_mark = ",",
  #                           omit_power = c(-Inf, Inf)), ans25)
  # ans26 <- "$123456,789\\,25$"
  # expect_equal(format_numbers(x, 11, big_mark = "", decimal_mark = ",",
  #                             small_mark = "thin", omit_power = c(-Inf, Inf)), ans26)


  # Errors for incorrect x argument
  expect_error(format_numbers(x = air_meas))
  expect_error(format_numbers(x = air_meas$date))
  expect_error(format_numbers(x = air_meas$trial))
  expect_error(format_numbers(x = air_meas$humid))
  expect_error(format_numbers(x = c(TRUE, FALSE)))
  expect_error(format_numbers(x = NA))
  expect_error(format_numbers(x = NULL))

  # Errors for incorrect digits argument
  expect_error(format_numbers(avogadro, digits = c(3, 4)))
  # expect_error(format_numbers(avogadro, digits = NA))
  expect_error(format_numbers(avogadro, digits = "3"))
  expect_error(format_numbers(avogadro, digits = TRUE))
  expect_error(format_numbers(avogadro, digits = NULL))

  # Errors for incorrect format argument
  # expect_error(format_numbers(avogadro, format = NA_character_))
  expect_error(format_numbers(avogadro, format = NULL))
  expect_error(format_numbers(avogadro, format = TRUE))
  expect_error(format_numbers(avogadro, format = 3))
  expect_error(format_numbers(avogadro, format = c("engr", "sci")))

  # Errors for incorrect set_power argument
  expect_error(format_numbers(avogadro, set_power = TRUE))
  expect_error(format_numbers(avogadro, set_power = c(1, 2)))
  expect_error(format_numbers(avogadro, set_power = "1"))
  expect_error(format_numbers(avogadro, set_power = as.Date(2020-11-24)))
  expect_error(format_numbers(avogadro, set_power = as.factor(1)))

  # Errors for incorrect omit_power argument
  expect_error(format_numbers(avogadro, omit_power = TRUE))
  expect_error(format_numbers(avogadro, omit_power = c(1, 2, 3)))
  expect_error(format_numbers(avogadro, omit_power = c(2, -1)))

  # Errors for incorrect digit grouping arguments
  x <- 123456.78
  expect_error(format_numbers(x, 8, big_mark = ".", decimal_mark = "."))
  expect_error(format_numbers(x, 8, big_mark = ","))
  expect_error(format_numbers(x, 8, decimal_mark = ""))

  # Errors for incorrect delim argument
  expect_error(format_numbers(x, delim = c("")))
  expect_error(format_numbers(x, delim = 1))
  expect_error(format_numbers(x, delim = c("$", "$", "$")))

  # arguments after dots must be named
  expect_error(format_numbers(avogadro, 4, "engr", c(0.1, 1)))

  # options
  formatdown_options(size = "large")

  x <- avogadro
  ans32 <- "$\\large 602.2 \\times 10^{21}$"
  expect_equal(format_numbers(x), ans32)

  formatdown_options(delim = "\\(")
  ans33 <- "\\(\\large 602.2 \\times 10^{21}\\)"
  expect_equal(format_numbers(x), ans33)

  # reset options
  formatdown_options(reset = TRUE)

  # function output not printed
  invisible(NULL)
}

test_format_numbers()
