# Format decimal or integer values

This function is deprecated because it's a special case of the new
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md)
function. In addition, the new function includes features not available
in the deprecated function.

## Usage

``` r
format_decimal(x, digits, ..., big_mark, delim)
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

A character vector with numbers represented in decimal notation and
delimited as inline math markup.

## Details

Convert the elements of a numerical vector to character strings in which
the numbers are formatted using decimal notation and delimited for
rendering as inline equations in an R Markdown document.

Given a number, a numerical vector, or a numerical column from a data
frame,
[`format_decimal()`](https://graphdr.github.io/formatdown/reference/formatdown-deprecated.md)
converts the numbers to character strings of the form, `"$a$"`, where
`a` is the number in decimal notation. The user can specify the number
of decimal places.

Delimiters for inline math markup can be edited if necessary. If the
default argument fails, the `"\\("` alternative is available. If using a
custom delimiter to suit the markup environment, be sure to escape all
special symbols.

## See also

[`formatdown-deprecated`](https://graphdr.github.io/formatdown/reference/formatdown-deprecated.md)
