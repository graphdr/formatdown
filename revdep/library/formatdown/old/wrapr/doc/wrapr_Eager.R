## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(wrapr)

## -----------------------------------------------------------------------------
lst <- list(sin)

# without the attribute, the function is returned
4 %.>% lst[[1]]

## -----------------------------------------------------------------------------
# an outer .() signals for eager eval from the pipeline
4 %.>% .(lst[[1]])

## -----------------------------------------------------------------------------
# with the attribute, the array is always de-referenced
# before the pipe execution allowing the function
# to be evaluated using the piped-in value.
attr(lst, 'dotpipe_eager_eval_bracket') <- TRUE

4 %.>% lst[[1]]

## -----------------------------------------------------------------------------
# without the attribute the result is sin
f <- function(...) { sin }
4 %.>% f()

## -----------------------------------------------------------------------------
# an outer .() signals for eager eval from the pipeline
4 %.>% .(f())

## -----------------------------------------------------------------------------
# with the attribute the result is sin(4)
attr(f, 'dotpipe_eager_eval_function') <- TRUE

4 %.>% f()

