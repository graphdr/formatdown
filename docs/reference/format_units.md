# Format values with measurement units

Format a vector of numbers as character strings with measurement units
appended via the 'units' package.

## Usage

``` r
format_units(
  x,
  digits = 1,
  ...,
  unit = NULL,
  unit_form = NULL,
  big_mark = NULL
)
```

## Arguments

- x:

  Vector of class numeric or class units.

- digits:

  Numeric scalar, a positive integer. Applied as the `digits` argument
  of [`base::format()`](https://rdrr.io/r/base/format.html). Enough
  decimal places are included such that the smallest magnitude value has
  this many significant digits.

- ...:

  Not used, force later arguments to be used by name.

- unit:

  Character scalar, units label compatible with 'units' package. For `x`
  class numeric, transform to class units in `unit` measurement units.
  For `x` class units, convert to `unit` measurement units. If empty,
  existing class units retained.

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

Other format\_\*:
[`format_decimal`](https://graphdr.github.io/formatdown/reference/format_decimal.md)`()`,
[`format_power`](https://graphdr.github.io/formatdown/reference/format_power.md)`()`,
[`format_text`](https://graphdr.github.io/formatdown/reference/format_text.md)`()`

## Examples

``` r
# Scalar value, class numeric
x <- 101300
format_units(x, unit = "Pa")
#> [1] "101300 [Pa]"

# Scalar value, class units
x <- 101300
units(x) <- "Pa"
format_units(x, unit = "hPa")
#> [1] "1013 [hPa]"
format_units(x, digits = 3, unit = "psi")
#> [1] "14.7 [psi]"

# Vectors (atmos and metals data included in formatdown)
x <- atmos$dens
units(x) <- "kg/m^3"
format_units(x, unit = "g/m^3")
#> [1] "1230.00 [g/m^3]" "414.00 [g/m^3]"  "88.90 [g/m^3]"   "18.40 [g/m^3]"  
#> [5] "4.00 [g/m^3]"    "1.03 [g/m^3]"    "0.31 [g/m^3]"    "0.08 [g/m^3]"   
#> [9] "0.02 [g/m^3]"   
format_units(x, unit = "g/m^3", unit_form = "implicit")
#> [1] "1230.00 [g m-3]" "414.00 [g m-3]"  "88.90 [g m-3]"   "18.40 [g m-3]"  
#> [5] "4.00 [g m-3]"    "1.03 [g m-3]"    "0.31 [g m-3]"    "0.08 [g m-3]"   
#> [9] "0.02 [g m-3]"   

x <- atmos$pres
units(x) <- "Pa"
format_units(x, big_mark = ",")
#> [1] "101,300 [Pa]" "26,500 [Pa]"  "5,529 [Pa]"   "1,197 [Pa]"   "287 [Pa]"    
#> [6] "80 [Pa]"      "22 [Pa]"      "5 [Pa]"       "1 [Pa]"      
format_units(x, unit = "hPa")
#> [1] "1013.00 [hPa]" "265.00 [hPa]"  "55.29 [hPa]"   "11.97 [hPa]"  
#> [5] "2.87 [hPa]"    "0.80 [hPa]"    "0.22 [hPa]"    "0.05 [hPa]"   
#> [9] "0.01 [hPa]"   

x <- metals$thrm_cond
units(x) <- "W m-1 K-1"
format_units(x, digits = 2)
#> [1] "155.8 [W/K/m]" "392.9 [W/K/m]" "37.0 [W/K/m]"  "69.2 [W/K/m]" 
#> [5] "46.7 [W/K/m]"  "7.4 [W/K/m]"  
format_units(x, digits = 2, unit_form = "implicit")
#> [1] "155.8 [W K-1 m-1]" "392.9 [W K-1 m-1]" "37.0 [W K-1 m-1]" 
#> [4] "69.2 [W K-1 m-1]"  "46.7 [W K-1 m-1]"  "7.4 [W K-1 m-1]"  
```
