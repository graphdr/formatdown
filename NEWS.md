# formatdown (development version)

- dropped covr github action

# formatdown 0.2.0

## new features

- New `format_nucl()` formats chemical isotopes in nuclear notation. 
- `formatdown_options()` gains the `Z` and `warn` arguments used by `format_nucl()`. 

## minor improvements and fixes

- `format_numbers(0, format = "sci")` now correctly yields a zero without power-of-ten notation. Likewise for `format = "engr"` (#10). 
-  In `formatdown_options()`, `multiply_mark` can now be set to `"\\cdot"` (center dot), often used when `decimal_mark` is a comma. 


<!-- MAJOR version when you make incompatible API changes -->
<!-- MINOR version add functionality in a backwards-compatible manner -->
<!-- PATCH version backwards-compatible bug fixes -->
<!-- DEV 900x development -->

<!-- ## Breaking changes -->
<!-- ## New features -->
<!-- ## Minor improvements and fixes -->
