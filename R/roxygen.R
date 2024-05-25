# R code used for documentation

param_x <- 'Number or numbers to be formatted. Can be a single number, a vector,
        or a column of a data frame.'

param_digits <- 'Integer from 1 through 20 that controls the number of
        significant digits in printed numeric values. Passed to `signif()`.
        Default is 4.'

param_format <- 'Character, length 1, defines the type of notation. Possible
        values are `"engr"` (default) for engineering power-of-ten notation,
        `"sci"` for scientific power-of-ten notation, and `"dcml"` for decimal
        notation.'

param_dots <- 'Not used for values; forces subsequent arguments to be
        referable only by name.'

param_omit_power <- 'Numeric vector `c(p, q)` with `p <= q`, specifying
        the range of exponents over which power-of-ten notation is omitted in
        either scientific or engineering format. Default is
        `c(-1, 2)`. If a single value is assigned, i.e., `omit_power = p`, the
        argument is interpreted as `c(p, p)`. If `NULL` or `NA`, all elements
        are formatted in power-of-ten notation. Argument is overridden by
        specifying `set_power` or decimal notation.'

param_set_power <- 'Integer, length 1. Formats all values in `x` with the same
        power-of-ten exponent. Default NULL. Overrides `format` and `omit_power`
        arguments.'

param_delim <- 'Character, length 1 or 2, to define the left and right math
        markup delimiters. The default setting, `delim = "$"`, produces
        left and right delimiters `$...$`. The alternate built-in
        setting, `delim = "\\\\("`, produces left and right delimiters
        `\\\\( ... \\\\)`. Custom delimiters can be assigned in a vector of
        length 2 with left and right delimiter symbols, e.g.,
        `c("\\\\[", "\\\\]")`. Special characters typically must be escaped.'

param_size <- 'Character, length 1, to assign a font size. If not empty, adds
        a font size macro to the markup inside the math delimiters. Possible
        values are `"scriptsize"`, `"small"`, `"normalsize"`, `"large"`, and
        `"huge"`. One may also assign the equivalent LaTeX-style markup itself,
        e.g., `"\\\\scriptsize"`, `"\\\\small"`, etc. Default is NULL.'

param_decimal_mark <- 'Character, length 1, to assign the decimal marker.
        Possible values are a period `"."` (default) or a comma `","`. Passed
        to `formatC(decimal.mark)`.'

param_big_mark <- 'Character, length 1, used as the mark between every
        `big_interval` number of digits to the left of the decimal marker to
        improve readability. Possible values are empty `""` (default) or
        `"thin"` to produce a LaTeX-style thin, horizontal space. One may also
        assign the thin-space markup itself `"\\\\\\\\,"`.
        Passed to `formatC(big.mark)`.'

param_big_interval <- 'Integer, length 1, that defines the number of digits
        (default 3) in groups separated by `big_mark`. Passed to
        `formatC(big.interval)`.'

param_small_mark <- 'Character, length 1, used as the mark between every
        `small_interval` number of digits to the right of the decimal marker to
        improve readability. Possible values are empty `""` (default) or
        `"thin"` to produce a LaTeX-style thin, horizontal space. One may also
        assign the thin-space markup itself `"\\\\\\\\,"`.
        Passed to `formatC(small.mark)`.'

param_small_interval <- 'Integer, length 1, that defines the number of digits
        (default 5) in groups separated by `small_mark`. Passed to
        `formatC(small.interval)`.'

param_whitespace <- 'Character, length 1, to define the LaTeX-style
      math-mode macro to preserve a horizontal space between words of text or
      between physical-unit abbreviations when formatting numbers of class
      "units". Default is `"\\\\\\\\ "`. Alternatives include `"\\\\\\\\:"` or
        "`\\\\\\\\>`".'



