test_format_nucl <- function() {

  # library("data.table")
  # library("formatdown")

  # usage
  #
  # format_nucl(x,
  #             face = "plain",
  #             ...,
  #             Z = formatdown_options("Z"),
  #             warn = formatdown_options("warn"),
  #             delim = formatdown_options("delim"))



  # scalar correct behaviors
  x <- "C-12"

  ans101 <- "$\\mathrm{^{12}C}$"
  expect_equal(ans101, format_nucl(x))

  ans102 <- "$\\mathrm{^{12}_{6}C}$"
  expect_equal(ans102, format_nucl(x, Z = TRUE))

  ans103 <- "$\\mathit{^{12}C}$"
  expect_equal(ans103, format_nucl(x, face = "italic"))


  # vector correct behavior
  x <- c("C-12", "U-235")
  ans104 <-  c("$\\mathrm{^{12}C}$", "$\\mathrm{^{235}U}$")
  expect_equal(ans104, format_nucl(x))

  ans105 <- c("$\\mathrm{^{12}_{6}C}$",
              "$\\mathrm{^{235}_{92}U}$")
  expect_equal(ans105, format_nucl(x, Z = TRUE))


  # output class characteristics
  x <- c("C-12", "U-235")
  ans105a <- "character"
  expect_equal(ans105a, class(format_nucl(x)))

  ans105b <- 2
  expect_equal(ans105b, length(format_nucl(x)))


  # warning
  x <- "C-40"
  expect_warning(format_nucl(x))
  expect_warning(format_nucl(x, Z = TRUE))
  expect_warning(format_nucl(x, face = "italic"))

  x <- "carbon-12"
  expect_warning(format_nucl(x))
  expect_warning(format_nucl(x, Z = TRUE))
  expect_warning(format_nucl(x, face = "italic"))


  # omit warning, use symbols
  x <- "E-A"
  ans106 <- "$\\mathrm{^{A}E}$"
  expect_equal(ans106, format_nucl(x, warn = FALSE))
  expect_equal(ans106, suppressWarnings(format_nucl(x, warn = TRUE)))

  ans107 <- "$\\mathrm{^{A}_{Z}E}$"
  expect_equal(ans107, format_nucl(x, Z = TRUE, warn = FALSE))
  expect_equal(ans107, suppressWarnings(format_nucl(x, Z = TRUE, warn = TRUE)))


  # error due to improper inputs
  expect_error(format_nucl("C12"))
  expect_error(format_nucl("C-12-6"))
  expect_error(format_nucl(C12))
  expect_error(format_nucl(TRUE))
  expect_error(format_nucl(NULL))
  expect_error(format_nucl(NA_character_))






  # function output not printed
  invisible(NULL)
}

test_format_nucl()
