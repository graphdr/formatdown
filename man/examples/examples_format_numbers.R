# Scalar value
format_numbers(101100, digits = 4)

# Vector value
x <- c(1.2222e-6, 2.3333e-5, 3.4444e-4, 4.1111e-3, 5.2222e-2, 6.3333e-1,
       7.4444e+0, 8.1111e+1, 9.2222e+2, 1.3333e+3, 2.4444e+4, 3.1111e+5, 4.2222e+6)
format_numbers(x)

# Compare significant digits
format_numbers(x[1], 3)
format_numbers(x[1], 4)

# Compare format type
format_numbers(x[3], format = "dcml")
format_numbers(x[3], format = "sci")
format_numbers(x[3], format = "engr")

# Compare set_power results
format_numbers(x[3], set_power = -5)
format_numbers(x[3], set_power = -4)
format_numbers(x[3], set_power = -3)

# Compare omit_power range
format_numbers(x[6], omit_power = c(-1, 2))
format_numbers(x[6], omit_power = c(0, 2))
format_numbers(x[8])
format_numbers(x[8], omit_power = c(-Inf, Inf))
format_numbers(x[8], omit_power = NULL)

# Apply to columns of a data frame
y <- x[1:6]
z <- x[8:13]
df <- data.frame(y, z)
apply(df, 2, format_numbers, digits = 3)

# Convenience functions
format_dcml(x[11], 3)
format_sci(x[11], 3)
format_engr(x[11], 3)

# With digit grouping
format_numbers(x[11], 3, "dcml", big_mark = "\\\\,")
format_numbers(x[1], 3, "dcml", small_mark = "\\\\,")
