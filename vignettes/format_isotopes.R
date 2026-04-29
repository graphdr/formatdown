## ----setup--------------------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

library(formatdown)
library(data.table)
library(knitr)

options(
  datatable.print.nrows = 15,
  datatable.print.topn = 5,
  datatable.print.class = TRUE
)

## -----------------------------------------------------------------------------
hyphenated <- c(
  "$\\mathrm{C}$--$\\mathrm{12}$",
  "$\\mathrm{Fe}$--$\\mathrm{54}$",
  "$\\mathrm{U}$--$\\mathrm{238}$"
)
x <- c("C-12", "Fe-54", "U-238")
nuclear <- format_nucl(x)
with_Z <- format_nucl(x, Z = TRUE)
DT <- data.table(hyphenated, with_Z, nuclear)
setnames(DT,
  old = c("with_Z", "nuclear"),
  new = c("nuclear (with Z)", "nuclear (omit Z)")
)
knitr::kable(DT, align = "ccc")

## -----------------------------------------------------------------------------
# library("formatdown")
# library("data.table")
# library("knitr")

## -----------------------------------------------------------------------------
# 1. Carbon-12
x <- "C-12"
format_nucl(x)

# 2. Uranium-238
y <- "U-238"
format_nucl(y)

## -----------------------------------------------------------------------------
# 3. Carbon-12
x <- "C-12"
format_nucl(x, Z = TRUE)

# 4. Uranium-238
y <- "U-238"
format_nucl(y, Z = TRUE)

## -----------------------------------------------------------------------------
formatdown_options(Z = TRUE)

# 5. Carbon-12
format_nucl(x)

# 6. Uranium-238
format_nucl(y)

## -----------------------------------------------------------------------------
# reset the Z option only
formatdown_options(Z = FALSE)

## -----------------------------------------------------------------------------
# 7. Compare available typefaces
x <- c("He-4", "C-12", "Pb-204", "U-238")
plain <- format_nucl(x, face = "plain", Z = TRUE)
italic <- format_nucl(x, face = "italic", Z = TRUE)
bold <- format_nucl(x, face = "bold", Z = TRUE)
sans <- format_nucl(x, face = "sans", Z = TRUE)
mono <- format_nucl(x, face = "mono", Z = TRUE)
DT <- data.table(plain, italic, bold, sans, mono)
knitr::kable(DT, align = "l", caption = "Example 7.")

## -----------------------------------------------------------------------------
element_set

## -----------------------------------------------------------------------------
# 8. Hydrogen isotopes
x <- c("H-1", "H-2", "H-3")
format_nucl(x, Z = TRUE)

## -----------------------------------------------------------------------------
# 9. Input errors
x <- c("Carbon-12", "C-40", "C-12")
format_nucl(x)

## -----------------------------------------------------------------------------
# 10. Symbol for atomic number
format_nucl(x, Z = TRUE)

## -----------------------------------------------------------------------------
# 11. General nuclear form
x <- c("E-A")
format_nucl(x, warn = FALSE)

## -----------------------------------------------------------------------------
# 12. General nuclear form with atomic number symbol
x <- c("E-A")
format_nucl(x, Z = TRUE, warn = FALSE)

## -----------------------------------------------------------------------------
# 13. Alternate general form.
x <- c("X-A")
format_nucl(x, Z = TRUE, warn = FALSE)

## -----------------------------------------------------------------------------
# 14. Sample vector
x <- c("H-1", "H-2", "He-3", "He-4", "Li-6", "Li-7", "Be-9")
format_nucl(x)

## -----------------------------------------------------------------------------
DT <- data.table(x, format_nucl(x))
knitr::kable(DT,
  align = "c",
  col.names = c("Hyphenated form", "Nuclear notation"),
  caption = "Example 14."
)

## -----------------------------------------------------------------------------
# 15. Table with Z
DT <- data.table(x, format_nucl(x, Z = TRUE))
knitr::kable(DT,
  align = "c",
  col.names = c("Hyphenated form", "Nuclear notation"),
  caption = "Example 15."
)

