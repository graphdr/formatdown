# Format numbers

| Prefix | Symbol | Value | Prefix | Symbol | Value |
|:---|:--:|:---|:---|:--:|:---|
| peta | \\\small \mathit{P}\\ | \\\small 10^{15}\\ | milli | \\\small \mathit{m}\\ | \\\small 10^{-3}\\ |
| tera | \\\small \mathit{T}\\ | \\\small 10^{12}\\ | micro | \\\small \mathit{\mu}\\ | \\\small 10^{-6}\\ |
| giga | \\\small \mathit{G}\\ | \\\small 10^{9}\\ | nano | \\\small \mathit{n}\\ | \\\small 10^{-9}\\ |
| mega | \\\small \mathit{M}\\ | \\\small 10^{6}\\ | pico | \\\small \mathit{p}\\ | \\\small 10^{-12}\\ |
| kilo | \\\small \mathit{k}\\ | \\\small 10^{3}\\ | femto | \\\small \mathit{f}\\ | \\\small 10^{-15}\\ |

The rationale for the formatdown package is formatting numbers in
power-of-ten notation in inline R code or tabulated columns of data
frames. Other features of the package provide tools for typesetting
non-power-of-ten columns to match. In this vignette, we discuss the
primary formatting function
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md)
and its convenience wrappers for scientific, engineering, and decimal
notation.

## Types of notation

Notation to represent large and small numbers depends on the mode of
communication. In a computer script, for example, we might encode the
Avogadro constant as `N_A = 6.0221*10^23`. The asterisk (\*) and caret
(^) in this expression, however, communicate *instructions to a
computer*, not *syntactical mathematics*. And while scientific
E-notation (`6.0221E+23`) has currency in some discourse communities,
power-of-ten notation, e.g., \\\small N_A = 6.0221 \times 10^{23}\\, is
the conventional format for professional technical communication.

Power-of-ten notation is expressed,

\\ \small a \times 10^n, \\

