# Digits
x <- c(12300400.1234, 456000)
format_decimal(x, digits = 0)
format_decimal(x, digits = 1)
format_decimal(x, digits = 2)

# Big mark
format_decimal(x, 0, big_mark = ",")

# Inline math delimiters
x <- c(1.654321, 0.065432)
format_decimal(x)
format_decimal(x, 3, delim = "$")
format_decimal(x, 3, delim = c("$", "$"))
format_decimal(x, 3, delim = "\\(")
format_decimal(x, 3, delim = c("\\(", "\\)"))

# LaTeX-style display equation delimiters
format_decimal(x, 3, delim = c("\\[", "\\]"))

# Apply to columns of a data frame (data.table syntax)
DT <- atmos[, .(temp, sound)]
DT[, lapply(.SD, function(x) format_decimal(x, 1))]
