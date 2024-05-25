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

# input: data frame
x <- metals[, c("thrm_exp", "thrm_cond")]
as.data.frame(apply(x, 2, format_sci, digits = 3))

# omit_power
x <- 103400
format_numbers(x, format = "sci", omit_power = c(-1, 2)) # default
format_numbers(x, format = "sci", omit_power = c(-1, 5))
format_numbers(x, format = "sci", omit_power = 5) # equivalent to omit_power = c(5, 5)

# omit_power = NULL, power-of-ten notation for all elements
x <- c(1.2, 103400)
format_numbers(x, format = "sci")
format_numbers(x, format = "sci", omit_power = NULL)

# set_power overrides default scientific exponent
x <- 103400
format_numbers(x, format = "sci")
format_numbers(x, format = "sci", set_power = 4)

# set_power overrides omit_power
x <- 103400
format_numbers(x, format = "sci")
format_numbers(x, format = "sci", omit_power = 5)
format_numbers(x, format = "sci", omit_power = 5, set_power = 4)

# decimal format overrides set_power
x <- 103400
format_numbers(x, format = "dcml")
format_numbers(x, format = "dcml", set_power = 3)

