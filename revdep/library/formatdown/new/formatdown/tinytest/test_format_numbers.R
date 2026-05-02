test_format_numbers <- function() {

  # All tests, e.g., expect_equal, expect_error, etc., are from the
  # tinytest package. Possible test functions listed at
  # https://github.com/markvanderloo/tinytest/blob/master/pkg/README.md

  # usage
  # format_numbers <- function(x,
  #                            digits = 4,
  #                            format = "engr",
  #                            ...,
  #                            omit_power = c(-1, 2),
  #                            set_power = NULL,
  #                            delim          = formatdown_options("delim"),
  #                            size           = formatdown_options("size"),
  #                            decimal_mark   = formatdown_options("decimal_mark"),
  #                            big_mark       = formatdown_options("big_mark"),
  #                            big_interval   = formatdown_options("big_interval"),
  #                            small_mark     = formatdown_options("small_mark"),
  #                            small_interval = formatdown_options("small_interval"),
  #                            whitespace     = formatdown_options("whitespace"))

  # Needed for tinytest::build_install_test()
  suppressPackageStartupMessages(library(data.table))

  # Inputs: First three arguments and convenience functions
  # +/- exponents and default digits and format
  x <- 6.0221E+23
  ans101 <- "$602 \\times 10^{21}$"
  expect_equal(ans101, format_numbers(x = x, digits = 3, format = "engr"))
  expect_equal(ans101, format_numbers(x, 3, "engr"))
  expect_equal(ans101, format_engr(x, 3))

  x <- 103219
  ans102 <- "$103200$"
  expect_equal(ans102, format_numbers(x, format = "dcml"))
  expect_equal(ans102, format_dcml(x, 4))
  expect_equal(ans102, format_dcml(x))

  x <- 6.0221E-23
  ans103 <- "$6.0221 \\times 10^{-23}$"
  expect_equal(ans103, format_numbers(x, 5, "sci"))
  expect_equal(ans103, format_sci(x, 5))

  # Input of class units
  x <- 6.0221E+23
  units(x) <- "N m2 C-2"
  ans104 <- "$602.2 \\times 10^{21}\\ \\mathrm{m^{2}\\ N\\ C^{-2}}$"
  ans105 <- "$602.2 \\times 10^{21}\\ \\mathrm{N\\ m^{2}\\ C^{-2}}$"
  expect_true(format_numbers(x) %in% c(ans104, ans105))

  units(x) <- NULL
  expect_equal(ans101, format_numbers(x, 3))

  # Large and small values format correctly
  x <- 2.2e-16
  ans106 <- "$2.2 \\times 10^{-16}$"
  expect_equal(ans106, format_sci(x, 2))

  x <- 1.7e+300
  ans107 <- "$1.7 \\times 10^{300}$"
  expect_equal(ans107, format_sci(x, 2))

  # Inputs: Data frame,one column as vector
  x <- air_meas[, (pres)]
  ans108 <- c("$101.1 \\times 10^{3}$",
             "$101.0 \\times 10^{3}$",
             "$101.1 \\times 10^{3}$",
             "$101.0 \\times 10^{3}$",
             "$101.1 \\times 10^{3}$")
  expect_equal(ans108, format_numbers(x))

  # Inputs: Data frame, selected column in place
  DT  <- air_meas[, .(trial, pres)]
  ans109 <- data.table(wrapr::build_frame(
    "trial"  , "pres"               |
      "a"    , "$101.1 \\times 10^{3}$" |
      "b"    , "$101.0 \\times 10^{3}$" |
      "c"    , "$101.1 \\times 10^{3}$" |
      "d"    , "$101.0 \\times 10^{3}$" |
      "e"    , "$101.1 \\times 10^{3}$" ))
  cols_we_want <- c("pres")
  DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_numbers(x)),
           .SDcols = cols_we_want]
  expect_equal(ans109, DT)

  # Negative values OK
  x <- -6.3212e+12
  ans110 <- "$-6.321 \\times 10^{12}$"
  expect_equal(ans110, format_numbers(x))

  # Spaces inserted by formatC are trimmed. In this test, the first number
  # has four characters (the decimal point is a character); formatC() adds
  # spaces to store "800" as " 800". format_numbers() removes the extra spaces
  # NOTE: Can change to format() from formatC() to eliminate this issue.
  x <- c(1.02, 0.8) * 1.0e-6
  ans111 <- c("$1.02 \\times 10^{-6}$", "$800 \\times 10^{-9}$")
  expect_equal(ans111, format_numbers(x, 3))

  # Digits
  x <- 9.75358e+5
  ans151 <- "$9.8 \\times 10^{5}$"
  expect_equal(ans151, format_sci(x, 2))
  ans152 <- "$9.75 \\times 10^{5}$"
  expect_equal(ans152, format_sci(x, 3))
  ans153 <- "$9.754 \\times 10^{5}$"
  expect_equal(ans153, format_sci(x, 4))

  # Combinations of format, set_power, and omit_power
  x <- 0.00021541
  ans201 <- "$2.154 \\times 10^{-4}$"
  expect_equal(ans201, format_sci(x, omit_power = NULL))
  expect_equal(ans201, format_sci(x, omit_power = -3))

  x <- 3.2211e-3
  ans202 <- "$0.003221$"
  expect_equal(ans202, format_sci(x, omit_power = -3))
  expect_equal(ans202, format_engr(x, omit_power = -3))
  # expect_equal(ans202, format_dcml(x, omit_power = -3))
  expect_equal(ans202, format_dcml(x))

  x <- 5.222
  ans203 <- "$5.222 \\times 10^{0}$"
  expect_equal(ans203, format_sci(x, omit_power = NULL))
  expect_equal(ans203, format_engr(x, omit_power = NULL))

  ans204 <- "$5.222$"
  expect_equal(ans204, format_sci(x, omit_power = c(-1, 0)))
  expect_equal(ans204, format_engr(x, omit_power = c(-1, 0)))

  x <- 22.11
  ans205 <- "$2.211 \\times 10^{1}$"
  expect_equal(ans205, format_sci(x, omit_power = NULL))
  expect_equal(ans205, format_sci(x, omit_power = c(-1, 0)))

  ans206 <- "$22.11 \\times 10^{0}$"
  expect_equal(ans206, format_engr(x, omit_power = NULL))
  ans207 <- "$22.11$"
  expect_equal(ans207, format_engr(x, omit_power = c(-1, 0)))

  # omit_power has no effect
  x <- 6.521
  ans208 <- "$6.521 \\times 10^{0}$"
  expect_equal(ans208, format_sci(x, omit_power = NULL))
  expect_equal(ans208, format_sci(x, omit_power = -3))
  expect_equal(ans208, format_engr(x, omit_power = NULL))
  expect_equal(ans208, format_engr(x, omit_power = -3))

  # set_power overrides omit_power
  x <- 101300
  ans209 <- format_sci(x, set_power = 2)
  expect_equal(ans209, format_sci(x, omit_power = 5, set_power = 2))
  expect_equal(ans209, format_sci(x, omit_power = 2, set_power = 2))

  # set_power overrides format
  x   <- 6.0221E+23
  ans209b <- "$0.6022 \\times 10^{24}$"
  expect_equal(ans209b, format_engr(x, set_power = 24L))
  expect_equal(ans209b, format_sci(x, set_power = 24L))

  # dcml ignores set_power; omit_power creates a decimal
  x <- 101300
  ans210 <- format_dcml(x)
  # expect_equal(ans210, format_dcml(x, set_power = 2))
  expect_equal(ans210, format_engr(x, omit_power = 5))

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

  # ERRORS  ------------------------
  x <- 101300

  # arguments of incorrect class
  expect_error(format_numbers(x = TRUE))
  expect_error(format_numbers(x, digits = TRUE))
  expect_error(format_sci(x, omit_power = TRUE))
  expect_error(format_sci(x, set_power = TRUE))

  # arguments not among allowed choices
  expect_error(format_numbers(x = NULL))
  expect_error(format_numbers(x, digits = NULL))
  expect_error(format_numbers(x, digits = 22))
  expect_error(format_numbers(x, format = NULL))
  expect_error(format_numbers(x, format = "scientific"))

  # arguments with incorrect relationship
  expect_error(format_sci(x, omit_power = c(3, -1)))

  # arguments of incorrect length
  expect_error(format_numbers(x, digits = c(1, 2)))
  expect_error(format_numbers(x, format = c("engr", "sci")))
  expect_error(format_numbers(x, omit_power = c(-1, 0, 3)))
  expect_error(format_numbers(x, set_power = c(-1, 2)))

  # arguments after dots must be named
  expect_error(format_numbers(x, 4, "engr", c(-1, 2)))
  expect_error(format_sci(x, 4, c(-1, 2)))
  expect_error(format_engr(x, 4, c(-1, 2)))
  expect_error(format_dcml(x, 4, "$"))

  # function output not printed
  invisible(NULL)
}

test_format_numbers()
