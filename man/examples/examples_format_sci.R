# input: single number
x <- 6.0221E+23
format_sci(x)

# input: units class
x <- 103400
units(x) <- "N m2 C-2"
format_sci(x)

# input: vector
data("metals", package = "formatdown")
x <- metals$dens
format_sci(x)

# significant digits
x <- 9.75358e+5
format_sci(x, 2)
format_sci(x, 3)
format_sci(x, 4)

# input: data frame
x <- metals[, c("thrm_exp", "thrm_cond")]
as.data.frame(apply(x, 2, format_sci, digits = 3))

# format_sci() same as format_numbers(..., format = "sci")
x <- 6.0221E+23
format_sci(x)
format_numbers(x, format = "sci")

# omit_power
x <- 103400
format_sci(x, omit_power = c(-1, 2)) # default
format_sci(x, omit_power = c(-1, 5))
format_sci(x, omit_power = 5) # equivalent to omit_power = c(5, 5)

# omit_power = NULL, power-of-ten notation for all elements
x <- c(1.2, 103400)
format_sci(x)
format_sci(x, omit_power = NULL)

# set_power overrides default scientific exponent
x <- 103400
format_sci(x)
format_sci(x, set_power = 4)

# set_power overrides omit_power
x <- 103400
format_sci(x)
format_sci(x, omit_power = 5)
format_sci(x, omit_power = 5, set_power = 4)
