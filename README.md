
<!-- Edit README.Rmd (not README.md) -->

# formatdown <img src="man/figures/logo.png" align="right">

Formatting Tools for R Markdown Documents

<!-- badges: start -->

[![](https://www.r-pkg.org/badges/version/formatdown)](https://cran.r-project.org/package=formatdown)
[![R-CMD-check](https://github.com/graphdr/formatdown/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/graphdr/formatdown/actions/workflows/check-standard.yaml)
[![Codecov test
coverage](https://codecov.io/gh/graphdr/formatdown/branch/main/graph/badge.svg)](https://app.codecov.io/gh/graphdr/formatdown?branch=main)
[![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Provides a small set of tools for formatting tasks when creating
documents in R Markdown or Quarto Markdown. Convert the elements of a
numerical vector to character strings in one of several forms:
powers-of-ten notation in engineering or scientific form delimited for
rendering as inline equations; integer or decimal notation delimited for
equation rendering; numbers with measurement units (non-delimited) where
units are selected to eliminate the need for powers-of-ten or scientific
notation. Useful for rendering a numerical scalar in an inline R code
chunk as well as formatting columns of data frames displayed in a table.

## Introduction

In professional technical prose, large and small numbers are generally
typeset using powers of ten notation. For example, Plank’s constant
would be typeset as $6.626 \times 10^{-34}$ J/Hz rather than the
familiar forms we use in communicating with computers, such as
`6.626*10^34` or `6.626E-34`.

The functions in this package help an author convert large and small
numbers to character strings, formatted using powers-of-ten notation
(and other formats) suitable for use in technical writing or
presentations.

Formatting tools include:

**`format_power()`**  
Convert the elements of a numerical vector to character strings in which
the numbers are formatted using powers-of-ten notation in scientific or
engineering form and delimited for rendering as inline equations in
`.Rmd` or `.qmd` markdown files.

**`format_decimal()`**  
Similar to above, but as integers or decimals

**`format_units()`**  
Format a vector of numbers as character strings with measurement units
appended via the ‘units’ package.

## Usage

``` r
# Packages
library("formatdown")
library("data.table")
library("knitr")
```

*Scalar values.*   Typically rendered inline:

``` r
x <- 101300

# Scientific notation, math delimited
format_power(x, digits = 4, format = "sci")
#> [1] "$1.013 \\times 10^{5}$"

# Engineering notation, math-delimited
format_power(x, digits = 4, format = "engr")
#> [1] "$101.3 \\times 10^{3}$"

# Decimal notation, math-delimited
format_decimal(x, digits = 0, big_mark = ",")
#> [1] "$101,300$"

# Unit notation, non-delimited
units(x) <- "Pa"
format_units(x, unit = "hPa")
#> [1] "1013 [hPa]"
```

which, in an `.Rmd` or `.qmd` output document, are rendered using inline
R code as

|           Notation |           Rendered as |
|-------------------:|----------------------:|
|         scientific | $1.013 \times 10^{5}$ |
|        engineering | $101.3 \times 10^{3}$ |
| integer or decimal |             $101,300$ |
|              units |          1013 \[hPa\] |

*Data frame*.   Typically rendered as a table. We independently format
columns from the `water` data frame included with `formatdown`.

``` r
# Extract three columns
properties <- water[, .(temp, visc, bulk_mod)]

# Decimal notation
properties[, temp := format_decimal(temp, 1)]

# Power-of-ten notation with fixed exponent
properties[, visc := format_power(visc, set_power = -3)]

# Power-of-ten notation with 3 significant figures
properties[, bulk_mod := format_power(bulk_mod, 3)]

# Unit notation
properties$bulk_mod_GPa <- water$bulk_mod
units(properties$bulk_mod_GPa) <- "Pa"
properties[, bulk_mod_GPa := format_units(bulk_mod_GPa, 3, unit = "GPa")]

# Render in document
knitr::kable(properties,
  align = "r",
  caption = "Table 1: Properties of water as a function of temperature.",
  col.names = c("Temperature [K]", "Viscosity [Pa-s]", "Bulk modulus [Pa]", "Bulk modulus [GPa]")
)
```

| Temperature \[K\] |      Viscosity \[Pa-s\] |  Bulk modulus \[Pa\] | Bulk modulus \[GPa\] |
|------------------:|------------------------:|---------------------:|---------------------:|
|           $273.1$ |  $1.734 \times 10^{-3}$ | $2.02 \times 10^{9}$ |         2.02 \[GPa\] |
|           $283.1$ |  $1.310 \times 10^{-3}$ | $2.10 \times 10^{9}$ |         2.10 \[GPa\] |
|           $293.1$ |  $1.021 \times 10^{-3}$ | $2.18 \times 10^{9}$ |         2.18 \[GPa\] |
|           $303.1$ | $0.8174 \times 10^{-3}$ | $2.25 \times 10^{9}$ |         2.25 \[GPa\] |
|           $313.1$ | $0.6699 \times 10^{-3}$ | $2.28 \times 10^{9}$ |         2.28 \[GPa\] |
|           $323.1$ | $0.5605 \times 10^{-3}$ | $2.29 \times 10^{9}$ |         2.29 \[GPa\] |
|           $333.1$ | $0.4776 \times 10^{-3}$ | $2.28 \times 10^{9}$ |         2.28 \[GPa\] |
|           $343.1$ | $0.4135 \times 10^{-3}$ | $2.25 \times 10^{9}$ |         2.25 \[GPa\] |
|           $353.1$ | $0.3631 \times 10^{-3}$ | $2.20 \times 10^{9}$ |         2.20 \[GPa\] |
|           $363.1$ | $0.3229 \times 10^{-3}$ | $2.14 \times 10^{9}$ |         2.14 \[GPa\] |
|           $373.1$ | $0.2902 \times 10^{-3}$ | $2.07 \times 10^{9}$ |         2.07 \[GPa\] |

Table 1: Properties of water as a function of temperature.

## Installation

Install from CRAN.

``` r
install.packages("formatdown")
```

The development version can be installed from GitHub.

``` r
install.packages("pak")
pak::pkg_install("graphdr/formatdown")
```

## Requirements

- [`R`](https://www.r-project.org/) (\>= 3.5.0)
- [`data.table`](https://rdatatable.gitlab.io/data.table/) (\>= 1.9.8)

## Contributing

To contribute to formatdown,

- Please clone this repo locally.  
- Commit your contribution on a separate branch.
- If you submit a function, please use the *checkmate* package to
  include runtime argument checks.

To provide feedback or report a bug,

- Use the GitHub <a href="https://github.com/graphdr/formatdown/issues">
  Issues</a> page.
- Please run the package unit tests and report the results with your bug
  report. Any user can run the package tests by installing the
  *tinytest* package and running:

``` r
# Detailed test results
test_results <- tinytest::test_package("formatdown")
as.data.frame(test_results)
```

Participation in this open source project is subject to a [Code of
Conduct](https://graphdr.github.io/formatdown/CONDUCT.html).

## Software credits

- [`R`](https://www.r-project.org/) and [`RStudio`](https://posit.co/)
  for the working environment  
- [`rmarkdown`](https://CRAN.R-project.org/package=rmarkdown) and
  [`knitr`](https://CRAN.R-project.org/package=knitr) for authoring
  tools  
- [`data.table`](https://CRAN.R-project.org/package=data.table) for its
  programmable syntax  
- [`wrapr`](https://CRAN.R-project.org/package=wrapr),
  [`checkmate`](https://CRAN.R-project.org/package=checkmate), and
  [`tinytest`](https://CRAN.R-project.org/package=tinytest) for
  programming tools
- [`devtools`](https://CRAN.R-project.org/package=devtools) and
  [`pkgdown`](https://CRAN.R-project.org/package=pkgdown) for package
  building
