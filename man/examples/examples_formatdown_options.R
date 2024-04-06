# get default options
formatdown_options("size", "delim")

# set new options
formatdown_options(size = "large", delim = c("\\(", "\\)"))

# verify new options
formatdown_options("size", "delim")

# reset to default options
reset_formatdown_options()

# confirm default options
formatdown_options("size", "delim")
