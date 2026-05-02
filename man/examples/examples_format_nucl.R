# default arguments
x <- "C-12"
format_nucl(x)

# add atomic number
format_nucl(x, Z = TRUE)

# vector of isotopes
x <- c("C-12", "Fe-54", "U-238")
format_nucl(x, Z = TRUE)

# turn off the warning when using symbols
x <- "X-A"
format_nucl(x, Z = TRUE, warn = FALSE)

# change the typeface
x <- "C-12"
format_nucl(x, face = "bold")

# obtain all possible mass numbers for an element
element_set[symbol == "Ca"]
