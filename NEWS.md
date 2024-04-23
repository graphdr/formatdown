# formatdown (development version)

2024-04-09

- deprecate `format_decimal()` and `format_power()` in favor of the more general `format_numbers()` 
- add `format_sci()`, `format_engr()`, and `format_dcml()` that wrap `fotmat_numbers()`
- add global options and functions `formatdown_options()` and `reset_formatdown_options()`, plus vignette. Update functions to take advantage of options. 
- edit `format_text()` to retain any spaces in a character input 
- update tests and vignettes to reflect changes


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
