# Format text

Convert a character vector to "math text" delimited for rendering as
inline equations in an R markdown document. Particularly useful for
matching the font face of character columns to that of numerical columns
in a table.

## Usage

``` r
format_text(
  x,
  face = "plain",
  ...,
  size = formatdown_options("size"),
  delim = formatdown_options("delim"),
  whitespace = formatdown_options("whitespace")
)
```

## Arguments

- x:

  Text to be formatted. Can be a single string, a vector, or a column of
  a data frame.

- face:

  Font face. Determines the font face macro inside the math delimiters.
  Possible values are `"plain"` (default), `"italic"`, `"bold"`,
  `"sans"`, or `"mono"`. One may assign instead the corresponding
  LaTeX-style markup itself, e.g., `\mathrm`, `\mathit`, `\mathbf`,
  `\mathsf`, or `\mathtt`.

- ...:

  Not used for values; forces subsequent arguments to be referable only
  by name.

- size, delim, whitespace:

  Used to format the math-delimited character strings. For details, see
  the help page for
  [`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md).

## Value

A character vector with elements delimited as inline math markup in
plain, italic, sans serif, bold, or monospace font face.

## Details

Given a scalar, vector, or data frame column, `format_text()` converts
its argument to a character string of the form `"$\\mathxx{a}$"` where
`a` is the element to be formatted and `\\mathxx` determines the font
face: plain type is set by `\\mathrm`; italic by `\\mathit`; bold by
`\\mathbf`; sans serif by `\\mathsf`; and monospace (typewriter text) by
`\\mathtt`. All strings include markup delimiters `$...$` for rendering
(in an R markdown or Quarto markdown document) as an inline equation.

## See also

Other format\_\*:
[`format_dcml()`](https://graphdr.github.io/formatdown/reference/format_dcml.md),
[`format_engr()`](https://graphdr.github.io/formatdown/reference/format_engr.md),
[`format_nucl()`](https://graphdr.github.io/formatdown/reference/format_nucl.md),
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md),
[`format_sci()`](https://graphdr.github.io/formatdown/reference/format_sci.md)

## Examples

``` r
# Text vector

# default face = "plain"
x <- air_meas$humid
format_text(x)
#> [1] "$\\mathrm{low}$"  "$\\mathrm{high}$" "$\\mathrm{med}$"  "$\\mathrm{low}$" 
#> [5] "$\\mathrm{high}$"

# equivalently
format_text(x, face = "plain")
#> [1] "$\\mathrm{low}$"  "$\\mathrm{high}$" "$\\mathrm{med}$"  "$\\mathrm{low}$" 
#> [5] "$\\mathrm{high}$"

# input vector
x <- c("Hello world!", "Goodbye blues!")
format_text(x)
#> [1] "$\\mathrm{Hello\\ world!}$"   "$\\mathrm{Goodbye\\ blues!}$"

# argument coerced to character string if possible
format_text(c(1.2, 2.3, 3.4))
#> [1] "$\\mathrm{1.2}$" "$\\mathrm{2.3}$" "$\\mathrm{3.4}$"
format_text(x = NA)
#> [1] "$\\mathrm{NA}$"
format_text(x = c(TRUE, FALSE, TRUE))
#> [1] "$\\mathrm{TRUE}$"  "$\\mathrm{FALSE}$" "$\\mathrm{TRUE}$" 

# numbers as strings are rendered as-is
format_text(x = c("1.2E-3", "3.4E+0", "5.6E+3"))
#> [1] "$\\mathrm{1.2E-3}$" "$\\mathrm{3.4E+0}$" "$\\mathrm{5.6E+3}$"

# other font faces
format_text(x, face = "italic")
#> [1] "$\\mathit{Hello\\ world!}$"   "$\\mathit{Goodbye\\ blues!}$"
format_text(x, face = "bold")
#> [1] "$\\mathbf{Hello\\ world!}$"   "$\\mathbf{Goodbye\\ blues!}$"
format_text(x, face = "sans")
#> [1] "$\\mathsf{Hello\\ world!}$"   "$\\mathsf{Goodbye\\ blues!}$"
format_text(x, face = "mono")
#> [1] "$\\mathtt{Hello\\ world!}$"   "$\\mathtt{Goodbye\\ blues!}$"
```
