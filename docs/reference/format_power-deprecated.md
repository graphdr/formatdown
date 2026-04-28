# Format powers of ten

This function is deprecated because it's a special case of the new
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md)
function. In addition, the new function includes features not available
in the deprecated function.

## Usage

``` r
format_power(x, digits, ..., format, size, omit_power, set_power, delim)
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

A character vector with numbers represented in powers of ten notation
and delimited as inline math markup.

## Details

Convert the elements of a numerical vector to character strings in which
the numbers are formatted using powers-of-ten notation in scientific or
engineering form and delimited for rendering as inline equations in an R
Markdown document.

Given a number, a numerical vector, or a numerical column from a data
frame,
[`format_power()`](https://graphdr.github.io/formatdown/reference/formatdown-deprecated.md)
converts the numbers to character strings of the form,
`"$a \\times 10^{n}$"`, where `a` is the coefficient and `n` is the
exponent. The string includes markup delimiters `$...$` for rendering as
an inline equation in R Markdown or Quarto Markdown document.

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

[`formatdown-deprecated`](https://graphdr.github.io/formatdown/reference/formatdown-deprecated.md)
