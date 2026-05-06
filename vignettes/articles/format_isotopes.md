# Format isotopes


|     hyphenated notation     |  nuclear notation  | nuclear notation (optional) |
|:---------------------------:|:------------------:|:---------------------------:|
| $\mathrm{C}$–$\mathrm{12}$  | $\mathrm{^{12}C}$  |    $\mathrm{^{12}_{6}C}$    |
| $\mathrm{Fe}$–$\mathrm{54}$ | $\mathrm{^{54}Fe}$ |   $\mathrm{^{54}_{26}Fe}$   |
| $\mathrm{U}$–$\mathrm{238}$ | $\mathrm{^{238}U}$ |   $\mathrm{^{238}_{92}U}$   |

In this vignette, I discuss the `format_nucl()` function for converting
isotopes from *hyphenated* notation to *nuclear* notation.

## Types of notation

In *hyphenated* notation, chemical elements are expressed,

$$\mathrm{E}{-}\mathrm{A}, $$

where *E* is the element symbol and *A* is its mass number, e.g.,
**H-1**, **H-2**, **He-3**, **He-4**, etc.

In *nuclear* notation, the element symbol has a preceding superscript
for the mass number and (optionally) a preceding subscript for the
atomic number *Z*,

$$\mathrm{^{A}E}\ \ \mathrm{or}\ \mathrm{^{A}_{Z}E}$$

For example, carbon-12 (atomic number *Z* = 6), iron-54 (*Z* = 26) and
uranium-238 (*Z* = 92) are typeset with and without atomic numbers as
shown in the table at the top of the page. The notation without *Z* is
the default in formatdown.

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

We format isotopes as inline math expressions delimited by `$ ... $` or
the optional `\( ... \)`. For example, carbon 12 is marked up as

        $\mathrm{^{12}C}$,

where the `\mathrm{}` macro creates serif, non-italic text and the carat
`^{}` creates the superscript for the mass number. Rendering this
expression in an Rmd script as a *LaTeX-style inline equation* yields:
$\mathrm{^{\small\ 12}C}$.

To *program* the markup, however, we enclose it in quote marks as a
character string, that is,

        "$\\mathrm{^{12}C}$", 

which requires us to “escape” the backslash in `\mathrm` by adding extra
backslashes. Rendering this expression in an Rmd script as an *inline R
code chunk* yields the same result: $\mathrm{^{12}C}$.

## `format_nucl()`

Denoting *E* as the element symbol (H, He, Li, Be, …) and *A* as the
mass number of its isotope, `format_nucl()` converts a string from the
hyphenated text form,

        "E-A" 

to a character string in the markup form,

        "$\\mathrm{^{A}E}$", 

If the option for including the atomic number *Z* is used, the markup
form includes the atomic number as a subscript using the underscore
macro `_{}`,

        "$\\mathrm{^{A}_{Z}E}$".

<br>

*Usage.*  

``` r
format_nucl(x,
            face  = "plain",
            ...,
            Z     = formatdown_options("Z"),
            warn = formatdown_options("warn"),
            delim = formatdown_options("delim")) 
```

- Arguments before the dots (`...`) do not have to be named if argument
  order is maintained.
- Arguments after the dots (`...`) must be named.
- The arguments assigned via `formatdown_options()` can be reset by the
  user locally in a function call or globally using
  `formatdown_options()`.

<br>

*Examples.*   Scalar values are typically rendered using inline code
chunks in an Rmd script.

``` r
# 1. Carbon-12
x <- "C-12"
format_nucl(x)
#> [1] "$\\mathrm{^{12}C}$"

# 2. Uranium-238
y <- "U-238"
format_nucl(y)
#> [1] "$\\mathrm{^{238}U}$"
```

Examples 1 and 2, included as inline code chunks, render as,

1.  $\mathrm{^{12}C}$ is the most abundant isotope of carbon.

2.  The most common isotope of naturally-occurring uranium is
    $\mathrm{^{238}U}$.

<br>

## Including the atomic numbers

To include the atomic number, we set the optional *Z* argument to TRUE.
`format_nucl()` obtains atomic numbers from the built-in `element_set`
data by matching the element abbreviation.

<br>

*Examples.*  

``` r
# 3. Carbon-12
x <- "C-12"
format_nucl(x, Z = TRUE)
#> [1] "$\\mathrm{^{12}_{6}C}$"

# 4. Uranium-238
y <- "U-238"
format_nucl(y, Z = TRUE)
#> [1] "$\\mathrm{^{238}_{92}U}$"
```

Examples 3 and 4 (in inline code chunks) render as,

3.  $\mathrm{^{12}_{6}C}$ is the most abundant isotope of carbon.

4.  The most common isotope of naturally-occurring uranium is
    $\mathrm{^{238}_{92}U}$.

<br>

The *Z* argument can also be set globally using `formatdown_options()`,
saving the effort of using the *Z* argument in every function call.

