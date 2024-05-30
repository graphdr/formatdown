## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
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
formatdown_options("size", "decimal_mark")

## -----------------------------------------------------------------------------
# Set
formatdown_options(size = "large", decimal_mark = ",")

# Examine result
formatdown_options("size", "decimal_mark")

## -----------------------------------------------------------------------------
# Set to defaults
formatdown_options(reset = TRUE)

# Examine result
formatdown_options("size", "decimal_mark")

## -----------------------------------------------------------------------------
x <- 101300
txt <- "Hello world!"

# 1. Numeric input, default delimiters
format_dcml(x)

# 2. Numeric input, alternate delimiters
format_dcml(x, delim = "\\(")

# 3. Character input, default delimiters
format_text(txt)

# 4. Character input, alternate delimiters
format_text(txt, delim = "\\(")

## -----------------------------------------------------------------------------
# 5. Numeric input
format_dcml(x, size = "scriptsize")

# 6. Numeric input
format_dcml(x, size = "small")

# 7. Power-of-ten number using LaTeX-style size markup
format_sci(6.0221e+23, size = "\\small")

# 8. Character input, default size
format_text(txt)

# 9. Character input
format_text(txt, size = "large")

## -----------------------------------------------------------------------------
x <- pi
y <- 5.3e+3
z <- "The cat"

scriptsize <- c(
  format_dcml(x, 5, size = "scriptsize"),
  format_sci(y, 1, size = "scriptsize"),
  format_text(z, size = "scriptsize")
)
small <- c(
  format_dcml(x, 5, size = "small"),
  format_sci(y, 1, size = "small"),
  format_text(z, size = "small")
)
normalsize <- c(
  format_dcml(x, 5, size = "normalsize"),
  format_sci(y, 1, size = "normalsize"),
  format_text(z, size = "normalsize")
)
large <- c(
  format_dcml(x, 5, size = "large"),
  format_sci(y, 1, size = "large"),
  format_text(z, size = "large")
)
huge <- c(
  format_dcml(x, 5, size = "huge"),
  format_sci(y, 1, size = "huge"),
  format_text(z, size = "huge")
)

DT <- data.table(scriptsize, small, normalsize, large, huge)
knitr::kable(DT, align = "r")

## -----------------------------------------------------------------------------
# 10. Decimal markup
x <- pi
format_dcml(x, 5, decimal_mark = ",")

# 11. Power-of-ten markup
y <- 1.602176634e-19
format_sci(y, 5, decimal_mark = ",")

## -----------------------------------------------------------------------------
w <- 1013
x <- 101300
y <- 0.002456
z <- x + y

# 12. 4-digit number, no space
format_dcml(w)

# 13. 4-digit number, with space
format_dcml(w, big_mark = "thin")

# 14. Group digits to the left of the decimal
format_dcml(x, big_mark = "thin")

# 15. Group digits to the right of the decimal
format_dcml(y, small_mark = "\\\\,")

# 16. Change the small interval
format_dcml(y, small_mark = "\\\\,", small_interval = 3)

# 17. Group digits to the left and right of the decimal
format_dcml(z, 12, big_mark = "thin", small_mark = "thin")

## -----------------------------------------------------------------------------
# 18. Character input, default space "\>"
format_text(txt, whitespace = "\\\\>")

# 19. Character input, alternate space "\:"
format_text(txt, whitespace = "\\\\:")

# 20. Character input, alternate space "\ "
format_text(txt, whitespace = "\\\\ ")

## -----------------------------------------------------------------------------
# 21. Alternate multiplication symbol
y <- 1.602176634e-19
format_sci(y, 5, decimal_mark = ",", multiply_mark = "\\cdot")

## -----------------------------------------------------------------------------
formatdown_options(size = "small")

## -----------------------------------------------------------------------------
# Set options
formatdown_options(decimal_mark = ",", big_mark = "thin", small_mark = "thin")

# Use water data included with formatdown
DT <- copy(water)[1:6]

# Examine the data frame
DT[]

# Routine decimal formatting
DT$temp <- format_dcml(DT$temp)
DT$dens <- format_dcml(DT$dens)

# Omit big_mark spacing for 4 digits
DT$sp_wt <- format_dcml(DT$sp_wt, 4, big_mark = "")

# Set significant digits (viscosity) to achieve a consistent string length
DT[visc >= 0.001, temp_visc := format_dcml(visc, 5)]
DT[visc < 0.001, temp_visc := format_dcml(visc, 4)]
DT[, visc := temp_visc]
DT[, temp_visc := NULL]

# Will appear with big_mark spacing, change from Pa to kPa
DT$bulk_mod_kPa <- format_dcml(DT$bulk_mod / 1000, 4)
DT$bulk_mod <- NULL

knitr::kable(DT, align = "r", caption = "Example 22.")

# Set package options to default values
formatdown_options(reset = TRUE)

## -----------------------------------------------------------------------------
formatdown_options(size = "small")

## -----------------------------------------------------------------------------
# Use water data included with formatdown
DT <- copy(water)[1:6]

# Routine decimal formatting
cols <- c("temp", "dens", "sp_wt")
DT[, (cols) := lapply(.SD, function(x) format_dcml(x)), .SDcols = cols]

# Power of ten
DT$bulk_mod <- format_engr(DT$bulk_mod, 3)
DT$visc <- format_engr(DT$visc, 4, set_power = -3)

knitr::kable(DT, align = "r", caption = "Example 23.")

## -----------------------------------------------------------------------------
formatdown_options(reset = TRUE)

## -----------------------------------------------------------------------------
formatdown_options(size = "small")

## -----------------------------------------------------------------------------
# Use water data included with formatdown
DT <- copy(metals)

# Examine the data frame
DT[]

# Text
DT$metal <- format_text(DT$metal)

# Decimal
cols <- c("dens", "thrm_cond")
DT[, (cols) := lapply(.SD, function(x) format_dcml(x)), .SDcols = cols]

# Power of ten
cols <- c("elast_mod", "thrm_exp")
DT[, (cols) := lapply(.SD, function(x) format_engr(x, 3)), .SDcols = cols]

knitr::kable(DT, align = "lrrrr", caption = "Example 24.")

## -----------------------------------------------------------------------------
formatdown_options(reset = TRUE)

