# Deprecated functions in package formatdown.

The functions listed below are deprecated. Alternative functions with
similar functionality are mentioned. Help pages for deprecated functions
are available at `help("<function>-deprecated")`.

## Usage

``` r
format_decimal(x, digits = 4, ..., big_mark = NULL, delim = "$")

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

format_units(
  x,
  digits = 1,
  unit = NULL,
  ...,
  unit_form = NULL,
  big_mark = NULL
)
```

## `format_decimal`

For `format_decimal()`, use
[`format_dcml()`](https://graphdr.github.io/formatdown/reference/format_dcml.md)
or `format_numbers(..., format = "dcml")`

## `format_power`

For `format_power()`, use
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md),
[`format_sci()`](https://graphdr.github.io/formatdown/reference/format_sci.md)
or
[`format_engr()`](https://graphdr.github.io/formatdown/reference/format_engr.md).

## `format_units`

For `format_units()`, use
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md)
after first assigning physical measurement units using the units
package.
