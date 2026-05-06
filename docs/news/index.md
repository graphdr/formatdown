# Changelog

## formatdown (development version)

- dropped covr github action

## formatdown 0.2.0

### new features

- New
  [`format_nucl()`](https://graphdr.github.io/formatdown/reference/format_nucl.md)
  formats chemical isotopes in nuclear notation.
- [`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md)
  gains the `Z` and `warn` arguments used by
  [`format_nucl()`](https://graphdr.github.io/formatdown/reference/format_nucl.md).

### minor improvements and fixes

- `format_numbers(0, format = "sci")` now correctly yields a zero
  without power-of-ten notation. Likewise for `format = "engr"`
  ([\#10](https://github.com/graphdr/formatdown/issues/10)).
- In
  [`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md),
  `multiply_mark` can now be set to `"\\cdot"` (center dot), often used
  when `decimal_mark` is a comma.
