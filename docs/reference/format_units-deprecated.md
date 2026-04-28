# Format values with measurement units

This function is deprecated because it's a special case of the
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md)
function. Users should finalize the manipulation of units (using the
units package) before invoking a formatdown function.

## Usage

``` r
format_units(x, digits, unit, ..., unit_form, big_mark)
```

## Arguments

- x:

  Vector of class numeric or class units.

- digits:

  Numeric scalar, a positive integer. Applied as the `digits` argument
  of [`base::format()`](https://rdrr.io/r/base/format.html). Enough
  decimal places are included such that the smallest magnitude value has
  this many significant digits.

- unit:

  Character scalar, units label compatible with 'units' package. For `x`
  class numeric, transform to class units in `unit` measurement units.
  For `x` class units, convert to `unit` measurement units. If empty,
  existing class units retained.

- ...:

  Not used, force later arguments to be used by name.

- unit_form:

  Character scalar. Possible values are "standard" (default) and
  "implicit" (implicit exponent form). In standard form, units are
  related with arithmetic symbols for multiplication, division, and
  powers, e.g., `"kg/m^3"` or `"W/(m*K)"`. In implicit exponent form,
  symbols are separated by spaces and numbers represent exponents, e.g.,
  `"kg m-3"` or `"W m-1 K-1"`.

- big_mark:

  Character. Applied as the `big.mark` argument of
  [`base::format()`](https://rdrr.io/r/base/format.html). Default is
  `""`. If a period is selected for `big_mark`, the decimal mark is
  changed to a comma.

## Value

A character vector of numbers with appended measurement units.

## Details

Format a vector of numbers as character strings with measurement units
appended via the 'units' package.

This function is a wrapper for
[`units::as_units()`](https://r-quantities.github.io/units/reference/units.html)
and [`base::format()`](https://rdrr.io/r/base/format.html). Numeric
class input is converted to units class. Units class input, if
convertible, is converted to the specified measurement units; if none
are specified, the existing measurement units are retained. The result
in all cases is converted to class character using
[`base::format()`](https://rdrr.io/r/base/format.html) with preset
arguments: `trim = TRUE` and `scientific = FALSE`. The output has the
form `"a [u]"`, where `a` is the number in decimal notation and `u` is a
measurement units label.

## See also

[`formatdown-deprecated`](https://graphdr.github.io/formatdown/reference/formatdown-deprecated.md)
