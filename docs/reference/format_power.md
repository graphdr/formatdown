# Format powers of ten

Convert the elements of a numerical vector to character strings in which
the numbers are formatted using powers-of-ten notation in scientific or
engineering form and delimited for rendering as inline equations in an R
Markdown document.

## Usage

``` r
format_power(
  x,
  digits = 4,
  ...,
  format = NULL,
  size = NULL,
  omit_power = c(-1, 2),
  set_power = NULL,
  delim = "$"
)
```

## Arguments

- x:

  Numeric vector to be formatted.

- digits:

  Numeric scalar between 1 and 20 (inclusive) defining the number of
  significant digits in result.

- ...:

  Not used, force later arguments to be used by name.

- format:

  Character. Possible values are "engr" (default) for engineering
  notation and and "sci" for scientific notation. Use argument by name.
  Can also be set as a global option, for example,
  `options(formatdown.power.format = "sci")` that can be overwritten in
  an individual function call.

- size:

  Font size. Possible values are "scriptsize", "small" (default),
  "normalsize", "large", and "huge". which correspond to selected LaTeX
  font size values. Can also be set as a global option, for example,
  `options(formatdown.font.size = "normalsize")` that can be overwritten
  in an individual function call.

- omit_power:

  Numeric vector `c(p, q)` specifying the range of exponents between
  which power of ten notation is omitted, where `p <= q`. If NULL all
  numbers are formatted in powers of ten notation. Use argument by name.

- set_power:

  Numeric scalar integer. Assigned exponent that overrides `format`.
  Default NULL makes no notation changes. Use argument by name.

- delim:

  Character vector (length 1 or 2) defining the delimiters for marking
  up inline math. Possible values include `"$"` or `"\\("`, both of
  which create appropriate left and right delimiters. Alternatively,
  left and right can be defined explicitly in a character vector of
  length two, e.g., `c("$", "$")` or `c("\\(", "\\)")`. Custom
  delimiters can be assigned to suit the markup environment. Use
  argument by name.

## Value

A character vector with the following properties:

- Numbers represented in powers of ten notation except for those with
  exponents in the range specified in `omit_power`

- Elements delimited as inline math markup.

## Details

Given a number, a numerical vector, or a numerical column from a data
frame, `format_power()` converts the numbers to character strings of the
form, `"$a \\times 10^{n}$"`, where `a` is the coefficient and `n` is
the exponent. The string includes markup delimiters `$...$` for
rendering as an inline equation in R Markdown or Quarto Markdown
document.

The user can specify either scientific or engineering format and the
number of significant digits.

Powers-of-ten notation is omitted over a range of exponents via
`omit_power` such that numbers are converted to character strings of the
form, `"$a$"`, where `a` is the number in decimal notation. The default
`omit_power = c(-1, 2)` formats numbers such as 0.123, 1.23, 12.3, and
123 in decimal form. To cancel these exceptions and convert all numbers
to powers-of-ten notation, set the `omit_power` argument to NULL.

Delimiters for inline math markup can be edited if necessary. If the
default argument fails, try using `"\\("` as an alternative. If using a
custom delimiter to suit the markup environment, be sure to escape all
special symbols.

## See also

Other format\_\*:
[`format_decimal`](https://graphdr.github.io/formatdown/reference/format_decimal.md)`()`,
[`format_text`](https://graphdr.github.io/formatdown/reference/format_text.md)`()`,
[`format_units`](https://graphdr.github.io/formatdown/reference/format_units.md)`()`

## Examples

``` r
# Scalar value
format_power(101100, digits = 4)
#> [1] "$\\small 101.1 \\times 10^{3}$"

# Vector value
x <- c(1.2222e-6, 2.3333e-5, 3.4444e-4, 4.1111e-3, 5.2222e-2, 6.3333e-1,
       7.4444e+0, 8.1111e+1, 9.2222e+2, 1.3333e+3, 2.4444e+4, 3.1111e+5, 4.2222e+6)
format_power(x)
#>  [1] "$\\small 1.222 \\times 10^{-6}$" "$\\small 23.33 \\times 10^{-6}$"
#>  [3] "$\\small 344.4 \\times 10^{-6}$" "$\\small 4.111 \\times 10^{-3}$"
#>  [5] "$\\small 52.22 \\times 10^{-3}$" "$\\small 0.6333$"               
#>  [7] "$\\small 7.444$"                 "$\\small 81.11$"                
#>  [9] "$\\small 922.2$"                 "$\\small 1.333 \\times 10^{3}$" 
#> [11] "$\\small 24.44 \\times 10^{3}$"  "$\\small 311.1 \\times 10^{3}$" 
#> [13] "$\\small 4.222 \\times 10^{6}$" 

# Compare significant digits
format_power(x[1], 3)
#> [1] "$\\small 1.22 \\times 10^{-6}$"
format_power(x[1], 4)
#> [1] "$\\small 1.222 \\times 10^{-6}$"

# Compare format type
format_power(x[3], format = "engr")
#> [1] "$\\small 344.4 \\times 10^{-6}$"
format_power(x[3], format = "sci")
#> [1] "$\\small 3.444 \\times 10^{-4}$"

# Compare set_power results
format_power(x[3], set_power = -5)
#> [1] "$\\small 34.44 \\times 10^{-5}$"
format_power(x[3], set_power = -4)
#> [1] "$\\small 3.444 \\times 10^{-4}$"
format_power(x[3], set_power = -3)
#> [1] "$\\small 0.3444 \\times 10^{-3}$"

# Compare omit_power range
format_power(x[6], omit_power = c(-1, 2))
#> [1] "$\\small 0.6333$"
format_power(x[6], omit_power = c(0, 2))
#> [1] "$\\small 633.3 \\times 10^{-3}$"
format_power(x[8])
#> [1] "$\\small 81.11$"
format_power(x[8], omit_power = NULL)
#> [1] "$\\small 81.11 \\times 10^{0}$"

# Apply to columns of a data frame (data.table syntax)
y <- x[1:6]
z <- x[8:13]
DT <- data.table::data.table(y, z)
DT[, lapply(.SD, function(x) format_power(x))]
#>                                  y                              z
#>                             <char>                         <char>
#> 1: $\\small 1.222 \\times 10^{-6}$                $\\small 81.11$
#> 2: $\\small 23.33 \\times 10^{-6}$                $\\small 922.2$
#> 3: $\\small 344.4 \\times 10^{-6}$ $\\small 1.333 \\times 10^{3}$
#> 4: $\\small 4.111 \\times 10^{-3}$ $\\small 24.44 \\times 10^{3}$
#> 5: $\\small 52.22 \\times 10^{-3}$ $\\small 311.1 \\times 10^{3}$
#> 6:                $\\small 0.6333$ $\\small 4.222 \\times 10^{6}$
```
