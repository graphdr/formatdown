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

# omit_power
x <- 103400
format_engr(x, omit_power = c(-1, 2)) # default
format_engr(x, omit_power = c(-1, 5))
format_engr(x, omit_power = 5) # equivalent to omit_power = c(5, 5)
x <- 1.2
format_engr(x, omit_power = NULL)

# set_power
format_engr(x, set_power = NULL) # default
format_engr(x, set_power = 3)

# set_power overrides format
x <- 6.0221E+23
format_engr(x)
format_engr(x, set_power = 24L)

# set_power overrides omit_power
x <- 101300
format_engr(x, omit_power = 5)
format_engr(x, omit_power = 5, set_power = 2)
format_engr(x, omit_power = 2)
format_engr(x, omit_power = 2, set_power = 2)


