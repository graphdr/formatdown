# formatdown (development version)

2024-03-25

- deprecate `format_decimal()` because it turned out to be a special case of `format_power()`.
- rename `format_power()` to `format_num()` and add the new `"dcml"` format
- rename `format_text()` to `format_txt()`
- edit `format_txt()` to retain any spaces between characters in a character argument
- add `options()` to globally set several arguments
- update tests and vignettes to reflect changes


# formatdown 0.1.3

2024--03--14

- add `format_text()` function 
- add `size` argument to `format_power()`
- add `signif()` to `format_power()` to enforce significant digits in output before applying `formatC()` 
- add `options()` to globally set font size and power of ten format arguments
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
