## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  tidy = TRUE
)

# to knit "child" Rmd files
knitr::opts_knit$set(root.dir = "../")

library(formatdown)
library(data.table)
library(knitr)

options(
  datatable.print.nrows = 15,
  datatable.print.topn = 3,
  datatable.print.class = TRUE
)

## -----------------------------------------------------------------------------
# make header table, but scan it and save as png

# Markup <- c("$\\small\\mathtt{\\verb+\\mathrm{...}+}$", "$\\small\\mathtt{\\verb+\\mathit{...}+}$", "$\\small\\mathtt{\\verb+\\mathbf{...}+}$", "$\\small\\mathtt{\\verb+\\mathsf{...}+}$", "$\\small\\mathtt{\\verb+\\mathtt{...}+}$")
#
# Style <- c("$\\small\\mathrm{plain}$", "$\\small\\mathit{italic}$", "$\\small\\mathbf{bold}$", "$\\small\\mathsf{sans\\ serif}$", "$\\small\\mathtt{typewriter}$")
#
# DT <- data.table(Markup, Style)
# knitr::kable(DT, align = "l") |>
#   kableExtra::kable_styling(font_size = 16, position = "left") |>
#   kableExtra::column_spec(1:2, width = "2in")

## -----------------------------------------------------------------------------
#  library("formatdown")
#  library("data.table")
#  library("knitr")

## -----------------------------------------------------------------------------
# 1. One string
x <- "Alum 6061"
format_text(x)

# 2. String vector
y <- c("Alum 6061", "Carbon steel", "Ni-Cr-Fe alloy")
format_text(y)

## -----------------------------------------------------------------------------
# 3. Character class
x <- c("abc", "def", NA_character_)
format_text(x)

## -----------------------------------------------------------------------------
# 4. Numeric class
x <- c(10, 3E-5, 4.56E+10)
format_text(x)

## -----------------------------------------------------------------------------
# 5. Logical class
x <- TRUE
format_text(x)

## -----------------------------------------------------------------------------
# 6. Complex class
x <- 2 + 3i
format_text(x)

## -----------------------------------------------------------------------------
# 7. Date class
x <- Sys.Date()
format_text(x)

## -----------------------------------------------------------------------------
# 8 Factor class
x <- as.factor(c("low", "med", "high"))
format_text(x)

## -----------------------------------------------------------------------------
# 9. NULL class
x <- NULL
format_text(x)

## -----------------------------------------------------------------------------
# 10. Compare available typefaces
x <- c("One day", "at a", "time.")
plain <- format_text(x, face = "plain", size = "small")
italic <- format_text(x, face = "italic", size = "small")
bold <- format_text(x, face = "bold", size = "small")
sans <- format_text(x, face = "sans", size = "small")
mono <- format_text(x, face = "mono", size = "small")
DT <- data.table(plain, italic, bold, sans, mono)
knitr::kable(DT, align = "l", caption = "Example 10.")

## -----------------------------------------------------------------------------
# 11. Two equivalent values for argument
hello_text <- "Hello world!"
p <- format_text(hello_text, face = "plain")
q <- format_text(hello_text, face = "\\mathrm")

# Demonstrate equivalence
all.equal(p, q)

## -----------------------------------------------------------------------------
# 12. Special characters NOT escaped
format_text("R_e")
format_text("m^3")

## -----------------------------------------------------------------------------
# 13. Special characters escaped
format_text("R\\_e")
format_text("m\\verb+^+3")