``` r
formatdown_options(Z = TRUE)

# 5. Carbon-12
format_nucl(x)
#> [1] "$\\mathrm{^{12}_{6}C}$"

# 6. Uranium-238
format_nucl(y)
#> [1] "$\\mathrm{^{238}_{92}U}$"
```

Examples 5 and 6 (in inline code chunks) render as,

5.  $\mathrm{^{12}_{6}C}$ is the most abundant isotope of carbon.

6.  The most common isotope of naturally-occurring uranium is
    $\mathrm{^{238}_{92}U}$.

<br>

To reset the default option,

``` r
# reset the Z option only
formatdown_options(Z = FALSE)
```

## Typeface

Format the same column of text using each of the five possible `face`
arguments for comparison.

``` r
# 7. Compare available typefaces
x <- c("He-4", "C-12", "Pb-204", "U-238")
plain <- format_nucl(x, face = "plain", Z = TRUE)
italic <- format_nucl(x, face = "italic", Z = TRUE)
bold <- format_nucl(x, face = "bold", Z = TRUE)
sans <- format_nucl(x, face = "sans", Z = TRUE)
mono <- format_nucl(x, face = "mono", Z = TRUE)
DT <- data.table(plain, italic, bold, sans, mono)
knitr::kable(DT, align = "l", caption = "Example 7.")
```

| plain | italic | bold | sans | mono |
|:---|:---|:---|:---|:---|
| $\mathrm{^{4}_{2}He}$ | $\mathit{^{4}_{2}He}$ | $\mathbf{^{4}_{2}He}$ | $\mathsf{^{4}_{2}He}$ | $\mathtt{^{4}_{2}He}$ |
| $\mathrm{^{12}_{6}C}$ | $\mathit{^{12}_{6}C}$ | $\mathbf{^{12}_{6}C}$ | $\mathsf{^{12}_{6}C}$ | $\mathtt{^{12}_{6}C}$ |
| $\mathrm{^{204}_{82}Pb}$ | $\mathit{^{204}_{82}Pb}$ | $\mathbf{^{204}_{82}Pb}$ | $\mathsf{^{204}_{82}Pb}$ | $\mathtt{^{204}_{82}Pb}$ |
| $\mathrm{^{238}_{92}U}$ | $\mathit{^{238}_{92}U}$ | $\mathbf{^{238}_{92}U}$ | $\mathsf{^{238}_{92}U}$ | $\mathtt{^{238}_{92}U}$ |

Example 7.

## Element data set

The package includes a data set of the 118 chemical elements with
columns for the element name, symbol, atomic number, and mass number.
Because elements may have more than one isotope with distinct mass
numbers, we list each isotope in its own row, resulting in a data frame
with 354 rows.

``` r
element_set
#>          element symbol atomic_number mass_number
#>           <char> <char>        <char>      <char>
#>   1:    Hydrogen      H             1           1
#>   2:    Hydrogen      H             1           2
#>   3:    Hydrogen      H             1           3
#>  ---                                             
#> 352: Livermorium     Lv           116         293
#> 353:  Tennessine     Ts           117         292
#> 354:   Oganesson     Og           118         294
```

View the help page for the data set by typing

``` r
    library("formatdown")  
    ? element_set  
```

*Examples.*   For example, the three isotopes of hydrogen are expressed,

``` r
# 8. Hydrogen isotopes
x <- c("H-1", "H-2", "H-3")
format_nucl(x, Z = TRUE)
#> [1] "$\\mathrm{^{1}_{1}H}$" "$\\mathrm{^{2}_{1}H}$" "$\\mathrm{^{3}_{1}H}$"
```

Example 8 renders as: $\mathrm{^{1}_{1}H}$, $\mathrm{^{2}_{1}H}$,
$\mathrm{^{3}_{1}H}$

<br>

**Hyphenated input-error warning.**   Hyphenated inputs are checked by
comparing them to the values in the `symbol` and `mass-value` columns in
`element_set`. If the hyphenated input “E-A” contains an error in the
element abbreviation “E” or the mass number “A”, a warning is issued—but
the input is still formatted.

*Examples.*  

Here, the first entry has an incorrect element symbol and the second has
an incorrect mass number.

``` r
# 9. Input errors
x <- c("Carbon-12", "C-40", "C-12")
format_nucl(x)
#> Warning in format_nucl(x): Incorrect chemical symbol or mass number in
#> c("Carbon-12", "C-40")
#> [1] "$\\mathrm{^{12}Carbon}$" "$\\mathrm{^{40}C}$"     
#> [3] "$\\mathrm{^{12}C}$"
```

Example 9 renders as $\mathrm{^{12}Carbon}$, $\mathrm{^{40}C}$,
$\mathrm{^{12}C}$

If we use the atomic number argument, the letter *Z* is placed in the
subscript.

