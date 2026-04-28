# Format isotopes in nuclear notation

Convert chemical element or isotope from from hyphenated notation to
nuclear notation.

## Usage

``` r
format_nucl(
  x,
  face = "plain",
  ...,
  Z = formatdown_options("Z"),
  warn = formatdown_options("warn"),
  delim = formatdown_options("delim")
)
```

## Arguments

- x:

  Character. Hyphenated form of chemical elements or isotopes. Can be a
  single character string or a vector of strings. Must include a single
  hyphen between the element symbol and the mass number. For example,
  carbon 12 in hyphenated notation is the character string `"C-12"`.

- face:

  Font face. Determines the font face macro inside the math delimiters.
  Possible values are `"plain"` (default), `"italic"`, `"bold"`,
  `"sans"`, or `"mono"`. One may assign instead the corresponding
  LaTeX-style markup itself, e.g., `\mathrm`, `\mathit`, `\mathbf`,
  `\mathsf`, or `\mathtt`.

- ...:

  Not used for values; forces subsequent arguments to be referable only
  by name.

- Z:

  T/F add the atomic number. For details, see the help page for
  [`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md).

- warn:

  T/F issue warning for incorrect input `x`. For details, see the help
  page for
  [`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md).

- delim:

  The math-delimiter. For details, see the help page for
  [`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md).

## Value

A character vector of isotopes in nuclear notation with elements
delimited as inline math markup in plain, italic, sans serif, bold, or
monospace font face.

## Details

We start with a character string in hyphenated form *X-A* where *X* is
the chemical symbol of an element and *A* is its mass number. For
example, carbon 12 would be written as the string `"C-12"`.

Given a character scalar, vector, or data frame column of isotopes in
this form, `format_nucl()` constructs the form `"$\\mathxx{^{A}X}$"`
where `\\mathxx` determines the font face: plain type is set by
`\\mathrm`; italic by `\\mathit`; bold by `\\mathbf`; sans serif by
`\\mathsf`; and monospace (typewriter text) by `\\mathtt`. The result
includes markup delimiters `$...$` for rendering (in an R markdown or
Quarto markdown document) as an inline code chunk.

Unlike other functions in formatdown, `format_nucl()` does not support a
`size` argument.

## See also

Other format\_\*:
[`format_dcml()`](https://graphdr.github.io/formatdown/reference/format_dcml.md),
[`format_engr()`](https://graphdr.github.io/formatdown/reference/format_engr.md),
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md),
[`format_sci()`](https://graphdr.github.io/formatdown/reference/format_sci.md),
[`format_text()`](https://graphdr.github.io/formatdown/reference/format_text.md)
