# Format engineering notation

Convert a numeric vector to a character vector in which the numbers are
formatted in power-of-ten notation in engineering form and delimited for
rendering as inline equations in an R markdown document.

## Usage

``` r
format_engr(
  x,
  digits = 4,
  ...,
  omit_power = c(-1, 2),
  set_power = NULL,
  delim = formatdown_options("delim"),
  size = formatdown_options("size"),
  decimal_mark = formatdown_options("decimal_mark"),
  small_mark = formatdown_options("small_mark"),
  small_interval = formatdown_options("small_interval"),
  whitespace = formatdown_options("whitespace"),
  multiply_mark = formatdown_options("multiply_mark")
)
```

## Arguments

- x:

  Number or numbers to be formatted. Can be a single number, a vector,
  or a column of a data frame.

- digits:

  Integer from 1 through 20 that controls the number of significant
  digits in printed numeric values. Passed to
  [`signif()`](https://rdrr.io/r/base/Round.html). Default is 4.

- ...:

  Not used for values; forces subsequent arguments to be referable only
  by name.

- omit_power:

  Numeric vector `c(p, q)` with `p <= q`, specifying the range of
  exponents over which power-of-ten notation is omitted in either
  scientific or engineering format. Default is `c(-1, 2)`. If a single
  value is assigned, i.e., `omit_power = p`, the argument is interpreted
  as `c(p, p)`. If `NULL` or `NA`, all elements are formatted in
  power-of-ten notation. Argument is overridden by specifying
  `set_power` or decimal notation.

- set_power:

  Integer, length 1. Formats all values in `x` with the same
  power-of-ten exponent. Default NULL. Overrides `format` and
  `omit_power` arguments.

- delim:

  Character, length 1 or 2, to define the left and right math markup
  delimiters. The default setting, `delim = "$"`, produces left and
  right delimiters `$...$`. The alternate built-in setting,
  `delim = "\\("`, produces left and right delimiters `\\( ... \\)`.
  Custom delimiters can be assigned in a vector of length 2 with left
  and right delimiter symbols, e.g., `c("\\[", "\\]")`. Special
  characters typically must be escaped.

- size:

  Character, length 1, to assign a font size. If not empty, adds a font
  size macro to the markup inside the math delimiters. Possible values
  are `"scriptsize"`, `"small"`, `"normalsize"`, `"large"`, and
  `"huge"`. One may also assign the equivalent LaTeX-style markup
  itself, e.g., `"\\scriptsize"`, `"\\small"`, etc. Default is NULL.

- decimal_mark:

  Character, length 1, to assign the decimal marker. Possible values are
  a period `"."` (default) or a comma `","`. Passed to
  `formatC(decimal.mark)`.

- small_mark:

  Character, length 1, used as the mark between every `small_interval`
  number of digits to the right of the decimal marker to improve
  readability. Possible values are empty `""` (default) or `"thin"` to
  produce a LaTeX-style thin, horizontal space. One may also assign the
  thin-space markup itself `"\\\\,"`. Passed to `formatC(small.mark)`.

- small_interval:

  Integer, length 1, that defines the number of digits (default 5) in
  groups separated by `small_mark`. Passed to `formatC(small.interval)`.

- whitespace:

  Character, length 1, to define the LaTeX-style math-mode macro to
  preserve a horizontal space between words of text or between
  physical-unit abbreviations when formatting numbers of class "units".
  Default is `"\\\\ "`. Alternatives include `"\\\\:"` or "`\\\\>`".

- multiply_mark:

  Character, length 1, to define the multiplication symbol in power of
  ten notation. Possible values are `"\\times"` (default) or a half-high
  dot `"\\cdot"` which is often used when the decimal mark is a comma.

## Value

A character vector in which numbers are formatted in power-of-ten
notation in engineering form and delimited for rendering as inline
equations in an R markdown document.

## Details

In engineering notation, all exponents are multiples of three.
`format_engr()` is a wrapper for the more general function
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md).
Where defaults are defined by
[`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md),
users may reassign the arguments locally in the function call or
globally using
[`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md).

