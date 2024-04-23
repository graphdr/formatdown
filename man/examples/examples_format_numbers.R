# Single number
format_numbers(101100, digits = 4, format = "engr")

# Vector of numbers
x <- c(1.2222e-06, 3.4444e-04, 6.3333e-01, 8.1111e+01, 2.4444e+04, 9.123e+7)
format_numbers(x)

# Columns of a data frame
y <- x[1:3]
z <- x[4:6]
df <- data.frame(y, z)
apply(df, 2, format_numbers, digits = 3, format = "sci")

# Compare significant digits
format_numbers(x[1], 3)
format_numbers(x[1], 4)
format_numbers(x[4], 2, "dcml")
format_numbers(x[4], 3, "dcml")

# Compare format type
format_numbers(x[2], format = "dcml")
format_numbers(x[2], format = "sci")
format_numbers(x[2], format = "engr")

# Compare omit_power range
format_numbers(x[3], omit_power = c(-1, 2))
format_numbers(x[3], omit_power = c(0, 2))
format_numbers(x[4])
format_numbers(x[4], omit_power = c(-Inf, Inf))
format_numbers(x[4], omit_power = NULL)

# Compare set_power results
format_numbers(x[2], set_power = -5)
format_numbers(x[2], set_power = -4)
format_numbers(x[2], set_power = -3)
