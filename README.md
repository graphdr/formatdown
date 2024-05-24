
<!-- Edit README.Rmd (not README.md) -->
<!-- Correcting for problems with LaTeX math in the README file only -->
<style type="text/css">
.math {
  font-size: small;
}
</style>

# formatdown <img src="man/figures/logo.png" align="right">

Formatting Numbers in R Markdown Documents

<!-- badges: start -->

[![](https://www.r-pkg.org/badges/version/formatdown)](https://cran.r-project.org/package=formatdown)
[![R-CMD-check](https://github.com/graphdr/formatdown/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/graphdr/formatdown/actions/workflows/check-standard.yaml)
[![Codecov test
coverage](https://codecov.io/gh/graphdr/formatdown/branch/main/graph/badge.svg)](https://app.codecov.io/gh/graphdr/formatdown?branch=main)
[![Lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Provides a small set of tools for formatting numbers in R markdown
documents (file type `.Rmd` or `.qmd`). Converts a numerical vector to
*character strings* in power-of-ten form, decimal form, or
measurement-units form; all are math-delimited within quotation marks
for rendering as inline equations. Useful for rendering numerical
scalars using inline R code chunks or for rendering numerical columns in
tables.

## Introduction

In professional technical prose, large and small numbers are generally
typeset using powers of ten notation. For example, Planck’s constant
would be typeset as $6.63 \times 10^{-34}\>\mathrm{J\,Hz^{-1}}$ rather
than the familiar forms we use in communicating with computers, such as
`6.63*10^-34` or `6.63E-34`.

The functions in this package help an author of an R markdown document
convert large and small numbers to character strings, formatted using
powers-of-ten notation. In addition, decimal numbers and text can be
formatted with the same font face and size as the power-of-ten numbers
for a consistent typeface across all columns of a data table.

Formatting tools include:

**`format_numbers()`**  
Convert a numeric vector to a math-delimited character vector in which
the numbers can be formatted in scientific or engineering power-of-ten
notation or in decimal form.

**`format_sci()`**  
Convenience function. A wrapper around `format_numbers()` for scientific
notation.

**`format_engr()`**  
Convenience function. A wrapper around `format_numbers()` for
engineering notation.

**`format_dcml()`**  
Convenience function. A wrapper around `format_numbers()` for decimal
notation.

**`format_text()`**  
Convert a character vector to math-delimited character vector. Useful
for creating a consistent typeface across all columns of a table.

**`formatdown_options()`**  
Global options are provided for arguments that users would likely prefer
to set once in a document instead of repeating in every function call.
For example, some users prefer a comma decimal marker (“,”) throughout a
document.

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
#> [1] "$1.013 \\times 10^{5}$"

# Engineering notation
format_numbers(x, digits = 4, format = "engr")
#> [1] "$101.3 \\times 10^{3}$"

# Decimal notation
format_numbers(x, digits = 4, format = "dcml")
#> [1] "$101300$"

# With measurement units
units(x) <- "Pa"
units(x) <- "hPa"
format_dcml(x)
#> [1] "$1013\\ \\mathrm{hPa}$"
```

which, in an `.Rmd` or `.qmd` output document, are rendered using inline
R code as

|      Format |           Rendered as |
|------------:|----------------------:|
|  scientific | $1.013 \times 10^{5}$ |
| engineering | $101.3 \times 10^{3}$ |
|     decimal |              $101300$ |
|       units |  $1013\ \mathrm{hPa}$ |

<br>

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
DT[, cols_we_want] <- lapply(DT[, ..cols_we_want], function(x) format_dcml(x, 3))

# Thermal expansion in engineering format
DT$thrm_exp <- format_engr(DT$thrm_exp, 3)

# Elastic modulus in units form
units(DT$elast_mod) <- "Pa"
units(DT$elast_mod) <- "GPa"
DT$elast_mod <- format_dcml(DT$elast_mod, 3)

# Render in document
knitr::kable(DT, align = "r", caption = "Table 1: Properties of metals.", col.names = c("Metal",
    "Density [kg/m$^3$]", "Therm. expan. [m/m K$^{-1}$]", "Therm. cond. [W/m K$^{-1}$]",
    "Elastic modulus"))
```

|                     Metal | Density \[kg/m$^3$\] | Therm. expan. \[m/m K$^{-1}$\] | Therm. cond. \[W/m K$^{-1}$\] |      Elastic modulus |
|--------------------------:|---------------------:|-------------------------------:|------------------------------:|---------------------:|
| $\mathrm{aluminum\ 6061}$ |               $2700$ |          $24.3 \times 10^{-6}$ |                         $156$ | $73.1\ \mathrm{GPa}$ |
|         $\mathrm{copper}$ |               $8900$ |          $16.6 \times 10^{-6}$ |                         $393$ |  $117\ \mathrm{GPa}$ |
|           $\mathrm{lead}$ |              $11300$ |          $52.7 \times 10^{-6}$ |                        $37.0$ | $13.8\ \mathrm{GPa}$ |
|       $\mathrm{platinum}$ |              $21400$ |          $9.00 \times 10^{-6}$ |                        $69.2$ |  $147\ \mathrm{GPa}$ |
|    $\mathrm{steel\ 1020}$ |               $7850$ |          $11.3 \times 10^{-6}$ |                        $46.7$ |  $207\ \mathrm{GPa}$ |
|       $\mathrm{titanium}$ |               $4850$ |          $9.36 \times 10^{-6}$ |                        $7.44$ |  $102\ \mathrm{GPa}$ |

Table 1: Properties of metals.

<br>

*Options*.   For users who prefer a comma as the decimal mark, the
argument can be set once using `formatdown_options()`,

``` r
formatdown_options(decimal_mark = ",")
```

Using the same code as above to format the metals data yields,

|                     Metal | Density \[kg/m$^3$\] | Therm. expan. \[m/m K$^{-1}$\] | Therm. cond. \[W/m K$^{-1}$\] |      Elastic modulus |
|--------------------------:|---------------------:|-------------------------------:|------------------------------:|---------------------:|
| $\mathrm{aluminum\ 6061}$ |               $2700$ |          $24,3 \times 10^{-6}$ |                         $156$ | $73,1\ \mathrm{GPa}$ |
|         $\mathrm{copper}$ |               $8900$ |          $16,6 \times 10^{-6}$ |                         $393$ |  $117\ \mathrm{GPa}$ |
|           $\mathrm{lead}$ |              $11300$ |          $52,7 \times 10^{-6}$ |                        $37,0$ | $13,8\ \mathrm{GPa}$ |
|       $\mathrm{platinum}$ |              $21400$ |          $9,00 \times 10^{-6}$ |                        $69,2$ |  $147\ \mathrm{GPa}$ |
|    $\mathrm{steel\ 1020}$ |               $7850$ |          $11,3 \times 10^{-6}$ |                        $46,7$ |  $207\ \mathrm{GPa}$ |
|       $\mathrm{titanium}$ |               $4850$ |          $9,36 \times 10^{-6}$ |                        $7,44$ |  $102\ \mathrm{GPa}$ |

Table 2: Changing the decimal mark

<br>

To return to the default values,

``` r
formatdown_options(reset = TRUE)
```

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
- [`units`](https://CRAN.R-project.org/package=units) for handling
  physical units
- [`wrapr`](https://CRAN.R-project.org/package=wrapr),
  [`checkmate`](https://CRAN.R-project.org/package=checkmate), and
  [`tinytest`](https://CRAN.R-project.org/package=tinytest) for
  programming tools
- [`devtools`](https://CRAN.R-project.org/package=devtools) and
  [`pkgdown`](https://CRAN.R-project.org/package=pkgdown) for package
  building
