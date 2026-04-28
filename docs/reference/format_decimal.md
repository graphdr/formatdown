# Format decimal or integer values

Convert the elements of a numerical vector to character strings in which
the numbers are formatted using decimal notation and delimited for
rendering as inline equations in an R Markdown document.

## Usage

``` r
format_decimal(x, digits = 4, ..., big_mark = NULL, delim = "$")
```

## Arguments

- x:

  Numeric vector to be formatted.

- digits:

  Numeric scalar, decimal places to report, integer between 0 and 20.
  Zero returns an integer.

- ...:

  Not used, force later arguments to be used by name.

- big_mark:

  Character. If not empty, used as mark between every three digits
  before the decimal point. Applied as the `big.mark` argument of
  [`formatC()`](https://rdrr.io/r/base/formatc.html).

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

- Numbers represented in integer or decimal notation.

- Elements delimited as inline math markup.

## Details

Given a number, a numerical vector, or a numerical column from a data
frame, `format_decimal()` converts the numbers to character strings of
the form, `"$a$"`, where `a` is the number in decimal notation. The user
can specify the number of decimal places.

Delimiters for inline math markup can be edited if necessary. If the
default argument fails, the `"\\("` alternative is available. If using a
custom delimiter to suit the markup environment, be sure to escape all
special symbols.

## See also

Other format\_\*:
[`format_power`](https://graphdr.github.io/formatdown/reference/format_power.md)`()`,
[`format_text`](https://graphdr.github.io/formatdown/reference/format_text.md)`()`,
[`format_units`](https://graphdr.github.io/formatdown/reference/format_units.md)`()`

## Examples

``` r
# Digits
x <- c(12300400.1234, 456000)
format_decimal(x, digits = 0)
#> [1] "$12300400$" "$456000$"  
format_decimal(x, digits = 1)
#> [1] "$12300400.1$" "$456000.0$"  
format_decimal(x, digits = 2)
#> [1] "$12300400.12$" "$456000.00$"  

# Big mark
format_decimal(x, 0, big_mark = ",")
#> [1] "$12,300,400$" "$456,000$"   

# Inline math delimiters
x <- c(1.654321, 0.065432)
format_decimal(x)
#> [1] "$1.6543$" "$0.0654$"
format_decimal(x, 3, delim = "$")
#> [1] "$1.654$" "$0.065$"
format_decimal(x, 3, delim = c("$", "$"))
#> [1] "$1.654$" "$0.065$"
format_decimal(x, 3, delim = "\\(")
#> [1] "\\(1.654\\)" "\\(0.065\\)"
format_decimal(x, 3, delim = c("\\(", "\\)"))
#> [1] "\\(1.654\\)" "\\(0.065\\)"

# LaTeX-style display equation delimiters
format_decimal(x, 3, delim = c("\\[", "\\]"))
#> [1] "\\[1.654\\]" "\\[0.065\\]"

# Apply to columns of a data frame (data.table syntax)
DT <- atmos[, .(temp, sound)]
DT[, lapply(.SD, function(x) format_decimal(x, 1))]
#>       temp   sound
#>     <char>  <char>
#> 1: $288.1$ $340.3$
#> 2: $223.2$ $299.5$
#> 3: $216.7$ $295.1$
#> 4: $226.5$ $301.7$
#> 5: $250.3$ $317.2$
#> 6: $270.6$ $329.8$
#> 7: $247.0$ $315.1$
#> 8: $219.6$ $297.1$
#> 9: $198.6$ $282.5$
```
