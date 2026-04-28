# Format isotopes

In this vignette, I discuss the
[`format_nucl()`](https://graphdr.github.io/formatdown/reference/format_nucl.md)
function for converting isotopes from *hyphenated* notation to *nuclear*
notation.

## Types of notation

In *hyphenated* notation, chemical elements are expressed,

\$\$ \small\mathrm{E}{-}\small\mathrm{A}, \$\$

where *E* is the element symbol and *A* is its mass number, e.g.,
**H-1**, **H-2**, **He-3**, **He-4**, etc.

In *nuclear* notation, the element symbol has a preceding superscript
for the mass number and (optionally) a preceding subscript for the
atomic number *Z*,

\$\$ \mathrm{^{\small\\ A}E}\\ \\ \mathrm{or}\\ \mathrm{^{\small\\
A}\_{\small\\ Z}E} \$\$

For example, carbon 12 (atomic number 6) and uranium 235 (atomic number
92) are typeset with and without atomic numbers as shown below. The
latter form, without *Z*, is the default in formatdown.

| hyphenated | nuclear (with Z) | nuclear (omit Z) |
|:--:|:--:|:--:|
| \$\small\mathrm{C}\$–\$\small\mathrm{12}\$ | \$\mathrm{^{\small\\ 12}\_{\small\\ 6}C}\$ | \$\mathrm{^{\small\\ 12}C}\$ |
| \$\small\mathrm{U}\$–\$\small\mathrm{235}\$ | \$\mathrm{^{\small\\ 235}\_{\small\\ 92}U}\$ | \$\mathrm{^{\small\\ 235}U}\$ |

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

        \(\mathrm{^{\small\ 12}C}\),

where the `\mathrm{}` macro creates serif, non-italic text, the carat
(`^{}`) creates the superscript for the mass number, the `\small` macro
reduces the font size of the superscript, and the space macro (`\_`)
separates the small macro from the mass number. Rendering this
expression in an Rmd script as a *LaTeX-style inline equation* yields:
\$\mathrm{^{\small\\ 12}C}\$.

To *program* the markup, however, we enclose it in quote marks as a
character string, that is,

        "\\(\\mathrm{^{\\small\\ 12}C}\\)", 

which requires us to “escape” the backslash in `\mathrm`, `\small`,
etc., by adding extra backslashes. Rendering this expression in an Rmd
script as an *inline R code chunk* yields the same result:
\$\mathrm{^{\small\\ 12}C}\$.

## `format_nucl()`

Denoting *E* as the element symbol (H, He, Li, Be, …) and *A* as the
mass number of its isotope,
[`format_nucl()`](https://graphdr.github.io/formatdown/reference/format_nucl.md)
converts a string from the hyphenated text form,

        "E-A" 

to a character string in the markup form,

        "\\(\\mathrm{^{\\small\\ A}E}\\)", 

If the option for including the atomic number *Z* is used, the markup
form includes the atomic number as a subscript using the underscore
macro (`_{}`),

        "\\(\\mathrm{^{\\small\\ A}_{\\small\\ Z}E}\\)".

  

*Usage.*  

``` r

format_nucl(x,
            face  = "plain",
            ...,
            Z     = formatdown_options("Z"),
            warn = formatdown_options("warn"),
            delim = formatdown_options("delim")) 
```

- Arguments before the dots do not have to be named if argument order is
  maintained. Arguments after the dots (`...`) must be named.
- The arguments assigned via
  [`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md)
  can be reset by the user locally in a function call or globally using
  [`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md).
- Returns a vector

  

*Examples.*   Scalar and vector examples are usually rendered using
inline code chunks in an Rmd script.

``` r

# 1. Carbon-12
x <- "C-12"
format_nucl(x)
#> [1] "\\(\\mathrm{^{\\small\\ 12}C}\\)"
```

Example 1 renders as: \$\mathrm{^{\small\\ 12}C}\$.

``` r

# 2. Uranium-235
y <- "U-235"
format_nucl(y)
#> [1] "\\(\\mathrm{^{\\small\\ 235}U}\\)"
```

Example 2 renders as: \$\mathrm{^{\small\\ 235}U}\$

  

## Including the atomic numbers

To include the atomic number (automatically obtained from a built-in
data set), we can set the optional *Z* argument to TRUE.

``` r

# 3. Carbon-12
format_nucl(x, Z = TRUE)
#> [1] "\\(\\mathrm{^{\\small\\ 12}_{\\small\\ 6}C}\\)"
```

Example 3 renders as: \$\mathrm{^{\small\\ 12}\_{\small\\ 6}C}\$

``` r

# 4. Uranium-235
format_nucl(y, Z = TRUE)
#> [1] "\\(\\mathrm{^{\\small\\ 235}_{\\small\\ 92}U}\\)"
```

Example 4 renders as: \$\mathrm{^{\small\\ 235}\_{\small\\ 92}U}\$

  

The *Z* argument can also be set globally using
[`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md),
saving the effort of using the *Z* argument in every function call.

``` r

formatdown_options(Z = TRUE)

# 5. Carbon-12
format_nucl(x)
```

Example 5 renders as: \$\mathrm{^{\small\\ 12}\_{\small\\ 6}C}\$

``` r

# 6. Uranium-235
format_nucl(y)
```

Example 6 renders as: \$\mathrm{^{\small\\ 235}\_{\small\\ 92}U}\$

  

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
x <- c("He-4", "C-12", "Pb-204", "U-235")
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
| \$\mathrm{^{\small\\ 4}\_{\small\\ 2}He}\$ | \$\mathit{^{\small\\ 4}\_{\small\\ 2}He}\$ | \$\mathbf{^{\small\\ 4}\_{\small\\ 2}He}\$ | \$\mathsf{^{\small\\ 4}\_{\small\\ 2}He}\$ | \$\mathtt{^{\small\\ 4}\_{\small\\ 2}He}\$ |
| \$\mathrm{^{\small\\ 12}\_{\small\\ 6}C}\$ | \$\mathit{^{\small\\ 12}\_{\small\\ 6}C}\$ | \$\mathbf{^{\small\\ 12}\_{\small\\ 6}C}\$ | \$\mathsf{^{\small\\ 12}\_{\small\\ 6}C}\$ | \$\mathtt{^{\small\\ 12}\_{\small\\ 6}C}\$ |
| \$\mathrm{^{\small\\ 204}\_{\small\\ 82}Pb}\$ | \$\mathit{^{\small\\ 204}\_{\small\\ 82}Pb}\$ | \$\mathbf{^{\small\\ 204}\_{\small\\ 82}Pb}\$ | \$\mathsf{^{\small\\ 204}\_{\small\\ 82}Pb}\$ | \$\mathtt{^{\small\\ 204}\_{\small\\ 82}Pb}\$ |
| \$\mathrm{^{\small\\ 235}\_{\small\\ 92}U}\$ | \$\mathit{^{\small\\ 235}\_{\small\\ 92}U}\$ | \$\mathbf{^{\small\\ 235}\_{\small\\ 92}U}\$ | \$\mathsf{^{\small\\ 235}\_{\small\\ 92}U}\$ | \$\mathtt{^{\small\\ 235}\_{\small\\ 92}U}\$ |

Example 7. {.table}

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
#>   4:      Helium     He             2           3
#>   5:      Helium     He             2           4
#>  ---                                             
#> 350:   Flerovium     Fl           114         289
#> 351:   Moscovium     Mc           115         288
#> 352: Livermorium     Lv           116         293
#> 353:  Tennessine     Ts           117         292
#> 354:   Oganesson     Og           118         294
```

View the help page for the data set by typing

``` r

    library("formatdown")  
    ? element_set  
```

For example, the three isotopes of hydrogen are expressed,

``` r

# 8. Hydrogen isotopes
x <- c("H-1", "H-2", "H-3")
format_nucl(x, Z = TRUE)
#> [1] "\\(\\mathrm{^{\\small\\ 1}_{\\small\\ 1}H}\\)"
#> [2] "\\(\\mathrm{^{\\small\\ 2}_{\\small\\ 1}H}\\)"
#> [3] "\\(\\mathrm{^{\\small\\ 3}_{\\small\\ 1}H}\\)"
```

Example 8 renders as: \$\mathrm{^{\small\\ 1}\_{\small\\ 1}H}\$,
\$\mathrm{^{\small\\ 2}\_{\small\\ 1}H}\$, \$\mathrm{^{\small\\
3}\_{\small\\ 1}H}\$

  

**Warning of input errors.**   The data set of isotopes is also used to
warn of the following input errors:

- hyphenated input symbol fails to match a standard element symbol
- hyphenated mass number fails to match a known isotope

In this example, the first entry has an incorrect element symbol and the
second has an incorrect mass number.

``` r

# 9. Input errors
x <- c("Carbon-12", "C-40", "C-12")
format_nucl(x)
#> Warning in format_nucl(x): Incorrect chemical symbol or mass number in
#> c("Carbon-12", "C-40")
#> [1] "\\(\\mathrm{^{\\small\\ 12}Carbon}\\)"
#> [2] "\\(\\mathrm{^{\\small\\ 40}C}\\)"     
#> [3] "\\(\\mathrm{^{\\small\\ 12}C}\\)"
```

Example 9 renders as \$\mathrm{^{\small\\ 12}Carbon}\$,
\$\mathrm{^{\small\\ 40}C}\$, \$\mathrm{^{\small\\ 12}C}\$

If we use the atomic number argument, the letter *Z* is placed in the
subscript.

``` r

# 10. Symbol for atomic number
format_nucl(x, Z = TRUE)
#> Warning in format_nucl(x, Z = TRUE): Incorrect chemical symbol or mass number
#> in c("Carbon-12", "C-40")
#> [1] "\\(\\mathrm{^{\\small\\ 12}_{\\small\\ Z}Carbon}\\)"
#> [2] "\\(\\mathrm{^{\\small\\ 40}_{\\small\\ Z}C}\\)"     
#> [3] "\\(\\mathrm{^{\\small\\ 12}_{\\small\\ 6}C}\\)"
```

Example 10 renders as \$\mathrm{^{\small\\ 12}\_{\small\\ Z}Carbon}\$,
\$\mathrm{^{\small\\ 40}\_{\small\\ Z}C}\$, \$\mathrm{^{\small\\
12}\_{\small\\ 6}C}\$

The third entry of the output vector is correctly formatted. The “Z”
subscript in the other two entries is a hint (in addition to the
warning) that the hyphenated input contains errors.

  

**Notating a general form.**   That an unrecognized input in hyphenated
form is still formatted allows us to create a nuclear notation is
general form. In such a case, we can turn off the warning using the
`warn` argument.

``` r

# 11. General nuclear form
x <- c("E-A")
format_nucl(x, warn = FALSE)
#> [1] "\\(\\mathrm{^{\\small\\ A}E}\\)"
```

Example 11 renders as: \$\mathrm{^{\small\\ A}E}\$

As noted earlier, the usual `Z` argument in this case places a *Z* in
the subscript position.

``` r

# 12. General nuclear form with atomic number symbol
x <- c("E-A")
format_nucl(x, Z = TRUE, warn = FALSE)
#> [1] "\\(\\mathrm{^{\\small\\ A}_{\\small\\ Z}E}\\)"
```

Example 12 renders as: \$\mathrm{^{\small\\ A}\_{\small\\ Z}E}\$

Some authors prefer using *X* for the general element symbol,

``` r

# 13. Alternate general form.
x <- c("X-A")
format_nucl(x, Z = TRUE, warn = FALSE)
#> [1] "\\(\\mathrm{^{\\small\\ A}_{\\small\\ Z}X}\\)"
```

Example 13 renders as: \$\mathrm{^{\small\\ A}\_{\small\\ Z}X}\$

## Inputs

*Scalars.*   Generally used with inline R code. For example, the
following R markdown sentence, which includes some inline R code,

``` default
    The most common isotope of Germanium is `r format_nucl("Ge-74")` with a
    naturally occurring frequency of 36% though `r format_nucl("Ge-72")` is
    a close second at 28%.
```

renders as:

> The most common isotope of Germanium is \$\mathrm{^{\small\\ 74}Ge}\$
> with a naturally occurring frequency of 36% though
> \$\mathrm{^{\small\\ 72}Ge}\$ is a close second at 28%.

  

*Vector.*   A vector of isotopes in hyphenated form (or a data frame
column) is marked up as follows,

``` r

# 14. Sample vector
x <- c("H-1", "H-2", "He-3", "He-4", "Li-6", "Li-7", "Be-9")
format_nucl(x)
#> [1] "\\(\\mathrm{^{\\small\\ 1}H}\\)"  "\\(\\mathrm{^{\\small\\ 2}H}\\)" 
#> [3] "\\(\\mathrm{^{\\small\\ 3}He}\\)" "\\(\\mathrm{^{\\small\\ 4}He}\\)"
#> [5] "\\(\\mathrm{^{\\small\\ 6}Li}\\)" "\\(\\mathrm{^{\\small\\ 7}Li}\\)"
#> [7] "\\(\\mathrm{^{\\small\\ 9}Be}\\)"
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

| Hyphenated form |       Nuclear notation       |
|:---------------:|:----------------------------:|
|       H-1       | \$\mathrm{^{\small\\ 1}H}\$  |
|       H-2       | \$\mathrm{^{\small\\ 2}H}\$  |
|      He-3       | \$\mathrm{^{\small\\ 3}He}\$ |
|      He-4       | \$\mathrm{^{\small\\ 4}He}\$ |
|      Li-6       | \$\mathrm{^{\small\\ 6}Li}\$ |
|      Li-7       | \$\mathrm{^{\small\\ 7}Li}\$ |
|      Be-9       | \$\mathrm{^{\small\\ 9}Be}\$ |

Example 14. {.table}

  

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

| Hyphenated form |              Nuclear notation              |
|:---------------:|:------------------------------------------:|
|       H-1       | \$\mathrm{^{\small\\ 1}\_{\small\\ 1}H}\$  |
|       H-2       | \$\mathrm{^{\small\\ 2}\_{\small\\ 1}H}\$  |
|      He-3       | \$\mathrm{^{\small\\ 3}\_{\small\\ 2}He}\$ |
|      He-4       | \$\mathrm{^{\small\\ 4}\_{\small\\ 2}He}\$ |
|      Li-6       | \$\mathrm{^{\small\\ 6}\_{\small\\ 3}Li}\$ |
|      Li-7       | \$\mathrm{^{\small\\ 7}\_{\small\\ 3}Li}\$ |
|      Be-9       | \$\mathrm{^{\small\\ 9}\_{\small\\ 4}Be}\$ |

Example 15. {.table}

  

## Options

Arguments assigned using
[`formatdown_options()`](https://graphdr.github.io/formatdown/reference/formatdown_options.md)
are described in the [Global
settings](https://graphdr.github.io/formatdown/articles/global_settings.md)
article.
