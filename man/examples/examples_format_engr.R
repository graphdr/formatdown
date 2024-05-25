# input: single number
x <- 6.0221E+23
format_engr(x)

# input: units class
x <- 103400
units(x) <- "N m2 C-2"
format_engr(x)

# input: vector
data("metals", package = "formatdown")
x <- metals$dens
format_engr(x)

# significant digits
x <- 9.75358e+5
format_engr(x, 2)
format_engr(x, 3)
format_engr(x, 4)

# input: data frame
x <- metals[, c("thrm_exp", "thrm_cond")]
as.data.frame(apply(x, 2, format_engr, digits = 3))

# format_engr() same as format_numbers(..., format = "engr")
x <- 6.0221E+23
format_engr(x)
format_numbers(x, format = "engr")

# omit_power
x <- 103400
format_engr(x, omit_power = c(-1, 2)) # default
format_engr(x, omit_power = c(-1, 5))
format_engr(x, omit_power = 5) # equivalent to omit_power = c(5, 5)

# omit_power = NULL, power-of-ten notation for all elements
x <- c(1.2, 103400)
format_engr(x)
format_engr(x, omit_power = NULL)

# omit_power applies to native exponent (before engr formatting)
x <- 103400
format_sci(x) # native exponent is 5
format_engr(x, omit_power = 5)

# omit_power applies to exponent after engr formatting
x <- 103400
format_engr(x) # engr exponent is 3
format_engr(x, omit_power = 3)

# set_power overrides default engineering exponent
x <- 103400
format_engr(x)
format_engr(x, set_power = 4)

# set_power overrides omit_power
x <- 103400
format_engr(x)
format_engr(x, omit_power = 3)
format_engr(x, omit_power = 3, set_power = 3)
