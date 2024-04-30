# formatdown (development version)

2024-04-09

- `format_numbers()` replaces the now deprecated `format_decimal()`, `format_power()`, and `format_units()`. 
- add `format_sci()`, `format_engr()`, and `format_dcml()` that wrap `format_numbers()`
- add `formatdown_options()` for global options and update functions to use them.
- edit `format_text()` to retain spaces in a character input 
- update examples, tests, and vignettes to reflect changes


# formatdown 0.1.3

2024--03--14

- add `format_text()` function 
- add `size` argument to `format_power()`
- add `signif()` to `format_power()` to enforce significant digits in output before applying `formatC()` 
- correct issue with `omit_power()` argument
- correct issue with numbers < machine eps
- add package alias
- update tests and vignettes to reflect changes

# formatdown 0.1.2

2023--06--21

- Add arguments `delim` and `set_power` to `format_power()`.
- Fixed a bug to remove extra spaces added by `formatC()`. 
- Add data sets `atmos`, `metals`, and `water`. 
- Rename `density` data set to `air_meas`.
- Add `format_decimal()` and vignette.
- Add `format_units()` and vignette. 


# formatdown 0.1.1

2022-11-21

- Initial CRAN release

<!-- MAJOR.MINOR.PATCH.DEV -->

<!-- MAJOR version when you make incompatible API changes -->
<!-- MINOR version add functionality in a backwards-compatible manner -->
<!-- PATCH version backwards-compatible bug fixes -->
<!-- DEV 900x development -->