Arguments after the dots (`...`) must be referred to by name.

## See also

Other format\_\*:
[`format_dcml()`](https://graphdr.github.io/formatdown/reference/format_dcml.md),
[`format_nucl()`](https://graphdr.github.io/formatdown/reference/format_nucl.md),
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md),
[`format_sci()`](https://graphdr.github.io/formatdown/reference/format_sci.md),
[`format_text()`](https://graphdr.github.io/formatdown/reference/format_text.md)

## Examples

``` r
# input: single number
x <- 6.0221E+23
format_engr(x)
#> [1] "$602.2 \\times 10^{21}$"

# input: units class
x <- 103400
units(x) <- "N m2 C-2"
format_engr(x)
#> [1] "$103.4 \\times 10^{3}\\ \\mathrm{N\\ m^{2}\\ C^{-2}}$"

# input: vector
data("metals", package = "formatdown")
x <- metals$dens
format_engr(x)
#> [1] "$2.700 \\times 10^{3}$" "$8.900 \\times 10^{3}$" "$11.34 \\times 10^{3}$"
#> [4] "$21.45 \\times 10^{3}$" "$7.850 \\times 10^{3}$" "$4.850 \\times 10^{3}$"

# significant digits
x <- 9.75358e+5
format_engr(x, 2)
#> [1] "$980 \\times 10^{3}$"
format_engr(x, 3)
#> [1] "$975 \\times 10^{3}$"
format_engr(x, 4)
#> [1] "$975.4 \\times 10^{3}$"

# input: data frame
x <- metals[, c("thrm_exp", "thrm_cond")]
as.data.frame(apply(x, 2, format_engr, digits = 3))
#>                 thrm_exp thrm_cond
#> 1 $24.3 \\times 10^{-6}$     $156$
#> 2 $16.6 \\times 10^{-6}$     $393$
#> 3 $52.7 \\times 10^{-6}$    $37.0$
#> 4 $9.00 \\times 10^{-6}$    $69.2$
#> 5 $11.3 \\times 10^{-6}$    $46.7$
#> 6 $9.36 \\times 10^{-6}$    $7.44$

# format_engr() same as format_numbers(..., format = "engr")
x <- 6.0221E+23
format_engr(x)
#> [1] "$602.2 \\times 10^{21}$"
format_numbers(x, format = "engr")
#> [1] "$602.2 \\times 10^{21}$"

# omit_power
x <- 103400
format_engr(x, omit_power = c(-1, 2)) # default
#> [1] "$103.4 \\times 10^{3}$"
format_engr(x, omit_power = c(-1, 5))
#> [1] "$103400$"
format_engr(x, omit_power = 5) # equivalent to omit_power = c(5, 5)
#> [1] "$103400$"

# omit_power = NULL, power-of-ten notation for all elements
x <- c(1.2, 103400)
format_engr(x)
#> [1] "$1.200$"                "$103.4 \\times 10^{3}$"
format_engr(x, omit_power = NULL)
#> [1] "$1.200 \\times 10^{0}$" "$103.4 \\times 10^{3}$"

# omit_power applies to native exponent (before engr formatting)
x <- 103400
format_sci(x) # native exponent is 5
#> [1] "$1.034 \\times 10^{5}$"
format_engr(x, omit_power = 5)
#> [1] "$103400$"

# omit_power applies to exponent after engr formatting
x <- 103400
format_engr(x) # engr exponent is 3
#> [1] "$103.4 \\times 10^{3}$"
format_engr(x, omit_power = 3)
#> [1] "$103400$"

# set_power overrides default engineering exponent
x <- 103400
format_engr(x)
#> [1] "$103.4 \\times 10^{3}$"
format_engr(x, set_power = 4)
#> [1] "$10.34 \\times 10^{4}$"

# set_power overrides omit_power
x <- 103400
format_engr(x)
#> [1] "$103.4 \\times 10^{3}$"
format_engr(x, omit_power = 3)
#> [1] "$103400$"
format_engr(x, omit_power = 3, set_power = 3)
#> [1] "$103.4 \\times 10^{3}$"
```
