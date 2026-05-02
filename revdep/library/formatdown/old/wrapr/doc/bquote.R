## -----------------------------------------------------------------------------
library("wrapr")

variable <- "angle"

sinterp(
  'variable name is .(variable)'
)

## -----------------------------------------------------------------------------
angle = 1:10
variable_name <- as.name("angle")

if(requireNamespace("graphics", quietly = TRUE)) {
  evalb(
    
    plot(x = .(-variable_name), 
         y = sin(.(-variable_name)))
    
  )
}

## -----------------------------------------------------------------------------
angle = 1:10
variable_string <- "angle"

if(requireNamespace("graphics", quietly = TRUE)) {
  evalb(
    
    plot(x = .(-variable_string), 
         y = sin(.(-variable_string)))
    
  )
}

## -----------------------------------------------------------------------------
plotb <- bquote_function(graphics::plot)

if(requireNamespace("graphics", quietly = TRUE)) {
  plotb(x = .(-variable), 
        y = sin(.(-variable)))
}

## -----------------------------------------------------------------------------
f <- function() { 
  sin
}

# pipe 5 to the value of f()
# the .() says to evaluate f() before the
# piping
5 %.>% .(f())

# evaluate "f()"" with . = 5
# not interesting as "f()"" is "dot free" 
5 %.>% f()

## -----------------------------------------------------------------------------
attr(f, 'dotpipe_eager_eval_function') <- TRUE

# now evalutates pipe on f() result.
5 %.>% f()