where \\\small a\\ is the coefficient in decimal form and the exponent
\\\small n\\ is an integer. Two formats are in common use ([Chase, 2021,
pp. 63–67](#ref-Chase:2021)):

- *scientific:*   \\\small 1\leq{\|a\|} \< 10\\, e.g., \\\small N_A =\\
  \\\small 6.0221 \times 10^{23}\\.

- *engineering:*   \\\small 1\leq{\|a\|} \< 1000\\ and \\\small n\\ is a
  multiple of 3, e.g., \\\small N_A =\\ \\\small 602.21 \times
  10^{21}\\.

The utility of the engineering form follows from the SI prefixes for
physical units such as “mega-”, “kilo-”, “milli-”, etc., corresponding
to powers of 10 that are integer multiples of three.

  

*Notes on syntax.*   Programming symbols are not necessarily
mathematical symbols:

- asterisk (\*). Programming symbol for multiplication, e.g.,
  `x = a * b` or `y = a * (b + c)`. In the grammar of mathematics,
  multiplication is indicated by the symbol (\\\times\\) when needed.

- caret (^). Programming symbol for exponentiation, e.g., `x = y^2` or
  `z = 10^-3`. In the grammar of mathematics, exponents are typeset as
  superscripts, e.g., \\\small x = y^2\\ or \\\small z = 10^{-3}\\.

- multiplication (\\\small\times\\). Mathematical symbol for
  multiplication, not to be confused with the letter “x”. Generally
  omitted when the meaning is clear, e.g., \\\small x=ab\\ or \\\small
  y=a(b+c)\\, but conventionally included in power-of-ten notation,
  e.g., \\\small 6.0221 \times 10^{23}\\. When a comma is used as the
  decimal marker, multiplication may be indicated by the half-high dot,
  e.g., \\\small 6,0221 \cdot 10^{23}\\.

  

*Decimal subsets.*   In a vector of numbers formatted in power-of-ten
form, the decimal form may be preferred for any subset of values with
exponents near zero, e.g., \\\small n \in \\-1, 0, 1, 2\\\\.

|            scientific notation |         subset in decimal form |
|-------------------------------:|-------------------------------:|
| \\\small 3.12 \times 10^{-3}\\ | \\\small 3.12 \times 10^{-3}\\ |
| \\\small 3.12 \times 10^{-2}\\ | \\\small 3.12 \times 10^{-2}\\ |
| \\\small 3.12 \times 10^{-1}\\ |               \\\small 0.312\\ |
|  \\\small 3.12 \times 10^{0}\\ |                \\\small 3.12\\ |
|  \\\small 3.12 \times 10^{1}\\ |                \\\small 31.2\\ |
|  \\\small 3.12 \times 10^{2}\\ |                 \\\small 312\\ |
|  \\\small 3.12 \times 10^{3}\\ |  \\\small 3.12 \times 10^{3}\\ |
|  \\\small 3.12 \times 10^{4}\\ |  \\\small 3.12 \times 10^{4}\\ |

Decimal form may be preferred for a subset {.table}

  

*Decimal columns.*   A table of numeric information can include columns
formatted in both power-of-ten notation and decimal notation. For
example, a table of atmospheric properties shown below has altitude in
integer form, temperature in decimal form, and density in power-of-ten
engineering notation (except for those values with exponents near zero).

|  Altitude (km) |   Temperature (K) |           Density (kg/m\\^3\\) |
|---------------:|------------------:|-------------------------------:|
|   \\\small 0\\ | \\\small 288.15\\ |                \\\small 1.23\\ |
|  \\\small 10\\ | \\\small 223.25\\ |               \\\small 0.414\\ |
|  \\\small 20\\ | \\\small 216.65\\ | \\\small 88.9 \times 10^{-3}\\ |
|  \\\small 30\\ | \\\small 226.51\\ | \\\small 18.4 \times 10^{-3}\\ |
|  \\\small 40\\ | \\\small 250.35\\ | \\\small 4.00 \times 10^{-3}\\ |
|  \\\small 50\\ | \\\small 270.65\\ | \\\small 1.03 \times 10^{-3}\\ |
|  \\\small 60\\ | \\\small 247.02\\ |  \\\small 310 \times 10^{-6}\\ |
|  \\\small 70\\ | \\\small 219.59\\ | \\\small 82.8 \times 10^{-6}\\ |
|  \\\small 80\\ | \\\small 198.64\\ | \\\small 18.5 \times 10^{-6}\\ |
|  \\\small 90\\ | \\\small 186.87\\ | \\\small 3.43 \times 10^{-6}\\ |
| \\\small 100\\ | \\\small 195.08\\ |  \\\small 560 \times 10^{-9}\\ |

Properties of the atmosphere {.table}

The purpose of the decimal format in formatdown is to match the font
face and size of decimal columns to those of the power-of-ten columns.
If no power-of-ten columns are used, of course, decimal columns can be
displayed as-is or formatted using other R tools.

  

*Packages.*   If you are writing your own script to follow along, we use
the following packages in this vignette. Data frame operations are
performed with data.table syntax. Some users may wish to translate the
examples to use base R or dplyr syntax.

``` r

library("formatdown")
library("data.table")
library("knitr")
```

## Markup

We format numbers as inline math expressions delimited by `$ ... $` or
the optional `\( ... \)`. For example, the Avogadro constant is marked
up as

        $6.0221 \times 10^{23}$, 

where the `\times` macro creates the multiplication symbol
(\\\small\times\\). This math markup, as an inline equation in an R
markdown document, renders as: \\\small 6.0221 \times 10^{23}\\. To
*program* the markup, however, we enclose it in quote marks as a
character string, that is,

        "$6.0221 \\times 10^{23}$", 

which requires us to “escape” the backslash in `\times` by adding an
extra backslash. When the optional font size argument is assigned,
formatdown adds a LaTeX-style sizing macro such as `\small` or `\large`,
for example,

        "$\\small 6.0221 \\times 10^{23}$", 

where again the markup includes an extra backslash.

## `format_sci()`

Converts numbers to character strings in power-of-ten form,

        "$a \\times 10^{n}$" 

where \\\small a\\ is the coefficient and \\\small n\\ is the exponent.
[`format_sci()`](https://graphdr.github.io/formatdown/reference/format_sci.md)
is a wrapper for the more general function
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md).
For a subset of values with exponents near zero, e.g., \\\small n \in
\\-1, 0, 1, 2\\\\, the output is in decimal form,

        "$a$"

  

*Usage.*  

``` r

format_sci(x,
           digits = 4,
           ...,
           omit_power = c(-1, 2),
           set_power = NULL,
           delim          = formatdown_options("delim"),
           size           = formatdown_options("size"),
           decimal_mark   = formatdown_options("decimal_mark"),
           small_mark     = formatdown_options("small_mark"),
           small_interval = formatdown_options("small_interval"), 
           whitespace     = formatdown_options("whitespace"), 
           multiply_mark  = formatdown_options("multiply_mark"))
```

- Arguments before the dots do not have to be named if argument order is
  maintained.
- Arguments after the dots (`...`) must be named.
- The arguments assigned via
  [`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md)
  can be reset by the user locally in a function call or globally using
  [`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md).

  

*Examples.*   These early examples are shown with default arguments.
Arguments are explored more fully starting with [Numeric
input](#numeric-input) section.

``` r

# 1. Avogadro constant
L <- 6.0221E+23
format_sci(L)
#> [1] "$6.022 \\times 10^{23}$"

# 2. Elementary charge
e <- 1.602176634e-19
format_sci(e)
#> [1] "$1.602 \\times 10^{-19}$"
```

Examples 1 and 2 (in inline code chunks) render as,

1.  The Avogadro constant is \\\small L =\\ \\\small 6.022 \times
    10^{23}\\ \\\small \mathit{mol}^{-1}\\.
2.  The elementary charge constant is \\\small e =\\ \\\small 1.602
    \times 10^{-19}\\ \\\small C\\.

## `format_engr()`

Similar to
[`format_sci()`](https://graphdr.github.io/formatdown/reference/format_sci.md)
except using engineering notation, i.e., exponents are multiples of 3.

  

*Usage.*

``` r

format_engr(x,
            digits = 4,
            ...,
            omit_power = c(-1, 2),
            set_power = NULL,
            delim          = formatdown_options("delim"),
            size           = formatdown_options("size"),
            decimal_mark   = formatdown_options("decimal_mark"),
            small_mark     = formatdown_options("small_mark"),
            small_interval = formatdown_options("small_interval"), 
            whitespace     = formatdown_options("whitespace"), 
            multiply_mark  = formatdown_options("multiply_mark"))
```

  

*Examples.*   (with default arguments)

``` r

# 3. Avogadro constant
format_engr(L)
#> [1] "$602.2 \\times 10^{21}$"

# 4. Elementary charge
format_engr(e)
#> [1] "$160.2 \\times 10^{-21}$"
```

Examples 3 and 4 render as,

3.  The Avogadro constant is \\\small L =\\ \\\small 602.2 \times
    10^{21}\\ \\\small \mathit{mol}^{-1}\\.
4.  The elementary charge constant is \\\small e =\\ \\\small 160.2
    \times 10^{-21}\\ \\\small C\\.

## `format_dcml()`

A wrapper for the more general function
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md);
converts numbers to character strings in decimal form,

        "$a$"

where \\\small a\\ is the decimal value.

  

*Usage.*

``` r

format_dcml(x,
            digits = 4,
            ...,
            size           = formatdown_options("size"),
            delim          = formatdown_options("delim"),
            decimal_mark   = formatdown_options("decimal_mark"),
            big_mark       = formatdown_options("big_mark"),
            big_interval   = formatdown_options("big_interval"),
            small_mark     = formatdown_options("small_mark"),
            small_interval = formatdown_options("small_interval"), 
            whitespace     = formatdown_options("whitespace"))
```

  

*Examples.*   (with default arguments)

``` r

# 5. Speed of light in a vacuum
c <- 299792458
format_dcml(c)
#> [1] "$299800000$"

# 6. Molar gas constant
R <- 8.31446261815324
format_dcml(R)
#> [1] "$8.314$"
```

Examples 5 and 6 render as,

5.  The speed of light in a vacuum is \\\small c =\\ \\\small
    299800000\\ \\\small\mathit{m/s}\\.
6.  The molar gas constant is \\\small R =\\ \\\small 8.314\\
    \\\small\mathit{J}\cdot\mathit{K}^{-1}\mathit{mol}^{-1}\\.

## `format_numbers()`

[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md)
is the general-purpose formatting function called by
[`format_sci()`](https://graphdr.github.io/formatdown/reference/format_sci.md),
[`format_engr()`](https://graphdr.github.io/formatdown/reference/format_engr.md),
and
[`format_dcml()`](https://graphdr.github.io/formatdown/reference/format_dcml.md).
The general function can be used instead of the convenience functions
simply by setting its `format` argument to `"sci"`, `"engr"` (default),
or `"dcml"`.

  

*Usage.*

``` r

format_numbers(x,
               digits = 4,
               format = "engr",
               ...,
               omit_power = c(-1, 2),
               set_power = NULL,
               delim          = formatdown_options("delim"),
               size           = formatdown_options("size"),
               decimal_mark   = formatdown_options("decimal_mark"),
               big_mark       = formatdown_options("big_mark"),
               small_mark     = formatdown_options("small_mark"),
               big_interval   = formatdown_options("big_interval"),
               small_interval = formatdown_options("small_interval"), 
               whitespace     = formatdown_options("whitespace"), 
               multiply_mark  = formatdown_options("multiply_mark"))
```

*Examples.*   Reproducing some of the earlier examples using
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md).

``` r

# 7. Scientific
format_numbers(L, format = "sci")
#> [1] "$6.022 \\times 10^{23}$"

# 8. Engineering
format_numbers(e, format = "engr")
#> [1] "$160.2 \\times 10^{-21}$"

# 9. Decimal
format_numbers(R, format = "dcml")
#> [1] "$8.314$"
```

Examples 7–9 render as,

7.  The Avogadro constant is \\\small L =\\ \\\small 6.022 \times
    10^{23}\\ \\\small \mathit{mol}^{-1}\\.
8.  The elementary charge constant is \\\small e =\\ \\\small 160.2
    \times 10^{-21}\\ \\\small C\\.
9.  The molar gas constant is \\\small R =\\ \\\small 8.314\\
    \\\small\mathit{J}\cdot\mathit{K}^{-1}\mathit{mol}^{-1}\\.

## Numeric input

This section begins our detailed discussion of arguments.

*Scalar input.*   Generally used with inline R code. For example, the
following R markdown sentence, which includes some math markup and some
inline R code,

``` default
    The Avogadro constant is $L = $ `r format_sci(L)` $\mathit{mol}^{-1}$. 
```

renders as: The Avogadro constant is \\\small L =\\ \\\small 6.022
\times 10^{23}\\ \\\small\mathit{mol}^{-1}\\.

  

*Vector.*   A vector of numbers (or a data frame column) is marked up as
follows,

``` r

# 10. Sample vector
x <- c(2.3333e-5, 3.4444e-4, 5.2222e-2, 6.3333e-1, 8.1111e+1, 9.2222e+2, 2.4444e+4, 3.1111e+5, 4.2222e+6)
format_engr(x)
#> [1] "$23.33 \\times 10^{-6}$" "$344.4 \\times 10^{-6}$"
#> [3] "$52.22 \\times 10^{-3}$" "$0.6333$"               
#> [5] "$81.11$"                 "$922.2$"                
#> [7] "$24.44 \\times 10^{3}$"  "$311.1 \\times 10^{3}$" 
#> [9] "$4.222 \\times 10^{6}$"
```

In a table, the output renders as,

``` r

DT <- data.table(x, format_engr(x))
knitr::kable(DT,
  align = "r",
  col.names = c("Unformatted", "Engr notation"),
  caption = "Example 10."
)
```

| Unformatted |                   Engr notation |
|------------:|--------------------------------:|
|  2.3300e-05 | \\\small 23.33 \times 10^{-6}\\ |
|  3.4440e-04 | \\\small 344.4 \times 10^{-6}\\ |
|  5.2222e-02 | \\\small 52.22 \times 10^{-3}\\ |
|  6.3333e-01 |               \\\small 0.6333\\ |
|  8.1111e+01 |                \\\small 81.11\\ |
|  9.2222e+02 |                \\\small 922.2\\ |
|  2.4444e+04 |  \\\small 24.44 \times 10^{3}\\ |
|  3.1111e+05 |  \\\small 311.1 \times 10^{3}\\ |
|  4.2222e+06 |  \\\small 4.222 \times 10^{6}\\ |

Example 10. {.table}

For values with exponents \\\small n\in\\-1, 0, 1, 2\\\\, the default
format is decimal; see [Excluding exponents](#excluding-exponents).

## Units input

The [units](https://r-quantities.github.io/units/) R package provides
measurement units for R vectors, converting vectors of class “numeric”
to class “units” ([Pebesma et al.,
2016](#ref-Pebesma+Mailund+Hiebert:2016:units)). For example

``` r

# Number
x <- 10320
class(x)
#> [1] "numeric"

# Convert to units class
units(x) <- "m"
x
#> 10320 [m]
class(x)
#> [1] "units"

# Operations are reflected in the values and its units
y <- x^2
y
#> 106502400 [m^2]

# Unit conversion is supported
z <- y
z
#> 106502400 [m^2]
units(z) <- "ft^2"
z
#> 1146382293 [ft^2]
```

If an input argument to
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md)
(or its convenience functions) is of class “units”, formatdown attempts
to extract the units character string, format the number in the expected
way, and append a units character string to the result. For example,

``` r

# 11. Units-class inputs
format_sci(x)
#> [1] "$1.032 \\times 10^{4}\\ \\mathrm{m}$"
format_sci(y)
#> [1] "$1.065 \\times 10^{8}\\ \\mathrm{m^{2}}$"
format_sci(z)
#> [1] "$1.146 \\times 10^{9}\\ \\mathrm{ft^{2}}$"
```

Example 11 renders as,

- \\\small 1.032 \times 10^{4}\\ \mathrm{m}\\
- \\\small 1.065 \times 10^{8}\\ \mathrm{m^{2}}\\
- \\\small 1.146 \times 10^{9}\\ \mathrm{ft^{2}}\\

More complicated units can be managed. For example the Newtonian
gravitational constant could be formatted as follows, where the
exponents in the units definition are given in “implicit” form, that is,
where \\\small\mathrm{m}^3\\ \mathrm{kg}^{-1}\mathrm{s}^{-2}\\ is
represented by `"m3 kg-1 s-2"`.

``` r

G <- 6.6743e-11
units(G) <- "m3 kg-1 s-2"
format_sci(G)
#> [1] "$6.674 \\times 10^{-11}\\ \\mathrm{m^{3}\\ kg^{-1}\\ s^{-2}}$"
```

Applying a similar procedure to several physical constants, we collect
the results in a data frame and display in a table to illustrate a
variety of units appended to formatted numbers.

| symbol | quantity | formatted_value |
|:---|:---|:---|
| \\\small G\\ | \\\small \mathrm{Newtonian\\ gravitational\\ constant}\\ | \\\small 6.674 \times 10^{-11}\\ \mathrm{m^{3}\\ kg^{-1}\\ s^{-2}}\\ |
| \\\small c\\ | \\\small \mathrm{speed\\ of\\ light\\ in\\ a\\ vacuum}\\ | \\\small 2.998 \times 10^{8}\\ \mathrm{m\\ s^{-1}}\\ |
| \\\small h\\ | \\\small \mathrm{Planck\\ constant}\\ | \\\small 6.626 \times 10^{-34}\\ \mathrm{J\\ Hz^{-1}}\\ |
| \\\small \mu_0\\ | \\\small \mathrm{vacuum\\ magnetic\\ permeability}\\ | \\\small 1.257 \times 10^{-6}\\ \mathrm{N\\ A^{-2}}\\ |
| \\\small k_e\\ | \\\small \mathrm{Coulomb\\ constant}\\ | \\\small 8.988 \times 10^{9}\\ \mathrm{N\\ m^{2}\\ C^{-2}}\\ |
| \\\small \sigma\\ | \\\small \mathrm{Stefan-Boltzmann\\ constant}\\ | \\\small 5.670 \times 10^{-8}\\ \mathrm{W\\ m^{-2}\\ K^{-4}}\\ |

Illustrating a variety of measurement units {.table}

## Significant digits

Significant digits are applied to the input argument using the base R
function [`signif()`](https://rdrr.io/r/base/Round.html) before
additional formatting is applied. For example,

``` r

# 12. Significant digits
format_sci(e, digits = 5)
#> [1] "$1.6022 \\times 10^{-19}$"
format_sci(e, digits = 4)
#> [1] "$1.602 \\times 10^{-19}$"
format_sci(e, digits = 3)
#> [1] "$1.60 \\times 10^{-19}$"
```

Example 12 renders as,

- \\\small 1.6022 \times 10^{-19}\\
- \\\small 1.602 \times 10^{-19}\\
- \\\small 1.60 \times 10^{-19}\\

## Formats

The `format` argument appears in
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md)
only. The default is “engr”. The format is preset in the
[`format_dcml()`](https://graphdr.github.io/formatdown/reference/format_dcml.md),
[`format_engr()`](https://graphdr.github.io/formatdown/reference/format_engr.md),
and
[`format_sci()`](https://graphdr.github.io/formatdown/reference/format_sci.md)
convenience functions.

To compare the effects across many orders of magnitude, we display the
same vector in different formats.

``` r

# 13. Comparing formats
x <- c(2.3333e-5, 3.4444e-4, 5.2222e-2, 6.3333e-1, 8.1111e+1, 9.2222e+2, 2.4444e+4, 3.1111e+5, 4.2222e+6)
dcml <- format_numbers(x, 3, format = "dcml")
sci <- format_numbers(x, 3, format = "sci")
engr <- format_numbers(x, 3, format = "engr")
DT <- data.table(dcml, sci, engr)
knitr::kable(DT,
  align = "r",
  col.names = c("decimal", "scientific", "engineering"),
  caption = "Example 13."
)
```

| decimal | scientific | engineering |
|---:|---:|---:|
| \\\small 0.0000233\\ | \\\small 2.33 \times 10^{-5}\\ | \\\small 23.3 \times 10^{-6}\\ |
| \\\small 0.000344\\ | \\\small 3.44 \times 10^{-4}\\ | \\\small 344 \times 10^{-6}\\ |
| \\\small 0.0522\\ | \\\small 5.22 \times 10^{-2}\\ | \\\small 52.2 \times 10^{-3}\\ |
| \\\small 0.633\\ | \\\small 0.633\\ | \\\small 0.633\\ |
| \\\small 81.1\\ | \\\small 81.1\\ | \\\small 81.1\\ |
| \\\small 922\\ | \\\small 922\\ | \\\small 922\\ |
| \\\small 24400\\ | \\\small 2.44 \times 10^{4}\\ | \\\small 24.4 \times 10^{3}\\ |
| \\\small 311000\\ | \\\small 3.11 \times 10^{5}\\ | \\\small 311 \times 10^{3}\\ |
| \\\small 4220000\\ | \\\small 4.22 \times 10^{6}\\ | \\\small 4.22 \times 10^{6}\\ |

Example 13. {.table}

The values displayed without powers-of-ten notation in the scientific
and engineering columns are determined by the `omit_power` argument
discussed next.

## Excluding a range of exponents

When specifying power-of-ten notation, numbers with exponents lying
within the range of the `omit_power` argument are typeset in decimal
form. In engineering notation, the exponent is checked for lying within
the range before and after the conversion to multiple-of-3 exponents.

To illustrate, we compare two `omit_power` settings in both scientific
and engineering formats. In some columns, we set `omit_power = NULL`,
which imposes power-of-ten notation on the entire vector.

``` r

# 14. Effects of omit_power
DT <- atmos[3:12, .(pres)]
DT[, sci_all := format_sci(pres, 3, omit_power = NULL)]
DT[, sci_omit := format_sci(pres, 3, omit_power = c(-1, 0))]
DT[, engr_all := format_engr(pres, 3, omit_power = NULL)]
DT[, engr_omit := format_engr(pres, 3, omit_power = c(-1, 0))]
knitr::kable(DT,
  align = "r",
  col.names = c(
    "Unformatted",
    "all scientific",
    "scientific w/ omit",
    "all engineering",
    "engineering w/ omit"
  ),
  caption = "Example 14."
)
```

| Unformatted | all scientific | scientific w/ omit | all engineering | engineering w/ omit |
|---:|---:|---:|---:|---:|
| 5.529e+03 | \\\small 5.53 \times 10^{3}\\ | \\\small 5.53 \times 10^{3}\\ | \\\small 5.53 \times 10^{3}\\ | \\\small 5.53 \times 10^{3}\\ |
| 1.197e+03 | \\\small 1.20 \times 10^{3}\\ | \\\small 1.20 \times 10^{3}\\ | \\\small 1.20 \times 10^{3}\\ | \\\small 1.20 \times 10^{3}\\ |
| 2.870e+02 | \\\small 2.87 \times 10^{2}\\ | \\\small 2.87 \times 10^{2}\\ | \\\small 287 \times 10^{0}\\ | \\\small 287\\ |
| 8.000e+01 | \\\small 8.00 \times 10^{1}\\ | \\\small 8.00 \times 10^{1}\\ | \\\small 80.0 \times 10^{0}\\ | \\\small 80.0\\ |
| 2.200e+01 | \\\small 2.20 \times 10^{1}\\ | \\\small 2.20 \times 10^{1}\\ | \\\small 22.0 \times 10^{0}\\ | \\\small 22.0\\ |
| 5.220e+00 | \\\small 5.22 \times 10^{0}\\ | \\\small 5.22\\ | \\\small 5.22 \times 10^{0}\\ | \\\small 5.22\\ |
| 1.050e+00 | \\\small 1.05 \times 10^{0}\\ | \\\small 1.05\\ | \\\small 1.05 \times 10^{0}\\ | \\\small 1.05\\ |
| 1.840e-01 | \\\small 1.84 \times 10^{-1}\\ | \\\small 0.184\\ | \\\small 184 \times 10^{-3}\\ | \\\small 0.184\\ |
| 3.200e-02 | \\\small 3.20 \times 10^{-2}\\ | \\\small 3.20 \times 10^{-2}\\ | \\\small 32.0 \times 10^{-3}\\ | \\\small 32.0 \times 10^{-3}\\ |
| 4.540e-04 | \\\small 4.54 \times 10^{-4}\\ | \\\small 4.54 \times 10^{-4}\\ | \\\small 454 \times 10^{-6}\\ | \\\small 454 \times 10^{-6}\\ |

Example 14. {.table}

Comments:

- In the “scientific with omit” column, the three values \\\small
  (0.184, 1.05, 5.22)\\ are in decimal form because their exponents lie
  within the `omit_power` range \\\small \\-1, 0\\\\.
- The same is true in the “engineering with omit” column because these
  exponents are in the omit range *before* converting to engineering
  form.
- The “engineering with omit” column also displays the values \\(\small
  22, 80, 287)\\ in decimal form because their exponents are in the omit
  range *after* converting to engineering notation.

  

If a single value is assigned, e.g., `omit_power = 0`, the argument is
interpreted as `c(0, 0)`.

``` r

# 15. Omit power used for a single value of exponent
DT <- atmos[3:12, .(pres)]
DT[, sci_all := format_sci(pres, 3, omit_power = NULL)]
DT[, sci_omit := format_sci(pres, 3, omit_power = 0)]
DT[, engr_all := format_engr(pres, 3, omit_power = NULL)]
DT[, engr_omit := format_engr(pres, 3, omit_power = 0)]
knitr::kable(DT,
  align = "r",
  col.names = c(
    "Unformatted",
    "all scientific",
    "scientific w/ omit",
    "all engineering",
    "engineering w/ omit"
  ),
  caption = "Example 15."
)
```

| Unformatted | all scientific | scientific w/ omit | all engineering | engineering w/ omit |
|---:|---:|---:|---:|---:|
| 5.529e+03 | \\\small 5.53 \times 10^{3}\\ | \\\small 5.53 \times 10^{3}\\ | \\\small 5.53 \times 10^{3}\\ | \\\small 5.53 \times 10^{3}\\ |
| 1.197e+03 | \\\small 1.20 \times 10^{3}\\ | \\\small 1.20 \times 10^{3}\\ | \\\small 1.20 \times 10^{3}\\ | \\\small 1.20 \times 10^{3}\\ |
| 2.870e+02 | \\\small 2.87 \times 10^{2}\\ | \\\small 2.87 \times 10^{2}\\ | \\\small 287 \times 10^{0}\\ | \\\small 287\\ |
| 8.000e+01 | \\\small 8.00 \times 10^{1}\\ | \\\small 8.00 \times 10^{1}\\ | \\\small 80.0 \times 10^{0}\\ | \\\small 80.0\\ |
| 2.200e+01 | \\\small 2.20 \times 10^{1}\\ | \\\small 2.20 \times 10^{1}\\ | \\\small 22.0 \times 10^{0}\\ | \\\small 22.0\\ |
| 5.220e+00 | \\\small 5.22 \times 10^{0}\\ | \\\small 5.22\\ | \\\small 5.22 \times 10^{0}\\ | \\\small 5.22\\ |
| 1.050e+00 | \\\small 1.05 \times 10^{0}\\ | \\\small 1.05\\ | \\\small 1.05 \times 10^{0}\\ | \\\small 1.05\\ |
| 1.840e-01 | \\\small 1.84 \times 10^{-1}\\ | \\\small 1.84 \times 10^{-1}\\ | \\\small 184 \times 10^{-3}\\ | \\\small 184 \times 10^{-3}\\ |
| 3.200e-02 | \\\small 3.20 \times 10^{-2}\\ | \\\small 3.20 \times 10^{-2}\\ | \\\small 32.0 \times 10^{-3}\\ | \\\small 32.0 \times 10^{-3}\\ |
| 4.540e-04 | \\\small 4.54 \times 10^{-4}\\ | \\\small 4.54 \times 10^{-4}\\ | \\\small 454 \times 10^{-6}\\ | \\\small 454 \times 10^{-6}\\ |

Example 15. {.table}

  

Setting `omit_power = c(-Inf, Inf)` yields the same decimal result as
`format = "dcml"` and overrides any other `format` setting. For example,

``` r

# 16. Different ways of creating a decimal format
(y <- 6.78e-3)
#> [1] 0.00678

(p <- format_numbers(y, 3, "sci", omit_power = c(-Inf, Inf)))
#> [1] "$0.00678$"

(q <- format_numbers(y, 3, "dcml"))
#> [1] "$0.00678$"

(r <- format_dcml(y, 3))
#> [1] "$0.00678$"

all.equal(p, q)
#> [1] TRUE
all.equal(p, r)
#> [1] TRUE
```

Example 16 (all cases) renders as,

- \\\small 0.00678\\

## Enforcing a specific exponent

When values in a table column span only a few orders of magnitude, an
audience is sometimes better served by setting the notation to a
constant power of ten. For example, here we show numbers in scientific
format and compare to columns in which the exponents are set to fixed
values. Assigning a value to `set_power` overrides `omit_power` and
`format`.

``` r

# 17. set_power argument
DT <- atmos[alt <= 40, .(alt, pres, dens)]
DT[, sci_pres := format_sci(pres, 3, omit_power = c(-1, 2))]
DT[, set_pres := format_sci(pres, 3, omit_power = c(-1, 2), set_power = 3)]
DT[, sci_dens := format_engr(dens, 3, omit_power = c(-1, 2))]
DT[, set_dens := format_engr(dens, 3, omit_power = c(-1, 2), set_power = -2)]
DT[, pres := NULL]
DT[, dens := NULL]
knitr::kable(DT,
  align = "r",
  col.names = c("Altitude (km)", "Pressure (Pa)", "with set_power", "Density (kg/m$^{3}$)", "with set_power"),
  caption = "Example 17."
)
```

| Altitude (km) | Pressure (Pa) | with set_power | Density (kg/m\\^{3}\\) | with set_power |
|---:|---:|---:|---:|---:|
| 0 | \\\small 1.01 \times 10^{5}\\ | \\\small 101 \times 10^{3}\\ | \\\small 1.23\\ | \\\small 123 \times 10^{-2}\\ |
| 10 | \\\small 2.65 \times 10^{4}\\ | \\\small 26.5 \times 10^{3}\\ | \\\small 0.414\\ | \\\small 41.4 \times 10^{-2}\\ |
| 20 | \\\small 5.53 \times 10^{3}\\ | \\\small 5.53 \times 10^{3}\\ | \\\small 88.9 \times 10^{-3}\\ | \\\small 8.89 \times 10^{-2}\\ |
| 30 | \\\small 1.20 \times 10^{3}\\ | \\\small 1.20 \times 10^{3}\\ | \\\small 18.4 \times 10^{-3}\\ | \\\small 1.84 \times 10^{-2}\\ |
| 40 | \\\small 287\\ | \\\small 0.287 \times 10^{3}\\ | \\\small 4.00 \times 10^{-3}\\ | \\\small 0.400 \times 10^{-2}\\ |

Example 17. {.table}

## Tables with units

In a typical data table, the numbers in a column have the same physical
units and are formatted as a vector. For example,

``` r

# Example 18
DT <- air_meas[, .(temp, pres, sp_gas, dens)]

# Examine data
DT[]
#>     temp   pres sp_gas  dens
#>    <num>  <num>  <int> <num>
#> 1: 294.1 101100    287 1.198
#> 2: 294.1 101000    287 1.196
#> 3: 294.6 101100    287 1.196
#> 4: 293.4 101000    287 1.200
#> 5: 293.9 101100    287 1.199

# Assign units
units(DT$temp) <- "K"
units(DT$pres) <- "Pa"
units(DT$sp_gas) <- "J kg-1 K-1"
units(DT$dens) <- "kg m-3"

# Make a copy to preserve DT as-is for a subsequent example
x <- copy(DT)

# Format one column at a time
x$temp <- format_dcml(x$temp)
x$pres <- format_engr(x$pres)

# Or format multiple columns in one pass
cols <- c("sp_gas", "dens")
x[, (cols) := lapply(.SD, format_dcml), .SDcols = cols]

knitr::kable(x, align = "r", caption = "Example 18.")
```

| temp | pres | sp_gas | dens |
|---:|---:|---:|---:|
| \\\small 294.1\\ \mathrm{K}\\ | \\\small 101.1 \times 10^{3}\\ \mathrm{Pa}\\ | \\\small 287.0\\ \mathrm{J\\ kg^{-1}\\ K^{-1}}\\ | \\\small 1.198\\ \mathrm{kg\\ m^{-3}}\\ |
| \\\small 294.1\\ \mathrm{K}\\ | \\\small 101.0 \times 10^{3}\\ \mathrm{Pa}\\ | \\\small 287.0\\ \mathrm{J\\ kg^{-1}\\ K^{-1}}\\ | \\\small 1.196\\ \mathrm{kg\\ m^{-3}}\\ |
| \\\small 294.6\\ \mathrm{K}\\ | \\\small 101.1 \times 10^{3}\\ \mathrm{Pa}\\ | \\\small 287.0\\ \mathrm{J\\ kg^{-1}\\ K^{-1}}\\ | \\\small 1.196\\ \mathrm{kg\\ m^{-3}}\\ |
| \\\small 293.4\\ \mathrm{K}\\ | \\\small 101.0 \times 10^{3}\\ \mathrm{Pa}\\ | \\\small 287.0\\ \mathrm{J\\ kg^{-1}\\ K^{-1}}\\ | \\\small 1.200\\ \mathrm{kg\\ m^{-3}}\\ |
| \\\small 293.9\\ \mathrm{K}\\ | \\\small 101.1 \times 10^{3}\\ \mathrm{Pa}\\ | \\\small 287.0\\ \mathrm{J\\ kg^{-1}\\ K^{-1}}\\ | \\\small 1.199\\ \mathrm{kg\\ m^{-3}}\\ |

Example 18. {.table}

  

*Placing units in the table header.*   An alternate convention is to
include the units in the header row only. Here we start with a data
frame with unit-class columns.

``` r

# Example 19.
y <- copy(DT)
```

First we preserve the columns names and associated measurement units.

``` r

# Preserve column names
col_names <- names(y)
col_names
#> [1] "temp"   "pres"   "sp_gas" "dens"

# Preserve units and surround by square brackets for display
unit_list <- sapply(y, units::deparse_unit)
unit_list <- paste0("[", unit_list, "]")
unit_list
#> [1] "[K]"          "[Pa]"         "[J kg-1 K-1]" "[kg m-3]"
```

Drop the units from the numerical columns and format the columns in the
usual way.

``` r

# Drop units from values
y <- units::drop_units(y)

# Format numerical columns
y$temp <- format_dcml(y$temp)
y$pres <- format_engr(y$pres)
cols <- c("sp_gas", "dens")
y[, (cols) := lapply(.SD, format_dcml), .SDcols = cols]
```

Use [`knitr::kable()`](https://rdrr.io/pkg/knitr/man/kable.html) and
[`kableExtra::add_header_above()`](https://rdrr.io/pkg/kableExtra/man/add_header_above.html)
to create a two-level header with column names and units.

``` r

knitr::kable(y,
  caption = "Example 19.",
  col.names = unit_list,
  align = "r"
) |>
  kableExtra::add_header_above(header = col_names, line = FALSE, align = "r")
```

[TABLE]

Example 19. {.table}

  

*Formatting units in the header.*   In the table above, the row of units
is adequate, but the implicit exponents might be confusing to some
readers. In this next example, we use formatdown to typeset exponents as
superscripts, for example, `[J K-1 kg-1]` becomes
\\\small\left(\mathrm{J\\ K^{-1}\\ kg^{-1}}\right)\\.

We start by extracting the first row of the data table, formatting each
column using
[`format_numbers()`](https://graphdr.github.io/formatdown/reference/format_numbers.md),
then removing the numerical characters leaving only the math-markup
units characters.

``` r

# Example 20.
unit_row <- DT[1]
unit_row
#>         temp        pres         sp_gas           dens
#>      <units>     <units>        <units>        <units>
#> 1: 294.1 [K] 101100 [Pa] 287 [J/(kg*K)] 1.198 [kg/m^3]

# By columns, remove numbers, retain formatted units
for (jj in names(unit_row)) {
  # Select column
  q <- unit_row[, get(jj)]
  # Format the number with its units
  q <- format_numbers(q)
  # Regular expression to identify characters between the $ sign and \\mathrm
  regex <- "(?<=\\$).*?(?=\\\\mathrm)"
  # Remove those characters, leaving the formatted unit string
  unit_row[, jj] <- stringr::str_remove(q, regex)
}
# Convert the data frame row to a vector
unit_vec <- unname(unlist(unit_row[1]))
unit_vec
#> [1] "$\\mathrm{K}$"                    "$\\mathrm{Pa}$"                  
#> [3] "$\\mathrm{J\\ kg^{-1}\\ K^{-1}}$" "$\\mathrm{kg\\ m^{-3}}$"
```

Insert parentheses around the unit expressions.

``` r

# Insert parentheses just inside the math delimiters
unit_vec <- stringr::str_replace_all(unit_vec, "\\$", "")
# Add parentheses around units and reinstate the math delimiters
unit_vec <- paste0("$\\left(", unit_vec, "\\right)$")
unit_vec
#> [1] "$\\left(\\mathrm{K}\\right)$"                   
#> [2] "$\\left(\\mathrm{Pa}\\right)$"                  
#> [3] "$\\left(\\mathrm{J\\ kg^{-1}\\ K^{-1}}\\right)$"
#> [4] "$\\left(\\mathrm{kg\\ m^{-3}}\\right)$"
```

Tidy the column names and use `kableExtra()` to format the table.

``` r

# Make the column names presentable
col_names <- names(DT) |>
  stringr::str_replace("temp", "Temperature") |>
  stringr::str_replace("pres", "Pressure") |>
  stringr::str_replace("sp_gas", "Gas constant") |>
  stringr::str_replace("dens", "Density")

# Re-using the formatted data frame "y" from the previous example
# The unit vector is used for table col.name
knitr::kable(y,
  caption = "Example 20.",
  col.names = unit_vec,
  align = "r"
) |>
  # Adjust the font size
  kableExtra::kable_styling(font_size = 13) |>
  # Make the units row a slightly smaller font size
  kableExtra::row_spec(0, font_size = 11) |>
  # Add a header above the units with the variable names
  kableExtra::add_header_above(header = col_names, line = FALSE, align = "r")
```

[TABLE]

Example 20. {.table .table
style="font-size: 13px; margin-left: auto; margin-right: auto;"}

## Options

Arguments assigned using
[`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md)
are described in the [Global
settings](https://graphdr.github.io/formatdown/articles/global_settings.md)
article.

## References

Chase, M. (2021). *Technical Mathematics*.
<https://openoregon.pressbooks.pub/techmath/chapter/module-11-scientific-notation/>

Pebesma, E., Mailund, T., & Hiebert, J. (2016). Measurement units in R.
*R Journal*, *8*(2), 486–494. <https://doi.org/10.32614/RJ-2016-061>
