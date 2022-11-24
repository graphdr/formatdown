
<!-- Edit README.Rmd (not README.md) -->

# formatdown <img src="man/figures/logo.png" align="right">

Formatting Tools for *rmarkdown* Documents

<!-- badges: start -->

[![](https://www.r-pkg.org/badges/version/formatdown)](https://cran.r-project.org/package=formatdown)
[![R-CMD-check](https://github.com/graphdr/formatdown/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/graphdr/formatdown/actions/workflows/check-standard.yaml)
[![Codecov test
coverage](https://codecov.io/gh/graphdr/formatdown/branch/main/graph/badge.svg)](https://app.codecov.io/gh/graphdr/formatdown?branch=main)
[![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Provides a small set of tools for formatting tasks when creating
documents in *rmarkdown* or *quarto.* Convert the elements of a
numerical vector to character strings in which the numbers are formatted
in decimal notation or using powers-of-ten notation in scientific or
engineering form and delimited for rendering as inline equations.

## Usage

``` r
# Packages
library("formatdown")
library("data.table")
library("knitr")
```

**`format_power()`**  
Convert the elements of a numerical vector to character strings in which
the numbers are formatted using powers-of-ten notation in scientific or
engineering form and delimited for rendering as inline equations in an
*rmarkdown* document. The `digits` argument sets the number of
significant digits.

**`format_decimal()`**  
Similar to above, but in decimal notation. The `digits` argument sets
the number of decimal places.

*Scalar values*, typically rendered inline:

``` r
# Scientific notation
format_power(101100, digits = 4, format = "sci")
#> [1] "$1.011 \\times 10^{5}$"

# Engineering notation
format_power(101100, digits = 4, format = "engr")
#> [1] "$101.1 \\times 10^{3}$"

# Decimal notation
format_decimal(101100, digits = 0, big_mark = ",")
#> [1] "$101,100$"
```

which, in an *.Rmd* or *.qmd* document, are rendered using inline math
as

- Scientific notation: $1.011 \times 10^{5}$.
- Engineering notation: $101.1 \times 10^{3}$
- Decimal notation: $101,100$.

*Data frame*, typically rendered as a table. We independently format
three columns from the `water` data frame included with *formatdown*.

``` r
# Extract three columns
properties <- water[, .(temp, visc, bulk_mod)]

# Decimal notation 
properties[, temp := format_decimal(temp, 1)]

# Power-of-ten notation with fixed exponent
properties[, visc := format_power(visc, set_power = -3)]

# Power-of-ten notation with 3 significant figures
properties[, bulk_mod := format_power(bulk_mod, 3)]

# Render in document
knitr::kable(properties, 
             align = "r",  
             caption = "Table 1: Properties of water as a function of temperature.", 
             col.names = c("Temperatue [K]", "Viscosity [Pa-s]", "Bulk modulus [Pa]"))
```

| Temperatue \[K\] |      Viscosity \[Pa-s\] |  Bulk modulus \[Pa\] |
|-----------------:|------------------------:|---------------------:|
|          $273.1$ |  $1.734 \times 10^{-3}$ | $2.02 \times 10^{9}$ |
|          $283.1$ |  $1.310 \times 10^{-3}$ | $2.10 \times 10^{9}$ |
|          $293.1$ |  $1.021 \times 10^{-3}$ | $2.18 \times 10^{9}$ |
|          $303.1$ | $0.8174 \times 10^{-3}$ | $2.25 \times 10^{9}$ |
|          $313.1$ | $0.6699 \times 10^{-3}$ | $2.28 \times 10^{9}$ |
|          $323.1$ | $0.5605 \times 10^{-3}$ | $2.29 \times 10^{9}$ |
|          $333.1$ | $0.4776 \times 10^{-3}$ | $2.28 \times 10^{9}$ |
|          $343.1$ | $0.4135 \times 10^{-3}$ | $2.25 \times 10^{9}$ |
|          $353.1$ | $0.3631 \times 10^{-3}$ | $2.20 \times 10^{9}$ |
|          $363.1$ | $0.3229 \times 10^{-3}$ | $2.14 \times 10^{9}$ |
|          $373.1$ | $0.2902 \times 10^{-3}$ | $2.07 \times 10^{9}$ |

Table 1: Properties of water as a function of temperature.

## Installation

Install from CRAN.

``` r
install.packages("formatdown")
```

The development version can be installed from GitHub.

``` r
install.packages("devtools")
devtools::install_github("graphdr/formatdown")
```

## Requirements

- <a href="https://www.r-project.org/" target="_blank">R</a> (\>= 3.5.0)
- <a href="https://rdatatable.gitlab.io/data.table/"
  target="_blank">data.table</a> (\>= 1.9.8)

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

- [R](https://www.r-project.org/) and [RStudio](https://posit.co/) for
  the working environment
- [wrapr](https://CRAN.R-project.org/package=wrapr),
  [checkmate](https://CRAN.R-project.org/package=checkmate), and
  [tinytest](https://CRAN.R-project.org/package=tinytest) for
  programming tools
- [devtools](https://CRAN.R-project.org/package=devtools) and
  [pkgdown](https://CRAN.R-project.org/package=pkgdown) for package
  building
- [rmarkdown](https://CRAN.R-project.org/package=rmarkdown) and
  [knitr](https://CRAN.R-project.org/package=knitr) for authoring tools
- [data.table](https://CRAN.R-project.org/package=data.table) for its
  programmable syntax
