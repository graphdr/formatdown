
<!-- Edit README.Rmd (not README.md) -->

<br>

# formatdown <img src="man/figures/logo.png" align="right" style="float:right; height:30px;">

Formatting tools for R markdown documents.

Provides a small set of tools for common formatting tasks when writing
documents in R Markdown or Quarto Markdown. Works with outputs in html,
pdf, docx and possibly others. Currently only one function, though I
plan to include additional functions as needed to support repetitive
formatting tasks as they arise in my projects, e.g. my blog (.qmd files)
or R package vignettes (.Rmd files).

*Format powers of ten.*   Convert a numerical vector in E-notation
(*mEn*) to a character vector in base-10 power notation
$(m \times 10^n)$, where $m$ is the *significand* (or *coefficient*) in
decimal form and $n$ is the *exponent* ([Kahan, 2002](#ref-Kahan:2002)).

- In *E-notation* form and *scientific* form, the exponent is an integer
  and the significand usually lies in the range $1 \leq m < 10$.
- In *engineering* form, the exponent is an *integer multiple of three*
  and the resulting significand lies in the range $1 \leq m < 1000$.

For example, suppose we have a pressure reading $p =$$101.1\times10^{3}$
kPa. In the three types of notation mentioned, the value would be
rendered as follows:

| Type        |            Rendered as |
|:------------|-----------------------:|
| E-notation  |          1.0110E+05 Pa |
| scientific  | $1.011\times10^{5}$ Pa |
| engineering | $101.1\times10^{3}$ Pa |

## Usage

``` r
library("formatdown")
```

### `format_power()`

Operates on a numerical vector to produce a character vector with each
element delimited by `$...$` to render as in-line mathematics in R
markdown and Quarto markdown documents.

``` r
format_power(101100, sig_dig = 4)
## [1] "$101.1\\times10^{3}$"
```

In an Rmd output, this string prints as: $101.1\times10^{3}$. We can
switch to scientific notation by resetting the engineering notation
flag.

``` r
format_power(101100, sig_dig = 4, engr_notation = FALSE)
## [1] "$1.011\\times10^{5}$"
```

In an Rmd output, this string prints as: $1.011\times10^{5}$. Because
the output in all cases is type character, the `\` symbol in the LaTeX
product symbol `\times` is escaped, that is, the function yields
`\\times`.

## Installation

Not yet available from CRAN. The development version can be installed
from GitHub.

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
  include runtime argument checks and the *tinytest* package to write
  unit tests for your code. Save tests in the `inst/tinytest/`
  directory.

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
Conduct](CONDUCT.html).

## References

<div id="refs" class="references csl-bib-body hanging-indent"
line-spacing="2">

<div id="ref-Kahan:2002" class="csl-entry">

Kahan, W. (2002). *Names for standardized floating-point formats*.
<https://people.eecs.berkeley.edu/~wkahan/ieee754status/Names.pdf>

</div>

</div>
