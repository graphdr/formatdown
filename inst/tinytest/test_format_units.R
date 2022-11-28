test_format_units <- function() {

  # usage
  # format_decimal(x, digits = 1, unit = NULL, unit_form = NULL, big_mark = NULL)
  # arguments after dots must be named

  # Needed for tinytest::build_install_test()
  suppressPackageStartupMessages(library(units))
  suppressPackageStartupMessages(library(data.table))

  # Equivalent usage, named, unnamed, default
  x <- 101300
  units(x) <- "Pa"
  ans <- "101300 [Pa]"
  expect_equal(format_units(x = x, digits = 1, unit = "Pa"), ans)
  expect_equal(format_units(x, 1, unit = "Pa"), ans)
  expect_equal(format_units(x), ans)

  # digits
  x <- 6.54321
  units(x) <- "m"
  expect_equal(format_units(x, 7), "6.54321 [m]")
  expect_equal(format_units(x, 5), "6.5432 [m]")
  expect_equal(format_units(x, 3), "6.54 [m]")
  expect_equal(format_units(x, 1), "7 [m]")
  x <- c(1.23, 1.9e-3)
  units(x) <- "s"
  expect_equal(format_units(x, 2), c("1.2300 [s]", "0.0019 [s]"))

  # unit
  x <- 6.54321
  units(x) <- "m"
  y <- x
  units(y) <- NULL
  expect_equal(format_units(x, 3), format_units(y, 3, unit = "m"))
  expect_equal(format_units(x, 3, unit = "cm"), "654 [cm]")

  # unit_form
  x <- 345
  units(x) <- "kg/m^3"
  expect_equal(format_units(x), "345 [kg/m^3]")
  expect_equal(format_units(x, unit_form = "standard"), "345 [kg/m^3]")
  expect_equal(format_units(x, unit_form = NULL), "345 [kg/m^3]")
  expect_equal(format_units(x, unit_form = NA), "345 [kg/m^3]")
  expect_equal(format_units(x, unit_form = "implicit"), "345 [kg m-3]")
  x <- 345
  units(x) <- "kg m-3"
  expect_equal(format_units(x), "345 [kg/m^3]")

  # big_mark
  x <- 101300
  units(x) <- "Pa"
  expect_equal(format_units(x, big_mark = ","), "101,300 [Pa]")
  expect_equal(format_units(x, big_mark = "."), "101.300 [Pa]")
  expect_equal(format_units(x, big_mark = ""), "101300 [Pa]")
  expect_equal(format_units(x, big_mark = NULL), "101300 [Pa]")
  expect_equal(format_units(x, big_mark = NA_character_), "101300 [Pa]")

  x <- 1200.34
  units(x) <- "m"
  expect_equal(format_units(x, 6, big_mark = ","), "1,200.34 [m]")
  expect_equal(format_units(x, 6, big_mark = "."), "1.200,34 [m]")

  # Data frame column
  DT <- copy(atmos)
  units(DT$alt) <- "m"
  DT[, alt := format_units(alt, unit = "km")]
  expect_equal(DT$alt[1], "0 [km]")

  # Negative number are OK
  x <- -6.2
  units(x) <- "m/s"
  expect_equal(format_units(x, 2), "-6.2 [m/s]")

  # Zero is OK
  x <- c(0, 0.2)
  units(x) <- "m/s"
  expect_equal(format_units(x, 2), c("0.0 [m/s]", "0.2 [m/s]"))

  # x argument type errors
  expect_error(format_units(x = as.Date("2020-11-24"), unit = "m"))
  expect_error(format_units(x = as.factor(1), unit = "m"))
  expect_error(format_units(x = TRUE, unit = "m"))
  expect_error(format_units(x = NULL, unit = "m"))
  expect_error(format_units(x = "1", unit = "m"))
  expect_error(format_units(x = NA, unit = "m"))

  # digits argument type and length errors
  x <- 1.1234
  units(x) <- "m"
  expect_error(format_units(x, digits = as.Date("2020-11-24")))
  expect_error(format_units(x, digits = as.factor(1)))
  expect_error(format_units(x, digits = c(1, 2)))
  expect_error(format_units(x, digits = TRUE))
  expect_error(format_units(x, digits = NULL))
  expect_error(format_units(x, digits = "1"))
  expect_error(format_units(x, digits = NA))

  # unit argument type errors
  x <- 1.1234
  expect_error(format_units(x, unit = as.Date("2020-11-24")))
  expect_error(format_units(x, unit = as.factor(1)))
  expect_error(format_units(x, unit = c(1, 2)))
  expect_error(format_units(x, unit = TRUE))
  expect_error(format_units(x, unit = NULL))
  expect_error(format_units(x, unit = "no_known_unit"))
  expect_error(format_units(x, unit = NA))
  units(x) <- "m"
  expect_error(format_units(x, unit = "Pa"))

  # unit_form argument type errors
  x <- 1.234
  units(x) <- "kg/m^3"
  expect_error(format_units(x, unit_form = as.Date("2020-11-24")))
  expect_error(format_units(x, unit_form = as.factor(1)))
  expect_error(format_units(x, unit_form = c(1, 2)))
  expect_error(format_units(x, unit_form = TRUE))
  expect_error(format_units(x, unit_form = "no_known_unit"))

  # big_mark argument type and length errors
  x <- 101300
  units(x) <- "m"
  expect_error(format_units(x, big_mark = as.Date("2020-11-24")))
  expect_error(format_units(x, big_mark = as.factor(1)))
  expect_error(format_units(x, big_mark = c(",", ".")))
  expect_error(format_units(x, big_mark = TRUE))

  # arguments after dots must be named
  x <- 1.234
  units(x) <- "m"
  expect_error(format_units(x, 1, "ft"))
  expect_error(format_units(x, 1, unit = "ft", "implicit"))
  expect_error(format_units(x, 1, unit = "ft", unit_form = "implicit", ","))

  # function output not printed
  invisible(NULL)
}

test_format_units()
