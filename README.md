
<!-- Edit README.Rmd (not README.md) -->

# formatdown <img src="man/figures/logo.png" align="right">

Formatting Numbers in R Markdown Documents

<!-- badges: start -->

[![](https://www.r-pkg.org/badges/version/formatdown)](https://cran.r-project.org/package=formatdown)
[![R-CMD-check](https://github.com/graphdr/formatdown/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/graphdr/formatdown/actions/workflows/check-standard.yaml)
[![Codecov test
coverage](https://codecov.io/gh/graphdr/formatdown/branch/main/graph/badge.svg)](https://app.codecov.io/gh/graphdr/formatdown?branch=main)
[![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Provides a small set of tools for formatting numbers in R-markdown
documents. Converts a numerical vector to character strings in
power-of-ten form, decimal form, or measurement-units form; all are
math-delimited for rendering as inline equations. Useful for rendering
numerical scalars using inline R code chunks or for rendering numerical
columns in tables.

## Introduction

In professional technical prose, large and small numbers are generally
typeset using powers of ten notation. For example, Plank’s constant
would be typeset as $\small 6.63 \times 10^{-34}$
$\small\mathrm{J\\/Hz}$ rather than the familiar forms we use in
communicating with computers, such as `6.63*10^-34` or `6.63E-34`.

The functions in this package help an author convert large and small
numbers to character strings, formatted using powers-of-ten notation. In
addition, decimal numbers and text can be formatted with the same font
face and size as the power-of-ten numbers for a consistent typeface
across all columns of a data table.

Formatting tools include:

**`format_numbers()`**  
Convert a numeric vector to a math-delimited character vector in which
the numbers are formatted in power-of-ten notation in scientific or
engineering form. Decimal numbers can be similarly formatted.

**`format_text()`**  
Convert a character vector to math-delimited character vector. Useful
for creating a consistent typeface across all columns of a table.

**`format_units()`**  
Convert a numeric vector to class “units” via the **units** R package
and then to a math-delimited character vector.

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

# Scientific notation
format_numbers(x, digits = 4, format = "sci")
#> [1] "$\\small 1.013 \\times 10^{5}$"

# Engineering notation
format_numbers(x, digits = 4, format = "engr")
#> [1] "$\\small 101.3 \\times 10^{3}$"

# Decimal notation
format_numbers(x, digits = 4, format = "dcml")
#> [1] "$\\small 101300$"

# Measurement units notation
units(x) <- "Pa"
format_units(x, digits = 4, unit = "hPa")
#> [1] "$\\small\\mathrm{1013\\ [hPa]}$"
```

which, in an `.Rmd` or `.qmd` output document, are rendered using inline
R code as

|      Format |                  Rendered as |
|------------:|-----------------------------:|
|  scientific | $\small 1.013 \times 10^{5}$ |
| engineering | $\small 101.3 \times 10^{3}$ |
|     decimal |              $\small 101300$ |
|       units | $\small\mathrm{1013\ [hPa]}$ |

*Data frame*.   Typically rendered in a table. We independently format
columns from the `metals` data frame included with formatdown.

``` r
# View the data set
metals
#>            metal  dens  thrm_exp thrm_cond  elast_mod
#>           <char> <num>     <num>     <num>      <num>
#> 1: aluminum 6061  2700 2.430e-05    155.77 7.3084e+10
#> 2:        copper  8900 1.656e-05    392.88 1.1721e+11
#> 3:          lead 11340 5.274e-05     37.04 1.3790e+10
#> 4:      platinum 21450 9.000e-06     69.23 1.4686e+11
#> 5:    steel 1020  7850 1.134e-05     46.73 2.0684e+11
#> 6:      titanium  4850 9.360e-06      7.44 1.0204e+11

# First column in text format
DT <- copy(metals)
DT$metal <- format_text(DT$metal)

# Density and thermal conductivity in decimal form
cols_we_want <- c("dens", "thrm_cond")
DT[, cols_we_want] <- lapply(DT[, ..cols_we_want], function(x) format_numbers(x,
    3, "dcml"))

# Thermal expansion in engineering format
DT$thrm_exp <- format_numbers(DT$thrm_exp, 3, "engr")

# Elastic modulus in units form
units(DT$elast_mod) <- "Pa"
DT$elast_mod <- format_units(DT$elast_mod, 3, "GPa")

# Render in document
knitr::kable(DT, align = "r", caption = "Table 1: Properties of metals.", col.names = c("Metal",
    "Density [kg/m$^3$]", "Therm. expan. [m/m K$^{-1}$]", "Therm. cond. [W/m K$^{-1}$]",
    "Elastic modulus"))
```

|                           Metal | Density \[kg/m$^3$\] | Therm. expan. \[m/m K$^{-1}$\] | Therm. cond. \[W/m K$^{-1}$\] |               Elastic modulus |
|--------------------------------:|---------------------:|-------------------------------:|------------------------------:|------------------------------:|
| $\small\mathrm{aluminum\ 6061}$ |        $\small 2700$ |   $\small 24.3 \times 10^{-6}$ |                  $\small 156$ |  $\small\mathrm{73.1\ [GPa]}$ |
|         $\small\mathrm{copper}$ |        $\small 8900$ |   $\small 16.6 \times 10^{-6}$ |                  $\small 393$ | $\small\mathrm{117.0\ [GPa]}$ |
|           $\small\mathrm{lead}$ |       $\small 11300$ |   $\small 52.7 \times 10^{-6}$ |                 $\small 37.0$ |  $\small\mathrm{13.8\ [GPa]}$ |
|       $\small\mathrm{platinum}$ |       $\small 21400$ |   $\small 9.00 \times 10^{-6}$ |                 $\small 69.2$ | $\small\mathrm{147.0\ [GPa]}$ |
|    $\small\mathrm{steel\ 1020}$ |        $\small 7850$ |   $\small 11.3 \times 10^{-6}$ |                 $\small 46.7$ | $\small\mathrm{207.0\ [GPa]}$ |
|       $\small\mathrm{titanium}$ |        $\small 4850$ |   $\small 9.36 \times 10^{-6}$ |                 $\small 7.44$ | $\small\mathrm{102.0\ [GPa]}$ |

Table 1: Properties of metals.

## Installation

Install from CRAN.

``` r
install.packages("formatdown")
```

The development version can be installed from GitHub. I suggest using
the “pak” package:

``` r
pak::pkg_install("graphdr/formatdown")
```

## Requirements

- [`R`](https://www.r-project.org/) (\>= 3.5.0)
- [`data.table`](https://rdatatable.gitlab.io/data.table/) (\>= 1.9.8)

## Contributing

To provide feedback or report a bug,

- Use the GitHub <a href="https://github.com/graphdr/formatdown/issues">
  Issues</a> page.

To contribute to formatdown,

- Please clone this repo locally.  
- Commit your contribution on a separate branch.
- Submit a pull request

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
