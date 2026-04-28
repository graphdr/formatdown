# Format numbers

Convert a numeric vector to a character vector in which the numbers are
formatted in power-of-ten notation in scientific or engineering form and
delimited for rendering as inline equations in an R markdown document.
Decimal numbers can be similarly formatted, without the power-of-ten
notation.

## Usage

``` r
format_numbers(
  x,
  digits = 4,
  format = "engr",
  ...,
  omit_power = c(-1, 2),
  set_power = NULL,
  delim = formatdown_options("delim"),
  size = formatdown_options("size"),
  decimal_mark = formatdown_options("decimal_mark"),
  big_mark = formatdown_options("big_mark"),
  big_interval = formatdown_options("big_interval"),
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

- format:

  Character, length 1, defines the type of notation. Possible values are
  `"engr"` (default) for engineering power-of-ten notation, `"sci"` for
  scientific power-of-ten notation, and `"dcml"` for decimal notation.

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

- big_mark:

  Character, length 1, used as the mark between every `big_interval`
  number of digits to the left of the decimal marker to improve
  readability. Possible values are empty `""` (default) or `"thin"` to
  produce a LaTeX-style thin, horizontal space. One may also assign the
  thin-space markup itself `"\\\\,"`. Passed to `formatC(big.mark)`.

- big_interval:

  Integer, length 1, that defines the number of digits (default 3) in
  groups separated by `big_mark`. Passed to `formatC(big.interval)`.

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

A character vector in which numbers are formatted in power-of-ten or
decimal notation and delimited for rendering as inline equations in an R
markdown document.

## Details

Given a number, a numerical vector, or a numerical column from a data
frame, `format_numbers()` converts the numbers to character strings of
the form, `"$a \\times 10^{n}$"`, where `a` is the coefficient to a
specified number of significant digits and `n` is the exponent. When
used for decimal notation, `format_numbers()` converts numbers to
character strings of the form `"$a$"`.

Powers-of-ten notation is omitted over a range of exponents via
`omit_power` such that numbers so specified are converted to decimal
notation. For example, the default `omit_power = c(-1, 2)` formats
numbers such as 0.123, 1.23, 12.3, and 123 in decimal form. To cancel
these exceptions and convert all numbers to powers-of-ten notation, set
the `omit_power` argument to NULL or NA.

Delimiters for inline math markup can be edited if necessary. If the
default argument fails, try using `"\\("` as an alternative. If using a
custom delimiter to suit the markup environment, be sure to escape all
special symbols.

When inputs are of class "units" (created with the units package), a
math-text macro of the form `\\mathrm{<units_string>}` is appended to
the formatted numerical value inside the math delimiters.

Arguments after the dots (`...`) must be referred to by name.

## See also

Other format\_\*:
[`format_dcml()`](https://graphdr.github.io/formatdown/reference/format_dcml.md),
[`format_engr()`](https://graphdr.github.io/formatdown/reference/format_engr.md),
[`format_nucl()`](https://graphdr.github.io/formatdown/reference/format_nucl.md),
[`format_sci()`](https://graphdr.github.io/formatdown/reference/format_sci.md),
[`format_text()`](https://graphdr.github.io/formatdown/reference/format_text.md)

## Examples

``` r
# input: single number
x <- 6.0221E+23
format_numbers(x)
#> [1] "$602.2 \\times 10^{21}$"

# input: units class
x <- 103400
units(x) <- "N m2 C-2"
format_numbers(x)
#> [1] "$103.4 \\times 10^{3}\\ \\mathrm{N\\ m^{2}\\ C^{-2}}$"

# input: vector
data("metals", package = "formatdown")
x <- metals$dens
format_numbers(x)
#> [1] "$2.700 \\times 10^{3}$" "$8.900 \\times 10^{3}$" "$11.34 \\times 10^{3}$"
#> [4] "$21.45 \\times 10^{3}$" "$7.850 \\times 10^{3}$" "$4.850 \\times 10^{3}$"

# significant digits
x <- 9.75358e+5
format_numbers(x, 2)
#> [1] "$980 \\times 10^{3}$"
format_numbers(x, 3)
#> [1] "$975 \\times 10^{3}$"
format_numbers(x, 4)
#> [1] "$975.4 \\times 10^{3}$"

# input: data frame
x <- metals[, c("thrm_exp", "thrm_cond")]
as.data.frame(apply(x, 2, format_sci, digits = 3))
#>                 thrm_exp thrm_cond
#> 1 $2.43 \\times 10^{-5}$     $156$
#> 2 $1.66 \\times 10^{-5}$     $393$
#> 3 $5.27 \\times 10^{-5}$    $37.0$
#> 4 $9.00 \\times 10^{-6}$    $69.2$
#> 5 $1.13 \\times 10^{-5}$    $46.7$
#> 6 $9.36 \\times 10^{-6}$    $7.44$

# omit_power
x <- 103400
format_numbers(x, format = "sci", omit_power = c(-1, 2)) # default
#> [1] "$1.034 \\times 10^{5}$"
format_numbers(x, format = "sci", omit_power = c(-1, 5))
#> [1] "$103400$"
format_numbers(x, format = "sci", omit_power = 5) # equivalent to omit_power = c(5, 5)
#> [1] "$103400$"

# omit_power = NULL, power-of-ten notation for all elements
x <- c(1.2, 103400)
format_numbers(x, format = "sci")
#> [1] "$1.200$"                "$1.034 \\times 10^{5}$"
format_numbers(x, format = "sci", omit_power = NULL)
#> [1] "$1.200 \\times 10^{0}$" "$1.034 \\times 10^{5}$"

# set_power overrides default scientific exponent
x <- 103400
format_numbers(x, format = "sci")
#> [1] "$1.034 \\times 10^{5}$"
format_numbers(x, format = "sci", set_power = 4)
#> [1] "$10.34 \\times 10^{4}$"

# set_power overrides omit_power
x <- 103400
format_numbers(x, format = "sci")
#> [1] "$1.034 \\times 10^{5}$"
format_numbers(x, format = "sci", omit_power = 5)
#> [1] "$103400$"
format_numbers(x, format = "sci", omit_power = 5, set_power = 4)
#> [1] "$10.34 \\times 10^{4}$"

# decimal format overrides set_power
x <- 103400
format_numbers(x, format = "dcml")
#> [1] "$103400$"
format_numbers(x, format = "dcml", set_power = 3)
#> [1] "$103400$"
```
