# Scalar value, class numeric
x <- 101300
format_units(x, unit = "Pa")

# Scalar value, class units
x <- 101300
units(x) <- "Pa"
format_units(x, unit = "hPa")
format_units(x, digits = 3, unit = "psi")

# Vectors (atmos and metals data included in formatdown)
x <- atmos$dens
units(x) <- "kg/m^3"
format_units(x, unit = "g/m^3")
format_units(x, unit = "g/m^3", unit_form = "implicit")

x <- atmos$pres
units(x) <- "Pa"
format_units(x, big_mark = ",")
format_units(x, unit = "hPa")

x <- metals$thrm_cond
units(x) <- "W m-1 K-1"
format_units(x, digits = 2)
format_units(x, digits = 2, unit_form = "implicit")

