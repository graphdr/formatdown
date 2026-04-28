# Air density measurements

Table of air properties at room temperature and pressure, simulating
multiple measurements at approximately steady state,

## Usage

``` r
data(air_meas, package = "formatdown")
```

## Format

Classes data.table and data.frame with 5 observations of 7 variables:

- date:

  "Date" class format "YYYY-MM-DD".

- trial:

  Character, label "a" through "e".

- humid:

  Factor, humidity, "low", "med", or "high."

- temp:

  Numeric, measured temperature (K).

- pres:

  Numeric, measured atmospheric pressure (Pa).

- sp_gas:

  Numeric, specific gas constant in mass form \\R\_{sp}\\, ideal gas
  reference value, (J kg\\^{-1}\\K\\^{-1}\\).

- dens:

  Numeric, calculated air density \\\rho\\ =
  \\p\\\\R\_{sp}^{-1}\\\\T^{-1}\\ (kg m\\^{-3}\\).
