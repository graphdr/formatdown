# Scalar value
format_power(101100)

# Vector value
x <- c(1.2222e-6, 2.3333e-5, 3.4444e-4, 4.1111e-3, 5.2222e-2, 6.3333e-1,
       7.4444e+0, 8.1111e+1, 9.2222e+2, 1.3333e+3, 2.4444e+4, 3.1111e+5, 4.2222e+6)
format_power(x)

# Compare significant digits
format_power(x[1], 3)
format_power(x[1], 4)

# Compare notation type
format_power(x[3], engr_notation = TRUE)
format_power(x[3], engr_notation = FALSE)

# Compare disabled exponents limits
format_power(x[6], disable_exponent = c(0.1, 1000))
format_power(x[6], disable_exponent = c(1, 1000))

# Apply to columns of a data frame (data.table syntax)
y <- x[1:6]
z <- x[8:13]
DT <- data.table::data.table(y, z)
DT[, lapply(.SD, function(x) format_power(x))]
