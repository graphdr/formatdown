
<!-- Edit README.Rmd (not README.md) -->

# formatdown <img src="man/figures/logo.png" align="right">

Formatting tools for R markdown documents.

<!-- badges: start -->

[![](https://www.r-pkg.org/badges/version/formatdown)](https://cran.r-project.org/package=formatdown)
[![R-CMD-check](https://github.com/graphdr/formatdown/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/graphdr/formatdown/actions/workflows/check-standard.yaml)
[![Codecov test
coverage](https://codecov.io/gh/graphdr/formatdown/branch/main/graph/badge.svg)](https://app.codecov.io/gh/graphdr/formatdown?branch=main)
[![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Provides a small set of tools for formatting tasks when writing
documents in R Markdown or Quarto Markdown. Works with outputs in html,
pdf, docx and possibly others.

## Usage

``` r
# Packages
library("formatdown")
library("data.table")
```

**`format_power()`**   Convert the elements of a numerical vector to
character strings in which the numbers are formatted using powers-of-ten
notation in scientific or engineering form and delimited for rendering
as inline equations in an R Markdown document.

``` r
# Scientific notation
format_power(101100, digits = 4, format = "sci")
#> [1] "$1.011\\times{10}^{5}$"

# Engineering notation
format_power(101100, digits = 4, format = "engr")
#> [1] "$101.1\\times{10}^{3}$"
```

which, in an Rmd or qmd document, are rendered as

- Scientific notation: $1.011\times{10}^{5}$.
- Engineering notation: $101.1\times{10}^{3}$

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
