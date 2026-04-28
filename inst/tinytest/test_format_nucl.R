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

  ans101 <- "$\\mathrm{^{\\small\\ 12}C}$"
  expect_equal(ans101, format_nucl(x))

  ans102 <- "$\\mathrm{^{\\small\\ 12}_{\\small\\ 6}C}$"
  expect_equal(ans102, format_nucl(x, Z = TRUE))

  ans103 <- "$\\mathit{^{\\small\\ 12}C}$"
  expect_equal(ans103, format_nucl(x, face = "italic"))


  # vector correct behavior
  x <- c("C-12", "U-235")
  ans104 <-  c("$\\mathrm{^{\\small\\ 12}C}$", "$\\mathrm{^{\\small\\ 235}U}$")
  expect_equal(ans104, format_nucl(x))

  ans105 <- c("$\\mathrm{^{\\small\\ 12}_{\\small\\ 6}C}$",
              "$\\mathrm{^{\\small\\ 235}_{\\small\\ 92}U}$")
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
  ans106 <- "$\\mathrm{^{\\small\\ A}E}$"
  expect_equal(ans106, format_nucl(x, warn = FALSE))
  expect_equal(ans106, suppressWarnings(format_nucl(x, warn = TRUE)))

  ans107 <- "$\\mathrm{^{\\small\\ A}_{\\small\\ Z}E}$"
  expect_equal(ans107, format_nucl(x, Z = TRUE, warn = FALSE))
  expect_equal(ans107, suppressWarnings(format_nucl(x, Z = TRUE, warn = TRUE)))


  # error due to improper inputs
  expect_error(format_nucl("C12"))
  expect_error(format_nucl("C-12-6"))
  expect_error(format_nucl(C12))
  expect_error(format_nucl(TRUE))
  expect_error(format_nucl(NULL))
  expect_error(format_nucl(NA_character_))

 




  # ans101 <- "$602.2 \\times 10^{21}$"
  # expect_equal(ans101, format_numbers(x))
  # expect_equal(ans101, format_numbers(x, delim = "$"))
  # expect_equal(ans101, format_numbers(x, delim = c("$", "$")))
  # expect_equal(ans101, format_engr(x))
  # expect_equal(ans101, format_engr(x, delim = "$"))
  # expect_equal(ans101, format_engr(x, delim = c("$", "$")))
  #
  # ans102 <- "\\(602.2 \\times 10^{21}\\)"
  # expect_equal(ans102, format_numbers(x, delim = "\\("))
  # expect_equal(ans102, format_numbers(x, delim = c("\\(", "\\)")))
  # expect_equal(ans102, format_engr(x, delim = "\\("))
  # expect_equal(ans102, format_engr(x, delim = c("\\(", "\\)")))
  #
  # ans103 <- "\\[602.2 \\times 10^{21}\\]"
  # expect_equal(ans103, format_numbers(x, delim = c("\\[", "\\]")))
  # expect_equal(ans103, format_engr(x, delim = c("\\[", "\\]")))
  #
  # ans104 <- "$6.022 \\times 10^{23}$"
  # expect_equal(ans104, format_sci(x))
  # expect_equal(ans104, format_sci(x, delim = "$"))
  # expect_equal(ans104, format_sci(x, delim = c("$", "$")))
  #
  # ans105 <- "\\(6.022 \\times 10^{23}\\)"
  # expect_equal(ans105, format_sci(x, delim = "\\("))
  # expect_equal(ans105, format_sci(x, delim = c("\\(", "\\)")))
  #
  # ans106 <- "\\[6.022 \\times 10^{23}\\]"
  # expect_equal(ans106, format_sci(x, delim = c("\\[", "\\]")))
  #
  # x <- 987123
  #
  # ans107 <- "$987100$"
  # expect_equal(ans107, format_dcml(x))
  # expect_equal(ans107, format_dcml(x, delim = "$"))
  # expect_equal(ans107, format_dcml(x, delim = c("$", "$")))
  #
  # ans108 <- "\\(987100\\)"
  # expect_equal(ans108, format_dcml(x, delim = "\\("))
  # expect_equal(ans108, format_dcml(x, delim = c("\\(", "\\)")))
  #
  # ans109 <- "\\[987100\\]"
  # expect_equal(ans109, format_dcml(x, delim = c("\\[", "\\]")))
  #
  # x <- 6.0221e+23
  # units(x) <- "m"
  #
  # ans110 <- "$602.2 \\times 10^{21}\\ \\mathrm{m}$"
  # expect_equal(ans110, format_numbers(x))
  # expect_equal(ans110, format_numbers(x, delim = "$"))
  # expect_equal(ans110, format_numbers(x, delim = c("$", "$")))
  #
  # ans111 <- "\\(602.2 \\times 10^{21}\\ \\mathrm{m}\\)"
  # expect_equal(ans111, format_numbers(x, delim = "\\("))
  # expect_equal(ans111, format_numbers(x, delim = c("\\(", "\\)")))
  #
  # ans112 <- "\\[602.2 \\times 10^{21}\\ \\mathrm{m}\\]"
  # expect_equal(ans112, format_numbers(x, delim = c("\\[", "\\]")))
  #
  # x <- "hello world"
  #
  # ans113 <- "$\\mathrm{hello\\ world}$"
  # expect_equal(ans113, format_text(x))
  # expect_equal(ans113, format_text(x, delim = "$"))
  # expect_equal(ans113, format_text(x, delim = c("$", "$")))
  #
  # ans114 <- "\\(\\mathrm{hello\\ world}\\)"
  # expect_equal(ans114, format_text(x, delim = "\\("))
  # expect_equal(ans114, format_text(x, delim = c("\\(", "\\)")))
  #
  # ans115 <- "\\[\\mathrm{hello\\ world}\\]"
  # expect_equal(ans115, format_text(x, delim = c("\\[", "\\]")))
  #
  # # vector input
  # x <- c(123, 4.56e+11)
  # ans116 <- c("\\(123\\)", "\\(456 \\times 10^{9}\\)")
  # expect_equal(ans116, format_numbers(x, 3, delim = "\\("))
  #
  # # errors
  # expect_error(format_numbers(x, delim = c("\\[")))
  # expect_error(format_numbers(x, delim = c(NA_character_, NA_character_)))
  # expect_error(format_numbers(x, delim = c(NULL, NULL)))






  # function output not printed
  invisible(NULL)
}

test_format_nucl()
