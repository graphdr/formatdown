# Show all options
formatdown_options()

# Store existing settings, including any changes made by the user
old_settings <- formatdown_options()

# View one option
formatdown_options()$delim

# View multiple options
formatdown_options("size", "delim")

# Change options
formatdown_options(size = "small", delim = "\\(")
formatdown_options("size", "delim")

# Reset to default values
formatdown_options(reset = TRUE)
formatdown_options("size", "delim")

# Reset options to those before this example was run
do.call(formatdown_options, old_settings)

# Option effects

# delim
x <- 101300
format_dcml(x)
# equivalent to
format_dcml(x, delim = c("$", "$"))
# built-in alternate
format_dcml(x, delim = "\\(")
# equivalent to
format_dcml(x, delim = c("\\(", "\\)"))

# size
format_dcml(x, size = "small")
# equivalent to
format_dcml(x, size = "\\small")
# other possible values
format_dcml(x, size = "scriptsize")
format_dcml(x, size = "large")
format_dcml(x, size = "huge")
# default NULL
format_dcml(x, size = NULL)
# renders equivalent to
format_dcml(x, size = "normalsize")

# decimal_mark
y <- 6.02214076E+10
format_sci(y, 5, decimal_mark = ".")
format_sci(y, 5, decimal_mark = ",")

# big_mark
format_dcml(y, 9)
format_dcml(y, 9, big_mark = "thin")
# equivalent to
format_dcml(y, 9, big_mark = "\\\\,")

# big_interval
format_dcml(y, 9, big_mark = "thin", big_interval = 3)
format_dcml(y, 9, big_mark = "thin", big_interval = 5)

# small_mark
z <- 1.602176634e-8
format_sci(z, 10)
format_sci(z, 10, small_mark = "thin")
format_sci(z, 10, small_mark = "\\\\,")
format_engr(z, 10, small_mark = "thin")

# small_interval
format_sci(z, 10, small_mark = "thin", small_interval = 3)
format_sci(z, 10, small_mark = "thin", small_interval = 5)
format_engr(z, 10, small_mark = "thin", small_interval = 5)

# whitespace in text
p <- "Hello world!"
format_text(p)
# equivalent to
format_text(p, whitespace = "\\\\ ")
# alternates
format_text(p, whitespace = "\\\\:")
format_text(p, whitespace = "\\\\>")

# whitespace in physical units expression
x <- pi
units(x) <- "m/s"
format_dcml(x)
# equivalent to
format_dcml(x, whitespace = "\\\\ ")

# multiply_mark
x <- 101300
format_engr(x, decimal_mark = ".", multiply_mark = "\\times")
format_engr(x, decimal_mark = ",", multiply_mark = "\\cdot")
