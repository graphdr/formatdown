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
library(stringr)

options(
  datatable.print.nrows = 15,
  datatable.print.topn = 3,
  datatable.print.class = TRUE
)

## -----------------------------------------------------------------------------
formatdown_options(size = "small")

prefix_1 <- c("peta", "tera", "giga", "mega", "kilo")

symbol_1 <- c("P", "T", "G", "M", "k")
symbol_1 <- format_text(symbol_1, face = "italic")

x <- 10^seq(from = 15, to = 3, by = -3)
value_1 <- format_numbers(x, digits = 1, format = "engr", omit_power = NULL)
value_1 <- sub("1 \\\\times ", "", value_1)

prefix_2 <- c("milli", "micro", "nano", "pico", "femto")

symbol_2 <- c("m", "\\mu", "n", "p", "f")
symbol_2 <- format_text(symbol_2, face = "italic")

x <- 10^seq(from = -3, to = -15, by = -3)
value_2 <- format_numbers(x, 1, omit_power = NULL)
value_2 <- sub("1 \\\\times ", "", value_2)

DT <- data.table(prefix_1, symbol_1, value_1, prefix_2, symbol_2, value_2)
knitr::kable(DT,
  align = "lcllcl",
  col.names = rep(c("Prefix", "Symbol", "Value"), 2)
)

## -----------------------------------------------------------------------------
x <- 3.12 * 10^seq(-3, 4)

sci <- format_sci(x, 3, omit_power = NA)
sci_omit <- format_sci(x, 3)
DT <- data.table(sci, sci_omit)

knitr::kable(DT,
  align = "r",
  caption = "Decimal form may be preferred for a subset",
  col.names = c(
    "scientific notation",
    "subset in decimal form"
  )
)

## -----------------------------------------------------------------------------
DT <- atmos[alt < 150, .(alt, temp, dens)]

DT$alt <- format_dcml(DT$alt, 2)
DT$temp <- format_dcml(DT$temp, 5)
DT$dens <- format_engr(DT$dens, 3)
knitr::kable(DT,
  align = "r",
  caption = "Properties of the atmosphere",
  col.names = c(
    "Altitude (km)",
    "Temperature (K)",
    "Density (kg/m$^3$)"
  )
)

formatdown_options(reset = TRUE)

## -----------------------------------------------------------------------------
#  library("formatdown")
#  library("data.table")
#  library("knitr")

## -----------------------------------------------------------------------------
# 1. Avogadro constant
L <- 6.0221E+23
format_sci(L)

# 2. Elementary charge
e <- 1.602176634e-19
format_sci(e)

## -----------------------------------------------------------------------------
# 3. Avogadro constant
format_engr(L)

# 4. Elementary charge
format_engr(e)

## -----------------------------------------------------------------------------
# 5. Speed of light in a vacuum
c <- 299792458
format_dcml(c)

# 6. Molar gas constant
R <- 8.31446261815324
format_dcml(R)

## -----------------------------------------------------------------------------
# 7. Scientific
format_numbers(L, format = "sci")

# 8. Engineering
format_numbers(e, format = "engr")

# 9. Decimal
format_numbers(R, format = "dcml")

## -----------------------------------------------------------------------------
# 10. Sample vector
x <- c(2.3333e-5, 3.4444e-4, 5.2222e-2, 6.3333e-1, 8.1111e+1, 9.2222e+2, 2.4444e+4, 3.1111e+5, 4.2222e+6)
format_engr(x)

## -----------------------------------------------------------------------------
formatdown_options(size = "small")

## -----------------------------------------------------------------------------
DT <- data.table(x, format_engr(x))
knitr::kable(DT,
  align = "r",
  col.names = c("Unformatted", "Engr notation"),
  caption = "Example 10."
)

## -----------------------------------------------------------------------------
formatdown_options(reset = TRUE)

## -----------------------------------------------------------------------------
# Number
x <- 10320
class(x)

# Convert to units class
units(x) <- "m"
x
class(x)

# Operations are reflected in the values and its units
y <- x^2
y

# Unit conversion is supported
z <- y
z
units(z) <- "ft^2"
z

## -----------------------------------------------------------------------------
# 11. Units-class inputs
format_sci(x)
format_sci(y)
format_sci(z)

## -----------------------------------------------------------------------------
G <- 6.6743e-11
units(G) <- "m3 kg-1 s-2"
format_sci(G)

## -----------------------------------------------------------------------------
c <- 299792458
units(c) <- "m/s"
format_c <- format_sci(c, size = "small")

