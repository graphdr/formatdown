# Air density measurements

A table of air properties at room temperature, simulating multiple
measurements at approximately steady state,

## Usage

``` r
data(air, package = "formatdown")
```

## Format

Classes data.table and data.frame: 5 observations of 7 variables:

- date:

  Date, R class "Date", format `YYYY-MM-DD`.

- trial:

  Character, label a through e.

- humidity:

  Factor, low, medium, or high.

- temperature:

  Numeric, \[K\]

- pressure:

  Numeric, atmospheric pressure \[Pa\]

- R:

  Integer, gas constant \[J kg\\^{-1}\\K\\^{-1}\\\]

- density:

  Numeric, calculated air density \[kg m\\^{-3}\\\]
