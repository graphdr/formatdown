# Format numbers in decimal notation

Convert a numeric vector to a character vector in which the numbers are
formatted in decimal form and delimited for rendering as inline
equations in an R markdown document.

## Usage

``` r
format_dcml(
  x,
  digits = 4,
  ...,
  delim = formatdown_options("delim"),
  size = formatdown_options("size"),
  decimal_mark = formatdown_options("decimal_mark"),
  big_mark = formatdown_options("big_mark"),
  big_interval = formatdown_options("big_interval"),
  small_mark = formatdown_options("small_mark"),
  small_interval = formatdown_options("small_interval"),
  whitespace = formatdown_options("whitespace")
)
```

## Arguments

- x:

  Number or numbers to be formatted. Can be a single number, a vector,
  or a column of a data frame.

- digits:

  Integer from 1 through 20 that controls the number of significant
  digits in printed numeric values. Passed to
  [`signif()`](https://rdrr.io/r/base/Round.html). Default is 4.

- ...:

  Not used for values; forces subsequent arguments to be referable only
  by name.

- delim:

  Character, length 1 or 2, to define the left and right math markup
  delimiters. The default setting, `delim = "$"`, produces left and
  right delimiters `$...$`. The alternate built-in setting,
  `delim = "\\("`, produces left and right delimiters `\\( ... \\)`.
  Custom delimiters can be assigned in a vector of length 2 with left
  and right delimiter symbols, e.g., `c("\\[", "\\]")`. Special
  characters typically must be escaped.

- size:

  Character, length 1, to assign a font size. If not empty, adds a font
  size macro to the markup inside the math delimiters. Possible values
  are `"scriptsize"`, `"small"`, `"normalsize"`, `"large"`, and
  `"huge"`. One may also assign the equivalent LaTeX-style markup
  itself, e.g., `"\\scriptsize"`, `"\\small"`, etc. Default is NULL.

- decimal_mark:

  Character, length 1, to assign the decimal marker. Possible values are
  a period `"."` (default) or a comma `","`. Passed to
  `formatC(decimal.mark)`.

- big_mark:

  Character, length 1, used as the mark between every `big_interval`
  number of digits to the left of the decimal marker to improve
  readability. Possible values are empty `""` (default) or `"thin"` to
  produce a LaTeX-style thin, horizontal space. One may also assign the
  thin-space markup itself `"\\\\,"`. Passed to `formatC(big.mark)`.

- big_interval:

  Integer, length 1, that defines the number of digits (default 3) in
  groups separated by `big_mark`. Passed to `formatC(big.interval)`.

- small_mark:

  Character, length 1, used as the mark between every `small_interval`
  number of digits to the right of the decimal marker to improve
  readability. Possible values are empty `""` (default) or `"thin"` to
  produce a LaTeX-style thin, horizontal space. One may also assign the
  thin-space markup itself `"\\\\,"`. Passed to `formatC(small.mark)`.

- small_interval:

  Integer, length 1, that defines the number of digits (default 5) in
  groups separated by `small_mark`. Passed to `formatC(small.interval)`.

- whitespace:

  Character, length 1, to define the LaTeX-style math-mode macro to
  preserve a horizontal space between words of text or between
  physical-unit abbreviations when formatting numbers of class "units".
  Default is `"\\\\ "`. Alternatives include `"\\\\:"` or "`\\\\>`".

## Value

A character vector in which numbers are formatted in decimal form and
delimited for rendering as inline equations in an R markdown document.

## Details

`format_dcml()` is a wrapper for the more general function
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md).
Where defaults are defined by
[`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md),
users may reassign the arguments locally in the function call or
globally using
[`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md).

Arguments after the dots (`...`) must be referred to by name.

## See also

Other format\_\*:
[`format_engr()`](https://graphdr.github.io/formatdown/reference/format_engr.md),
[`format_nucl()`](https://graphdr.github.io/formatdown/reference/format_nucl.md),
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md),
[`format_sci()`](https://graphdr.github.io/formatdown/reference/format_sci.md),
[`format_text()`](https://graphdr.github.io/formatdown/reference/format_text.md)

## Examples

``` r
# input: single number
x <- 103400
format_dcml(x)
#> [1] "$103400$"

# input: units class
x <- 103400
units(x) <- "N m2 C-2"
format_dcml(x)
#> [1] "$103400\\ \\mathrm{N\\ m^{2}\\ C^{-2}}$"

# input: vector
data("metals", package = "formatdown")
x <- metals$thrm_cond
format_dcml(x)
#> [1] "$155.8$" "$392.9$" "$37.04$" "$69.23$" "$46.73$" "$7.440$"

# significant digits
x <- 155.77
format_dcml(x, 2)
#> [1] "$160$"
format_dcml(x, 3)
#> [1] "$156$"
format_dcml(x, 4)
#> [1] "$155.8$"

# input: data frame
x <- metals[, c("dens", "thrm_cond")]
as.data.frame(apply(x, 2, format_dcml, digits = 3))
#>      dens thrm_cond
#> 1  $2700$     $156$
#> 2  $8900$     $393$
#> 3 $11300$    $37.0$
#> 4 $21400$    $69.2$
#> 5  $7850$    $46.7$
#> 6  $4850$    $7.44$

# format_dcml() same as format_numbers(..., format = "dcml")
x <- 103400
format_dcml(x)
#> [1] "$103400$"
format_numbers(x, format = "dcml")
#> [1] "$103400$"
```
