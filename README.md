
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
using powers-of-ten notation in scientific or engineering form and
delimited for rendering as inline equations.

## Usage

``` r
# Packages
library("formatdown")
library("data.table")
library("knitr")
```

**`format_power()`**   Convert the elements of a numerical vector to
character strings in which the numbers are formatted using powers-of-ten
notation in scientific or engineering form and delimited for rendering
as inline equations in an *rmarkdown* document.

``` r
# Scientific notation
format_power(101100, digits = 4, format = "sci")
#> [1] "$1.011 \\times 10^{5}$"

# Engineering notation
format_power(101100, digits = 4, format = "engr")
#> [1] "$101.1 \\times 10^{3}$"
```

which, in an *.Rmd* or *.qmd* document, are rendered using inline math
as

- Scientific notation: $1.011 \times 10^{5}$.
- Engineering notation: $101.1 \times 10^{3}$

Here we format two columns from the `water` data frame included with
*formatdown* using `lapply()` and the default 3 significant digits and
engineering notation.

``` r
# Extract two columns
properties <- water[, .(visc, bulk_mod)]

# Format all columns
properties <- properties[, lapply(.SD, function(x) format_power(x))]

# Render in document
kable(properties, align = "r", col.names = c("Viscosity [Pa-s]", "Bulk modulus [Pa]"))
```

|    Viscosity \[Pa-s\] |  Bulk modulus \[Pa\] |
|----------------------:|---------------------:|
| $1.73 \times 10^{-3}$ | $2.02 \times 10^{9}$ |
| $1.31 \times 10^{-3}$ | $2.10 \times 10^{9}$ |
| $1.02 \times 10^{-3}$ | $2.18 \times 10^{9}$ |
|  $817 \times 10^{-6}$ | $2.25 \times 10^{9}$ |
|  $670 \times 10^{-6}$ | $2.28 \times 10^{9}$ |
|  $560 \times 10^{-6}$ | $2.29 \times 10^{9}$ |
|  $478 \times 10^{-6}$ | $2.28 \times 10^{9}$ |
|  $414 \times 10^{-6}$ | $2.25 \times 10^{9}$ |
|  $363 \times 10^{-6}$ | $2.20 \times 10^{9}$ |
|  $323 \times 10^{-6}$ | $2.14 \times 10^{9}$ |
|  $290 \times 10^{-6}$ | $2.07 \times 10^{9}$ |

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
