# input: single number
x <- 103400
format_dcml(x)

# input: units class
x <- 103400
units(x) <- "N m2 C-2"
format_dcml(x)

# input: vector
data("metals", package = "formatdown")
x <- metals$thrm_cond
format_dcml(x)

# significant digits
x <- 155.77
format_dcml(x, 2)
format_dcml(x, 3)
format_dcml(x, 4)

# input: data frame
x <- metals[, c("dens", "thrm_cond")]
as.data.frame(apply(x, 2, format_dcml, digits = 3))

# format_dcml() same as format_numbers(..., format = "dcml")
x <- 103400
format_dcml(x)
format_numbers(x, format = "dcml")
