test_format_power<- function() {

  # usage
  # format_power(x, digits = 3, ..., format = "engr", omit_power = c(-1, 2))
  # arguments after dots must be named

  # Needed for tinytest::build_install_test()
  library("data.table")

  # Avogadro's number
  avogadro <- 6.0221E+23

  # Equivalent usage, named, unnamed, default
  x   <- avogadro
  ans <- "$602\\times{10}^{21}$"
  expect_equal(format_power(x = x, digits = 3), ans)
  expect_equal(format_power(x, 3), ans)
  expect_equal(format_power(x), ans)

  # Significant digits
  x   <- avogadro
  ans <- "$602.2\\times{10}^{21}$"
  expect_equal(format_power(x, 4), ans)

  # Scientific format
  x   <- avogadro
  ans <- "$6.02\\times{10}^{23}$"
  expect_equal(format_power(x, format = "sci"), ans)

  # Ignore exponents
  x   <- 0.633
  ans <- "$0.633$"
  expect_equal(format_power(x, omit_power = c(-1, 2)), ans)

  x   <- 0.633
  ans <- "$633\\times{10}^{-3}$"
  expect_equal(format_power(x, omit_power = c(0, 2)), ans)

  x   <- 633
  ans <- "$633\\times{10}^{0}$"
  expect_equal(format_power(x, omit_power = c(0, 0)), ans)
  expect_equal(format_power(x, omit_power = NA), ans)
  expect_equal(format_power(x, omit_power = NULL), ans)

  # Data frame,one column as vector
  x   <- density[, (p_Pa)]
  ans <- c("$101.1\\times{10}^{3}$",
           "$101.0\\times{10}^{3}$",
           "$101.1\\times{10}^{3}$",
           "$101.0\\times{10}^{3}$",
           "$101.1\\times{10}^{3}$")
  expect_equal(format_power(x, 4), ans)

  # Data frame, selected column in place
  DT  <- density[, .(trial, p_Pa)]
  ans <- data.table(wrapr::build_frame(
    "trial"  , "p_Pa"                   |
      "a"    , "$101.1\\times{10}^{3}$" |
      "b"    , "$101.0\\times{10}^{3}$" |
      "c"    , "$101.1\\times{10}^{3}$" |
      "d"    , "$101.0\\times{10}^{3}$" |
      "e"    , "$101.1\\times{10}^{3}$" ))
  cols_we_want <- c("p_Pa")
  DT <- DT[, (cols_we_want) := lapply(.SD, function(x) format_power(x, 4)),
           .SDcols = cols_we_want]
  expect_equal(DT, ans)

  # Different delimiters
  x   <- avogadro
  ans <- "\\(602.2\\times{10}^{21}\\)"
  expect_equal(format_power(x, 4, delim = "\\("), ans)

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

 # Errors for incorrect omit_power argument
 expect_error(format_power(avogadro, omit_power = 1))
 expect_error(format_power(avogadro, omit_power = TRUE))
 expect_error(format_power(avogadro, omit_power = c(1, 2, 3)))
 expect_error(format_power(avogadro, omit_power = c(2, -1)))

 # arguments after dots must be named
 expect_error(format_power(avogadro, 4, "engr"))
 expect_error(format_power(avogadro, 4, format = "engr", c(0.1, 1)))


  # function output not printed
  invisible(NULL)
}

test_format_power()
