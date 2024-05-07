# input: single number
x <- 6.0221E+23
format_numbers(x)

# input: units class
x <- 103400
units(x) <- "N m2 C-2"
format_numbers(x)

# input: vector
data("metals", package = "formatdown")
x <- metals$dens
format_numbers(x)

# significant digits
x <- 9.75358e+5
format_numbers(x, 2)
format_numbers(x, 3)
format_numbers(x, 4)

# format & wrappers: format_engr(), format_sci(), format_dcml()
x <- 6.0221E+23
format_numbers(x, format = "engr")
format_engr(x)

format_numbers(x, format = "sci")
format_sci(x)

x <- 103400
format_numbers(x, format = "dcml")
format_dcml(x)

# input: data frame
x <- metals[, c("thrm_exp", "thrm_cond")]
as.data.frame(apply(x, 2, format_sci, digits = 3))

# omit_power
x <- 103400
format_sci(x, omit_power = c(-1, 2)) # default
format_sci(x, omit_power = c(-1, 5))
format_sci(x, omit_power = 5) # equivalent to omit_power = c(5, 5)
x <- 1.2
format_sci(x, omit_power = NULL)

# set_power
format_sci(x, set_power = NULL) # default
format_sci(x, set_power = 3)

# set_power overrides format
x <- 6.0221E+23
format_engr(x)
format_engr(x, set_power = 24L)
format_sci(x)
format_sci(x, set_power = 24L)

# set_power overrides omit_power
x <- 101300
format_sci(x, omit_power = 5)
format_sci(x, omit_power = 5, set_power = 2)
format_sci(x, omit_power = 2)
format_sci(x, omit_power = 2, set_power = 2)

# decimal format ignores set_power
x <- 103400
format_numbers(x, format = "dcml")
format_numbers(x, format = "dcml", set_power = 3)

