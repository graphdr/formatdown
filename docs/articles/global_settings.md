# Global settings

![](../reference/figures/options-img.png)  
*Option* by Mike Lawrence is licensed under [CC BY 2.0
DEED](https://creativecommons.org/licenses/by/2.0/)

  

Global options are provided for arguments that users are likely prefer
to set once in a document instead of repeating in every function call.
For example, some users prefer a comma decimal marker (“,”) throughout a
document.

Globally-set arguments can be overridden locally by assigning them in a
function call.

## `formatdown_options()`

Set, examine, or reset several global options which affect the way in
which a formatted object is rendered in an R markdown document. The
options and their default settings are

``` r

formatdown_options(delim = "$",
                   size = NULL,
                   decimal_mark = ".",
                   big_mark = "",
                   big_interval = 3,
                   small_mark = "",
                   small_interval = 5,
                   whitespace = "\\\\>", 
                   multiply_mark = "\\times", 
                   Z = FALSE, 
                   reset = FALSE)
```

To reset all formatdown arguments to their default values:

``` r

    formatdown_options(reset = TRUE)
```

  

*Usage.*   For example, get two of the current settings.

``` r

formatdown_options("size", "decimal_mark")
#> $size
#> NULL
#> 
#> $decimal_mark
#> [1] "."
```

Assign new settings; examine result.

``` r

# Set
formatdown_options(size = "large", decimal_mark = ",")

# Examine result
formatdown_options("size", "decimal_mark")
#> $size
#> [1] "large"
#> 
#> $decimal_mark
#> [1] ","
```

Reset to default values; examine result.

``` r

# Set to defaults
formatdown_options(reset = TRUE)

# Examine result
formatdown_options("size", "decimal_mark")
#> $size
#> NULL
#> 
#> $decimal_mark
#> [1] "."
```

## Delimiters

Delimiters are characters that surround a formatted expression such that
R Markdown renders it as an inline math expression.

Sometimes the default `$ ... $` delimiters fail to render correctly. I
encountered this once using
[`kableExtra::kbl()`](https://rdrr.io/pkg/kableExtra/man/kbl.html) in a
`.qmd` document. The solution, suggested by the MathJax consortium
([Cervone, 2018](#ref-Cervone:2018)), is to use the delimiter pair
`\( ... \)`, hence the built-in alternate, `delim = "\\("`.

Left and right custom delimiters can be assigned in a vector, e.g.,
`c("\\[", "\\]")`.

  

*Examples.*   Note that using
[`format_text()`](https://graphdr.github.io/formatdown/reference/format_text.md)
introduces additional markup inside the delimiters. Details are
described in the [Format
text](https://graphdr.github.io/formatdown/articles/format_text.md)
article.

``` r

x <- 101300
txt <- "Hello world!"

# 1. Numeric input, default delimiters
format_dcml(x)
#> [1] "$101300$"

# 2. Numeric input, alternate delimiters
format_dcml(x, delim = "\\(")
#> [1] "\\(101300\\)"

# 3. Character input, default delimiters
format_text(txt)
#> [1] "$\\mathrm{Hello\\ world!}$"

# 4. Character input, alternate delimiters
format_text(txt, delim = "\\(")
#> [1] "\\(\\mathrm{Hello\\ world!}\\)"
```

  

Examples 1–4 (in inline code chunks) render as,

1.  \small 101300

2.  \small 101300

3.  \small \mathrm{Hello\\ world!}

4.  \small \mathrm{Hello\\ world!}

  

## Font size

Font size is set using LaTeX-style macros inside the math-delimited
expression. For example, with `size = "small"` (or `size = "\\small"`),
the formatdown markup of the Avogadro constant would be

        "$\\small 6.0221 \\times 10^{23}$", 

where the extra backslashes are necessary to escape the backslashes in
`\small` and `\times`. If `size = NULL` (default), no size command is
added and the font size is equivalent to `"normalsize"`.

  

*Examples.*

``` r

# 5. Numeric input
format_dcml(x, size = "scriptsize")
#> [1] "$\\scriptsize 101300$"

# 6. Numeric input
format_dcml(x, size = "small")
#> [1] "$\\small 101300$"

# 7. Power-of-ten number using LaTeX-style size markup
format_sci(6.0221e+23, size = "\\small")
#> [1] "$\\small 6.022 \\times 10^{23}$"

# 8. Character input, default size
format_text(txt)
#> [1] "$\\mathrm{Hello\\ world!}$"

# 9. Character input
format_text(txt, size = "large")
#> [1] "$\\large \\mathrm{Hello\\ world!}$"
```

  

Examples 5–9 render as,

5.  \scriptsize 101300

6.  \small 101300

7.  \small 6.022 \times 10^{23}

8.  \mathrm{Hello\\ world!}

9.  \large \mathrm{Hello\\ world!}

  

*Available sizes*

Comparing decimal notation, scientific notation, and text in possible
font sizes (formatdown does not support the sizes: tiny, footnotesize,
Large, LARGE, and Huge).

| scriptsize | small | normalsize | large | huge |
|---:|---:|---:|---:|---:|
| \scriptsize 3.1416 | \small 3.1416 | \normalsize 3.1416 | \large 3.1416 | \huge 3.1416 |
| \scriptsize 5 \times 10^{3} | \small 5 \times 10^{3} | \normalsize 5 \times 10^{3} | \large 5 \times 10^{3} | \huge 5 \times 10^{3} |
| \scriptsize \mathrm{The\\ cat} | \small \mathrm{The\\ cat} | \normalsize \mathrm{The\\ cat} | \large \mathrm{The\\ cat} | \huge \mathrm{The\\ cat} |

## Decimal separator

For a number written in decimal form, the decimal mark separates the
integer part from the fractional part.

- A period or dot (“.”) is the conventional decimal mark in the US,
  Australia, Canada (English-speaking), Mexico, the UK, much of eastern
  Asia, and other regions.

- A comma (“,”) is the conventional decimal mark in Brazil, Canada
  (French-speaking), much of Europe and Latin America, Russia, and other
  regions.

The decimal mark in formatdown may be reset locally in a function call
or globally using
[`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md);
it is not affected by the base R option `OutDec`.

  

*Examples.*

``` r

# 10. Decimal markup
x <- pi
format_dcml(x, 5, decimal_mark = ",")
#> [1] "$3,1416$"

# 11. Power-of-ten markup
y <- 1.602176634e-19
format_sci(y, 5, decimal_mark = ",")
#> [1] "$1,6022 \\times 10^{-19}$"
```

  

Examples 10 and 11 render as,

10. \small 3,1416

11. \small 1,6022 \times 10^{-19}

  

## Separating digits

The NIST recommends we use a thin space to separate more than 4 digits
to the left or to the right of a decimal marker ([Thompson & Taylor,
2022, p. 10.5.3](#ref-NIST:2022)):

> … digits should be separated into groups of three, counting from the
> decimal marker towards the left and right, by the use of a thin, fixed
> space. However, this practice is not usually followed for numbers
> having only four digits on either side of the decimal marker except
> when uniformity in a table is desired.

Both `big_mark` and `small_mark` add the horizontal-space characters
inside the math delimiters; `big_mark` to the integer portion and
`small_mark` to the fractional portion. The possible values are empty
`""` (default), `"thin"`, or the thin-space macro itself `\\\\,`.

The interval arguments `big_interval` and `small_interval` set the
number of digits separated by thin spaces when `big_mark` or
`small_mark` are not empty. However, formatdown does not encode the
exemption for 4-digit groups mentioned in the NIST quote above.

  

*Examples.*

``` r

w <- 1013
x <- 101300
y <- 0.002456
z <- x + y

# 12. 4-digit number, no space
format_dcml(w)
#> [1] "$1013$"

# 13. 4-digit number, with space
format_dcml(w, big_mark = "thin")
#> [1] "$1\\,013$"

# 14. Group digits to the left of the decimal
format_dcml(x, big_mark = "thin")
#> [1] "$101\\,300$"

# 15. Group digits to the right of the decimal
format_dcml(y, small_mark = "\\\\,")
#> [1] "$0.00245\\,6$"

# 16. Change the small interval
format_dcml(y, small_mark = "\\\\,", small_interval = 3)
#> [1] "$0.002\\,456$"

# 17. Group digits to the left and right of the decimal
format_dcml(z, 12, big_mark = "thin", small_mark = "thin")
#> [1] "$101\\,300.00245\\,6$"
```

  

Examples 12–17 render as,

12. \small 1013

13. \small 1\\013

14. \small 101\\300

15. \small 0.00245\\6

16. \small 0.002\\456

17. \small 101\\300.00245\\6

## Preserving text spaces

The horizontal-space macro is used to preserve spaces in text formatted
with
[`format_text()`](https://graphdr.github.io/formatdown/reference/format_text.md)
as well as spaces within physical-unit strings with
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md).
Without it, an inline math markup such as

        $\mathrm{This Is Math Text.}$

is rendered in an R markdown document as

\qquad \small\mathrm{This Is Math Text.}

To preserve such spaces, formatdown substitutes the character string
`\>` for each space, producing output like the following, where
backslashes have been escaped,

        "$\\mathrm{This\\>Is\\>Math\\>Text.}$"

rendered as,

\qquad \small\mathrm{This\\Is\\Math\\Text.}

Because the backslashes must be escaped, the formatdown output is
\small\mathtt{\verb\|"\\\>"\|}, but the the argument value set by the
user is `whitespace =` \small\mathtt{\verb\|"\\\\\>"\|}. One may also
use \mathtt{\small\verb\|"\\\\:"\|} or \mathtt{\small\verb\|"\\\\ "\|}.

  

*Examples.*

``` r

# 18. Character input, default space "\>"
format_text(txt, whitespace = "\\\\>")
#> [1] "$\\mathrm{Hello\\>world!}$"

# 19. Character input, alternate space "\:"
format_text(txt, whitespace = "\\\\:")
#> [1] "$\\mathrm{Hello\\:world!}$"

# 20. Character input, alternate space "\ "
format_text(txt, whitespace = "\\\\ ")
#> [1] "$\\mathrm{Hello\\ world!}$"
```

  

Examples 18–20 render as,

18. \small \mathrm{Hello\\ world!}

19. \small \mathrm{Hello\\world!}

20. \small \mathrm{Hello\\ world!}

## Multiplication symbol

The default symbol used in power of ten notation is “\small\times”, as
in \small 3.14 \times 10^{-3}. An alternate—often used when the decimal
marker is a comma—is the centered dot, e.g., \small 3,14 \cdot 10^{-3}.

The symbol is set using the `multiply_mark` argument. The default
setting is `"\\times"`; the alternate, centered-dot setting, is
`"\\cdot"`.

  

*Examples.*

``` r

# 21. Alternate multiplication symbol
y <- 1.602176634e-19
format_sci(y, 5, decimal_mark = ",", multiply_mark = "\\cdot")
#> [1] "$1,6022 \\cdot 10^{-19}$"
```

  

Example 21 renders as:

21. \small 1,6022 \cdot 10^{-19}

  

## Applications

*Example 22.*

In this example, we format different columns of a data frame using
`decimal_mark`, `big_mark` and `small_mark`.

``` r

# Set options
formatdown_options(decimal_mark = ",", big_mark = "thin", small_mark = "thin")

# Use water data included with formatdown
DT <- copy(water)[1:6]

# Examine the data frame
DT[]
#>      temp   dens   sp_wt       visc bulk_mod
#>     <num>  <num>   <num>      <num>    <num>
#> 1: 273.15 999.87 9808.70 0.00173360 2.02e+09
#> 2: 283.15 999.73 9807.33 0.00131050 2.10e+09
#> 3: 293.15 998.23 9792.67 0.00102120 2.18e+09
#> 4: 303.15 995.68 9767.60 0.00081743 2.25e+09
#> 5: 313.15 992.25 9733.95 0.00066988 2.28e+09
#> 6: 323.15 988.06 9692.90 0.00056046 2.29e+09

# Routine decimal formatting
DT$temp <- format_dcml(DT$temp)
DT$dens <- format_dcml(DT$dens)

# Omit big_mark spacing for 4 digits
DT$sp_wt <- format_dcml(DT$sp_wt, 4, big_mark = "")

# Set significant digits (viscosity) to achieve a consistent string length
DT[visc >= 0.001, temp_visc := format_dcml(visc, 5)]
DT[visc < 0.001, temp_visc := format_dcml(visc, 4)]
DT[, visc := temp_visc]
DT[, temp_visc := NULL]

# Will appear with big_mark spacing, change from Pa to kPa
DT$bulk_mod_kPa <- format_dcml(DT$bulk_mod / 1000, 4)
DT$bulk_mod <- NULL

knitr::kable(DT, align = "r", caption = "Example 22.")
```

|         temp |         dens |       sp_wt |               visc |       bulk_mod_kPa |
|-------------:|-------------:|------------:|-------------------:|-------------------:|
| \small 273,2 | \small 999,9 | \small 9809 | \small 0,00173\\36 | \small 2\\020\\000 |
| \small 283,2 | \small 999,7 | \small 9807 | \small 0,00131\\05 | \small 2\\100\\000 |
| \small 293,2 | \small 998,2 | \small 9793 | \small 0,00102\\12 | \small 2\\180\\000 |
| \small 303,2 | \small 995,7 | \small 9768 | \small 0,00081\\74 | \small 2\\250\\000 |
| \small 313,2 | \small 992,2 | \small 9734 | \small 0,00066\\99 | \small 2\\280\\000 |
| \small 323,2 | \small 988,1 | \small 9693 | \small 0,00056\\05 | \small 2\\290\\000 |

Example 22. {.table}

``` r


# Set package options to default values
formatdown_options(reset = TRUE)
```

  

*Example 23.*

Same table, but using power of ten formatting.

``` r

# Use water data included with formatdown
DT <- copy(water)[1:6]

# Routine decimal formatting
cols <- c("temp", "dens", "sp_wt")
DT[, (cols) := lapply(.SD, function(x) format_dcml(x)), .SDcols = cols]

# Power of ten
DT$bulk_mod <- format_engr(DT$bulk_mod, 3)
DT$visc <- format_engr(DT$visc, 4, set_power = -3)

knitr::kable(DT, align = "r", caption = "Example 23.")
```

| temp | dens | sp_wt | visc | bulk_mod |
|---:|---:|---:|---:|---:|
| \small 273.2 | \small 999.9 | \small 9809 | \small 1.734 \times 10^{-3} | \small 2.02 \times 10^{9} |
| \small 283.2 | \small 999.7 | \small 9807 | \small 1.310 \times 10^{-3} | \small 2.10 \times 10^{9} |
| \small 293.2 | \small 998.2 | \small 9793 | \small 1.021 \times 10^{-3} | \small 2.18 \times 10^{9} |
| \small 303.2 | \small 995.7 | \small 9768 | \small 0.8174 \times 10^{-3} | \small 2.25 \times 10^{9} |
| \small 313.2 | \small 992.2 | \small 9734 | \small 0.6699 \times 10^{-3} | \small 2.28 \times 10^{9} |
| \small 323.2 | \small 988.1 | \small 9693 | \small 0.5605 \times 10^{-3} | \small 2.29 \times 10^{9} |

Example 23. {.table style="width:100%;"}

  

*Example 24.*

The `metals` data set includes columns of text and decimal and
power-of-ten numbers.

``` r

# Use water data included with formatdown
DT <- copy(metals)

# Examine the data frame
DT[]
#>            metal  dens  thrm_exp thrm_cond  elast_mod
#>           <char> <num>     <num>     <num>      <num>
#> 1: aluminum 6061  2700 2.430e-05    155.77 7.3084e+10
#> 2:        copper  8900 1.656e-05    392.88 1.1721e+11
#> 3:          lead 11340 5.274e-05     37.04 1.3790e+10
#> 4:      platinum 21450 9.000e-06     69.23 1.4686e+11
#> 5:    steel 1020  7850 1.134e-05     46.73 2.0684e+11
#> 6:      titanium  4850 9.360e-06      7.44 1.0204e+11

# Text
DT$metal <- format_text(DT$metal)

# Decimal
cols <- c("dens", "thrm_cond")
DT[, (cols) := lapply(.SD, function(x) format_dcml(x)), .SDcols = cols]

# Power of ten
cols <- c("elast_mod", "thrm_exp")
DT[, (cols) := lapply(.SD, function(x) format_engr(x, 3)), .SDcols = cols]

knitr::kable(DT, align = "lrrrr", caption = "Example 24.")
```

| metal | dens | thrm_exp | thrm_cond | elast_mod |
|:---|---:|---:|---:|---:|
| \small \mathrm{aluminum\\ 6061} | \small 2700 | \small 24.3 \times 10^{-6} | \small 155.8 | \small 73.1 \times 10^{9} |
| \small \mathrm{copper} | \small 8900 | \small 16.6 \times 10^{-6} | \small 392.9 | \small 117 \times 10^{9} |
| \small \mathrm{lead} | \small 11340 | \small 52.7 \times 10^{-6} | \small 37.04 | \small 13.8 \times 10^{9} |
| \small \mathrm{platinum} | \small 21450 | \small 9.00 \times 10^{-6} | \small 69.23 | \small 147 \times 10^{9} |
| \small \mathrm{steel\\ 1020} | \small 7850 | \small 11.3 \times 10^{-6} | \small 46.73 | \small 207 \times 10^{9} |
| \small \mathrm{titanium} | \small 4850 | \small 9.36 \times 10^{-6} | \small 7.440 | \small 102 \times 10^{9} |

Example 24. {.table}

## References

Cervone, D. (2018). *MathJax: TeX and LaTeX math delimiters*.
<https://docs.mathjax.org/en/v2.7-latest/tex.html#tex-and-latex-math-delimiters>

Thompson, A., & Taylor, B. N. (2022). *NIST Guide to the SI, Chapter 10:
More on Printing and Using Symbols and Numbers in Scientific and
Technical Documents*. US National Institute of Standards and Technology.
<https://www.nist.gov/pml/special-publication-811/nist-guide-si-chapter-10-more-printing-and-using-symbols-and-numbers>
