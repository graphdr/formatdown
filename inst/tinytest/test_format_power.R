test_format_power<- function() {

  # usage
  # format_power(x, digits = 3, ..., format = "engr", limits = c(0.1, 1000))
  # arguments after dots must be named

  # Needed for tinytest::build_install_test()
  library("data.table")

  # Avogadro's number
  avogadro <- 6.0221E+23

  # Equivalent usage, named, unnamed, default
  ans <- "$602\\times{10}^{21}$"
  expect_equal(ans, format_power(x = avogadro, digits = 3))
  expect_equal(ans, format_power(avogadro, 3))
  expect_equal(ans, format_power(avogadro))

  # Significant digits
  ans <- "$602.2\\times{10}^{21}$"
  expect_equal(ans, format_power(avogadro, 4))

  # Scientific format
  ans <- "$6.02\\times{10}^{23}$"
  expect_equal(ans, format_power(avogadro, format = "sci"))

  # Limits
  x <- 0.633
  ans <- "$0.633$"
  expect_equal(ans, format_power(x, limits = c(0.1, 1000)))
  ans <- "$633\\times{10}^{-3}$"
  expect_equal(ans, format_power(x, limits = c(1, 1000)))

  # Data frame,one column as vector
  x <- density[, (p_Pa)]
  ans <- c("$101.1\\times{10}^{3}$",
           "$101.0\\times{10}^{3}$",
           "$101.1\\times{10}^{3}$",
           "$101.0\\times{10}^{3}$",
           "$101.1\\times{10}^{3}$")
  expect_equal(ans, format_power(x, 4))

  # Data frame, selected column in place
  ans <- data.table(wrapr::build_frame(
    "trial"  , "p_Pa"                   |
      "a"    , "$101.1\\times{10}^{3}$" |
      "b"    , "$101.0\\times{10}^{3}$" |
      "c"    , "$101.1\\times{10}^{3}$" |
      "d"    , "$101.0\\times{10}^{3}$" |
      "e"    , "$101.1\\times{10}^{3}$" ))
  DT <- density[, .(trial, p_Pa)]
  cols_we_want <- c("p_Pa")
  DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_power(x, 4)),
           .SDcols = cols_we_want]
  expect_equal(ans, DT)

  # Errors for incorrect x argument
  expect_error(format_power(x = density))
  expect_error(format_power(x = density$date))
  expect_error(format_power(x = density$trial))
  expect_error(format_power(x = density$humidity))
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

 # Errors for incorrect limits argument
 expect_error(format_power(avogadro, limits = 1))
 expect_error(format_power(avogadro, limits = NA_character_))
 expect_error(format_power(avogadro, limits = NULL))
 expect_error(format_power(avogadro, limits = TRUE))
 expect_error(format_power(avogadro, limits = c(1, 2, 3)))

 # arguments after dots must be named
 expect_error(format_power(avogadro, 4, "engr"))
 expect_error(format_power(avogadro, 4, format = "engr", c(0.1, 1)))


  # function output not printed
  invisible(NULL)
}

test_format_power()
