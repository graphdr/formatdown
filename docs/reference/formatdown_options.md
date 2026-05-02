# Get and set function arguments via options

Changes the default values of function arguments which affect the markup
and appearance of formatdown results.

## Usage

``` r
formatdown_options(..., reset = FALSE)
```

## Arguments

- ...:

  One or more `name = value` pairs to set values; or one or more quoted
  option names to get values.

- reset:

  Logical vector of length 1; if TRUE, reset all options to their
  default values.

## Value

Nothing; used for its side-effect.

## Details

Global options are provided for arguments that users would likely prefer
to set once in a document instead of repeating in every function call.
For example, some users prefer a comma decimal marker (",") throughout a
document.

Globally-set arguments can be overridden locally by assigning them in a
function call.

The arguments that can be set with this function are as follows:

- `delim`: Character, length 1 or 2, to define the left and right math
  markup delimiters. The default setting, `delim = "$"`, produces left
  and right delimiters `$...$`. The alternate built-in setting,
  `delim = "\\("`, produces left and right delimiters `\\( ... \\)`.
  Custom delimiters can be assigned in a vector of length 2 with left
  and right delimiter symbols, e.g., `c("\\[", "\\]")`. Special
  characters typically must be escaped.

- `size`: Character, length 1, to assign a font size. If not empty, adds
  a font size macro to the markup inside the math delimiters. Possible
  values are `"scriptsize"`, `"small"`, `"normalsize"`, `"large"`, and
  `"huge"`. One may also assign the equivalent LaTeX-style markup
  itself, e.g., `"\\scriptsize"`, `"\\small"`, etc. Default is NULL.

- `decimal_mark`: Character, length 1, to assign the decimal marker.
  Possible values are a period `"."` (default) or a comma `","`. Passed
  to `formatC(decimal.mark)`.

- `big_mark`: Character, length 1, used as the mark between every
  `big_interval` number of digits to the left of the decimal marker to
  improve readability. Possible values are empty `""` (default) or
  `"thin"` to produce a LaTeX-style thin, horizontal space. One may also
  assign the thin-space markup itself `"\\\\,"`. Passed to
  `formatC(big.mark)`.

- `big_interval`: Integer, length 1, that defines the number of digits
  (default 3) in groups separated by `big_mark`. Passed to
  `formatC(big.interval)`.

- `small_mark`: Character, length 1, used as the mark between every
  `small_interval` number of digits to the right of the decimal marker
  to improve readability. Possible values are empty `""` (default) or
  `"thin"` to produce a LaTeX-style thin, horizontal space. One may also
  assign the thin-space markup itself `"\\\\,"`. Passed to
  `formatC(small.mark)`.

- `small_interval`: Integer, length 1, that defines the number of digits
  (default 5) in groups separated by `small_mark`. Passed to
  `formatC(small.interval)`.

- `whitespace`: Character, length 1, to define the LaTeX-style math-mode
  macro to preserve a horizontal space between words of text or between
  physical-unit abbreviations when formatting numbers of class "units".
  Default is `"\\\\ "`. Alternatives include `"\\\\:"` or "`\\\\>`".

- `multiply_mark`: Character, length 1, to define the multiplication
  symbol in power of ten notation. Possible values are `"\\times"`
  (default) or a half-high dot `"\\cdot"` which is often used when the
  decimal mark is a comma.

- `Z`: Logical, length 1, default FALSE, used to determine whether or
  not the atomic number subscript is used in formatting nuclear notation
  of isotopes.

- `warn`: Logical, length 1, default TRUE, used to determine whether or
  not a warning is issued when an input for a chemical element in
  hyphenated notation contains an error in the element symbol or the
  mass number of the isotope.

## Examples

