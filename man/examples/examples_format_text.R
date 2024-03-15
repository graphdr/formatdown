# Text vector

# default face = "plain"
x <- air_meas$humid
format_text(x)

# equivalently
format_text(x, face = "plain")

# argument coerced to character string if possible
format_text(x = NA)
format_text(x = c(TRUE, FALSE, TRUE))

# numbers as strings are rendered as-is
format_text(x = c("1.2E-3", "3.4E+0", "5.6E+3"))

# other font faces
format_text(x, face = "italic")
format_text(x, face = "bold")
format_text(x, face = "sans")
format_text(x, face = "mono")

# alternate delimiter
format_text(x, delim = "\\(")