h <- 6.62607015e-34
units(h) <- "J/Hz"
format_h <- format_sci(h, size = "small")

mu <- 1.25663706212e-6
units(mu) <- "N A-2"
format_mu <- format_sci(mu, size = "small")

G <- 6.67430e-11
units(G) <- "m3 kg-1 s-2"
format_G <- format_sci(G, size = "small")

ke <- 8.9875517923e+9
units(ke) <- "N m2 C-2"
format_ke <- format_sci(ke, size = "small")

sigma <- 5.67037442e-8
units(sigma) <- "W m-2 K-4"
format_sigma <- format_sci(sigma, size = "small")

symbol <- c(
  "$\\small G$",
  "$\\small c$",
  "$\\small h$",
  "$\\small \\mu_0$",
  "$\\small k_e$",
  "$\\small \\sigma$"
)

quantity <- format_text(
  c(
    "Newtonian gravitational constant",
    "speed of light in a vacuum",
    "Planck constant",
    "vacuum magnetic permeability",
    "Coulomb constant",
    "Stefan-Boltzmann constant"
  ),
  size = "small"
)

formatted_value <- c(
  format_G,
  format_c,
  format_h,
  format_mu,
  format_ke,
  format_sigma
)

DT <- data.table(symbol, quantity, formatted_value)
knitr::kable(DT, caption = "Illustrating a variety of measurement units")

## -----------------------------------------------------------------------------
formatdown_options(size = "small")

## -----------------------------------------------------------------------------
# Example 12
DT <- air_meas[, .(temp, pres, sp_gas, dens)]

# Examine data
DT[]

# Assign units
units(DT$temp) <- "K"
units(DT$pres) <- "Pa"
units(DT$sp_gas) <- "J kg-1 K-1"
units(DT$dens) <- "kg m-3"

# Make a copy to preserve DT as-is for a subsequent example
x <- copy(DT)

# Format one column at a time
x$temp <- format_dcml(x$temp)
x$pres <- format_engr(x$pres)

# Or format multiple columns in one pass
cols <- c("sp_gas", "dens")
x[, (cols) := lapply(.SD, format_dcml), .SDcols = cols]

knitr::kable(x, align = "r", caption = "Example 12.")

## -----------------------------------------------------------------------------
formatdown_options(reset = TRUE)

## -----------------------------------------------------------------------------
formatdown_options(size = "small")

## -----------------------------------------------------------------------------
# Example 13.
y <- copy(DT)

## -----------------------------------------------------------------------------
# Preserve column names
col_names <- names(y)
col_names

# Preserve units and surround by square brackets for display
unit_list <- sapply(y, units::deparse_unit)
unit_list <- paste0("[", unit_list, "]")
unit_list

## -----------------------------------------------------------------------------
# Drop units from values
y <- units::drop_units(y)

# Format numerical columns
y$temp <- format_dcml(y$temp)
y$pres <- format_engr(y$pres)
cols <- c("sp_gas", "dens")
y[, (cols) := lapply(.SD, format_dcml), .SDcols = cols]

## -----------------------------------------------------------------------------
knitr::kable(y,
  caption = "Example 13.",
  col.names = unit_list,
  align = "r"
) |>
  kableExtra::add_header_above(header = col_names, line = FALSE, align = "r")

## -----------------------------------------------------------------------------
formatdown_options(reset = TRUE)

## -----------------------------------------------------------------------------
# Example 14.
unit_row <- DT[1]
unit_row

# By columns, remove numbers, retain formatted units
for (jj in names(unit_row)) {
  # Select column
  q <- unit_row[, get(jj)]
  # Format the number with its units
  q <- format_numbers(q)
  # Regular expression to identify characters between the $ sign and \\mathrm
  regex <- "(?<=\\$).*?(?=\\\\mathrm)"
  # Remove those characters, leaving the formatted unit string
  unit_row[, jj] <- stringr::str_remove(q, regex)
}
# Convert the data frame row to a vector
unit_vec <- unname(unlist(unit_row[1]))
unit_vec

## -----------------------------------------------------------------------------
# Insert parentheses just inside the math delimiters
unit_vec <- stringr::str_replace_all(unit_vec, "\\$", "")
# Add parentheses around units and reinstate the math delimiters
unit_vec <- paste0("$\\left(", unit_vec, "\\right)$")
unit_vec