``` r
# 10. Symbol for atomic number
format_nucl(x, Z = TRUE)
#> Warning in format_nucl(x, Z = TRUE): Incorrect chemical symbol or mass number
#> in c("Carbon-12", "C-40")
#> [1] "$\\mathrm{^{12}_{Z}Carbon}$" "$\\mathrm{^{40}_{Z}C}$"     
#> [3] "$\\mathrm{^{12}_{6}C}$"
```

Example 10 renders as $\mathrm{^{12}_{Z}Carbon}$, $\mathrm{^{40}_{Z}C}$,
$\mathrm{^{12}_{6}C}$

The third entry of the output vector is correctly formatted. The “Z”
subscript in the other two entries is a hint (in addition to the
warning) that the hyphenated input contains errors.

<br>

**Other input errors.**   Other input errors, such as having no hyphen
or more than one hyphen in the input, creates an error message and
nothing is formatted.

<br>

**Notating a general form.**   Because `format_nucl()` will format any
character string with a single hyphen between two character strings, we
can use it to typeset the isotope general form such as $\mathrm{^{A}E}$.
In such a case, we turn off the warning using the `warn` argument.

*Examples.*  

``` r
# 11. General nuclear form
x <- c("E-A")
format_nucl(x, warn = FALSE)
#> [1] "$\\mathrm{^{A}E}$"
```

Example 11 renders as: $\mathrm{^{A}E}$

As noted earlier, the usual `Z` argument in this case places a *Z* in
the subscript position.

``` r
# 12. General nuclear form with atomic number symbol
x <- c("E-A")
format_nucl(x, Z = TRUE, warn = FALSE)
#> [1] "$\\mathrm{^{A}_{Z}E}$"
```

Example 12 renders as: $\mathrm{^{A}_{Z}E}$

Some authors prefer using *X* for the general element symbol,

``` r
# 13. Alternate general form.
x <- c("X-A")
format_nucl(x, Z = TRUE, warn = FALSE)
#> [1] "$\\mathrm{^{A}_{Z}X}$"
```

Example 13 renders as: $\mathrm{^{A}_{Z}X}$

## Inputs

*Scalars.*   Generally used with inline R code. For example, the
following R markdown sentence, which includes some inline R code,

``` default
    The most common isotope of Germanium is `r format_nucl("Ge-74")` with a
    naturally occurring frequency of 36% though `r format_nucl("Ge-72")` is
    a close second at 28%.
```

renders as:

> The most common isotope of Germanium is $\mathrm{^{74}Ge}$ with a
> naturally occurring frequency of 36% though $\mathrm{^{72}Ge}$ is a
> close second at 28%.

<br>

*Vector.*   A vector of isotopes in hyphenated form (or a data frame
column) is marked up as follows,

*Examples.*  

``` r
# 14. Sample vector
x <- c("H-1", "H-2", "He-3", "He-4", "Li-6", "Li-7", "Be-9")
format_nucl(x)
#> [1] "$\\mathrm{^{1}H}$"  "$\\mathrm{^{2}H}$"  "$\\mathrm{^{3}He}$"
#> [4] "$\\mathrm{^{4}He}$" "$\\mathrm{^{6}Li}$" "$\\mathrm{^{7}Li}$"
#> [7] "$\\mathrm{^{9}Be}$"
```

In a table, the output can be rendered as,

``` r
DT <- data.table(x, format_nucl(x))
knitr::kable(DT,
  align = "c",
  col.names = c("Hyphenated form", "Nuclear notation"),
  caption = "Example 14."
)
```

| Hyphenated form | Nuclear notation  |
|:---------------:|:-----------------:|
|       H-1       | $\mathrm{^{1}H}$  |
|       H-2       | $\mathrm{^{2}H}$  |
|      He-3       | $\mathrm{^{3}He}$ |
|      He-4       | $\mathrm{^{4}He}$ |
|      Li-6       | $\mathrm{^{6}Li}$ |
|      Li-7       | $\mathrm{^{7}Li}$ |
|      Be-9       | $\mathrm{^{9}Be}$ |

Example 14.

<br>

Adding atomic numbers yields,

``` r
# 15. Table with Z
DT <- data.table(x, format_nucl(x, Z = TRUE))
knitr::kable(DT,
  align = "c",
  col.names = c("Hyphenated form", "Nuclear notation"),
  caption = "Example 15."
)
```

| Hyphenated form |   Nuclear notation    |
|:---------------:|:---------------------:|
|       H-1       | $\mathrm{^{1}_{1}H}$  |
|       H-2       | $\mathrm{^{2}_{1}H}$  |
|      He-3       | $\mathrm{^{3}_{2}He}$ |
|      He-4       | $\mathrm{^{4}_{2}He}$ |
|      Li-6       | $\mathrm{^{6}_{3}Li}$ |
|      Li-7       | $\mathrm{^{7}_{3}Li}$ |
|      Be-9       | $\mathrm{^{9}_{4}Be}$ |

Example 15.

<br>

## Options

Arguments assigned using `formatdown_options()` are described in the
[Global settings](global_settings.html) article.