``` r
# Show all options
formatdown_options()
#> $delim
#> [1] "$"
#> 
#> $size
#> NULL
#> 
#> $decimal_mark
#> [1] "."
#> 
#> $big_mark
#> [1] ""
#> 
#> $big_interval
#> [1] 3
#> 
#> $small_mark
#> [1] ""
#> 
#> $small_interval
#> [1] 5
#> 
#> $whitespace
#> [1] "\\\\ "
#> 
#> $multiply_mark
#> [1] "\\times"
#> 
#> $Z
#> [1] FALSE
#> 
#> $warn
#> [1] TRUE
#> 

# Store existing settings, including any changes made by the user
old_settings <- formatdown_options()

# View one option
formatdown_options()$delim
#> [1] "$"

# View multiple options
formatdown_options("size", "delim")
#> $size
#> NULL
#> 
#> $delim
#> [1] "$"
#> 

# Change options
formatdown_options(size = "small", delim = "\\(")
formatdown_options("size", "delim")
#> $size
#> [1] "small"
#> 
#> $delim
#> [1] "\\("
#> 

# Reset to default values
formatdown_options(reset = TRUE)
formatdown_options("size", "delim")
#> $size
#> NULL
#> 
#> $delim
#> [1] "$"
#> 

# Reset options to those before this example was run
do.call(formatdown_options, old_settings)

# Option effects

# delim
x <- 101300
format_dcml(x)
#> [1] "$101300$"
# equivalent to
format_dcml(x, delim = c("$", "$"))
#> [1] "$101300$"
# built-in alternate
format_dcml(x, delim = "\\(")
#> [1] "\\(101300\\)"
# equivalent to
format_dcml(x, delim = c("\\(", "\\)"))
#> [1] "\\(101300\\)"

# size
format_dcml(x, size = "small")
#> [1] "$\\small 101300$"
# equivalent to
format_dcml(x, size = "\\small")
#> [1] "$\\small 101300$"
# other possible values
format_dcml(x, size = "scriptsize")
#> [1] "$\\scriptsize 101300$"
format_dcml(x, size = "large")
#> [1] "$\\large 101300$"
format_dcml(x, size = "huge")
#> [1] "$\\huge 101300$"
# default NULL
format_dcml(x, size = NULL)
#> [1] "$101300$"
# renders equivalent to
format_dcml(x, size = "normalsize")
#> [1] "$\\normalsize 101300$"

# decimal_mark
y <- 6.02214076E+10
format_sci(y, 5, decimal_mark = ".")
#> [1] "$6.0221 \\times 10^{10}$"
format_sci(y, 5, decimal_mark = ",")
#> [1] "$6,0221 \\times 10^{10}$"

# big_mark
format_dcml(y, 9)
#> [1] "$60221407600$"
format_dcml(y, 9, big_mark = "thin")
#> [1] "$60\\,221\\,407\\,600$"
# equivalent to
format_dcml(y, 9, big_mark = "\\\\,")
#> [1] "$60\\,221\\,407\\,600$"

# big_interval
format_dcml(y, 9, big_mark = "thin", big_interval = 3)
#> [1] "$60\\,221\\,407\\,600$"
format_dcml(y, 9, big_mark = "thin", big_interval = 5)
#> [1] "$6\\,02214\\,07600$"

# small_mark
z <- 1.602176634e-8
format_sci(z, 10)
#> [1] "$1.602176634 \\times 10^{-8}$"
format_sci(z, 10, small_mark = "thin")
#> [1] "$1.60217\\,6634 \\times 10^{-8}$"
format_sci(z, 10, small_mark = "\\\\,")
#> [1] "$1.60217\\,6634 \\times 10^{-8}$"
format_engr(z, 10, small_mark = "thin")
#> [1] "$16.02176\\,634 \\times 10^{-9}$"

# small_interval
format_sci(z, 10, small_mark = "thin", small_interval = 3)
#> [1] "$1.602\\,176\\,634 \\times 10^{-8}$"
format_sci(z, 10, small_mark = "thin", small_interval = 5)
#> [1] "$1.60217\\,6634 \\times 10^{-8}$"
format_engr(z, 10, small_mark = "thin", small_interval = 5)
#> [1] "$16.02176\\,634 \\times 10^{-9}$"

# whitespace in text
p <- "Hello world!"
format_text(p)
#> [1] "$\\mathrm{Hello\\ world!}$"
# equivalent to
format_text(p, whitespace = "\\\\ ")
#> [1] "$\\mathrm{Hello\\ world!}$"
# alternates
format_text(p, whitespace = "\\\\:")
#> [1] "$\\mathrm{Hello\\:world!}$"
format_text(p, whitespace = "\\\\>")
#> [1] "$\\mathrm{Hello\\>world!}$"

# whitespace in physical units expression
x <- pi
units(x) <- "m/s"
format_dcml(x)
#> [1] "$3.142\\ \\mathrm{m\\ s^{-1}}$"
# equivalent to
format_dcml(x, whitespace = "\\\\ ")
#> [1] "$3.142\\ \\mathrm{m\\ s^{-1}}$"

# multiply_mark
x <- 101300
format_engr(x, decimal_mark = ".", multiply_mark = "\\times")
#> [1] "$101.3 \\times 10^{3}$"
format_engr(x, decimal_mark = ",", multiply_mark = "\\cdot")
#> [1] "$101,3 \\cdot 10^{3}$"
```