## -----------------------------------------------------------------------------
# Make the column names presentable
col_names <- names(DT) |>
  stringr::str_replace("temp", "Temperature") |>
  stringr::str_replace("pres", "Pressure") |>
  stringr::str_replace("sp_gas", "Gas constant") |>
  stringr::str_replace("dens", "Density")

# Re-using the formatted data frame "y" from the previous example
# The unit vector is used for table col.name
knitr::kable(y,
  caption = "Example 14.",
  col.names = unit_vec,
  align = "r"
) |>
  # Adjust the font size
  kableExtra::kable_styling(font_size = 13) |>
  # Make the units row a slightly smaller font size
  kableExtra::row_spec(0, font_size = 10) |>
  # Add a header above the units with the variable names
  kableExtra::add_header_above(header = col_names, line = FALSE, align = "r")

## -----------------------------------------------------------------------------
# 15. Significant digits
format_sci(e, digits = 5)
format_sci(e, digits = 4)
format_sci(e, digits = 3)

## -----------------------------------------------------------------------------
formatdown_options(size = "small")

## -----------------------------------------------------------------------------
# 16. Comparing formats
x <- c(2.3333e-5, 3.4444e-4, 5.2222e-2, 6.3333e-1, 8.1111e+1, 9.2222e+2, 2.4444e+4, 3.1111e+5, 4.2222e+6)
dcml <- format_numbers(x, 3, format = "dcml")
sci <- format_numbers(x, 3, format = "sci")
engr <- format_numbers(x, 3, format = "engr")
DT <- data.table(dcml, sci, engr)
knitr::kable(DT,
  align = "r",
  col.names = c("decimal", "scientific", "engineering"),
  caption = "Example 16."
)

## -----------------------------------------------------------------------------
formatdown_options(reset = TRUE)

## -----------------------------------------------------------------------------
formatdown_options(size = "small")

## -----------------------------------------------------------------------------
# 17. Effects of omit_power
DT <- atmos[3:12, .(pres)]
DT[, sci_all := format_sci(pres, 3, omit_power = NULL)]
DT[, sci_omit := format_sci(pres, 3, omit_power = c(-1, 0))]
DT[, engr_all := format_engr(pres, 3, omit_power = NULL)]
DT[, engr_omit := format_engr(pres, 3, omit_power = c(-1, 0))]
knitr::kable(DT,
  align = "r",
  col.names = c(
    "Unformatted",
    "all scientific",
    "scientific w/ omit",
    "all engineering",
    "engineering w/ omit"
  ),
  caption = "Example 17."
)

## -----------------------------------------------------------------------------
# 18. Omit power used for a single value of exponent
DT <- atmos[3:12, .(pres)]
DT[, sci_all := format_sci(pres, 3, omit_power = NULL)]
DT[, sci_omit := format_sci(pres, 3, omit_power = 0)]
DT[, engr_all := format_engr(pres, 3, omit_power = NULL)]
DT[, engr_omit := format_engr(pres, 3, omit_power = 0)]
knitr::kable(DT,
  align = "r",
  col.names = c(
    "Unformatted",
    "all scientific",
    "scientific w/ omit",
    "all engineering",
    "engineering w/ omit"
  ),
  caption = "Example 18."
)

## -----------------------------------------------------------------------------
formatdown_options(reset = TRUE)

## -----------------------------------------------------------------------------
# 19. Different ways of creating a decimal format
(y <- 6.78e-3)

(p <- format_numbers(y, 3, "sci", omit_power = c(-Inf, Inf)))

(q <- format_numbers(y, 3, "dcml"))

(r <- format_dcml(y, 3))

all.equal(p, q)
all.equal(p, r)

## -----------------------------------------------------------------------------
formatdown_options(size = "small")

## -----------------------------------------------------------------------------
# 20. set_power argument
DT <- atmos[alt <= 40, .(alt, pres, dens)]
DT[, sci_pres := format_sci(pres, 3, omit_power = c(-1, 2))]
DT[, set_pres := format_sci(pres, 3, omit_power = c(-1, 2), set_power = 3)]
DT[, sci_dens := format_engr(dens, 3, omit_power = c(-1, 2))]
DT[, set_dens := format_engr(dens, 3, omit_power = c(-1, 2), set_power = -2)]
DT[, pres := NULL]
DT[, dens := NULL]
knitr::kable(DT,
  align = "r",
  col.names = c("Altitude (km)", "Pressure (Pa)", "with set_power", "Density (kg/m$^{3}$)", "with set_power"),
  caption = "Example 20."
)

## -----------------------------------------------------------------------------
formatdown_options(reset = TRUE)

