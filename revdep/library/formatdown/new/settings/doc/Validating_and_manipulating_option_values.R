## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(settings)

## -----------------------------------------------------------------------------
foo_check <- function(x){
  allowed <- c("boo","bar","baz")
  # cast to lowercase
  x <- base::tolower(x)
  if ( !x %in% allowed ){
    stop("Option foo must be in 'boo', 'bar', or 'baz'", call. = FALSE)
  } else {
    x
  }
}

## -----------------------------------------------------------------------------
my_options <- options_manager(foo="boo", .allowed = list( foo = foo_check) )
my_options("foo")

## ---- error=TRUE--------------------------------------------------------------
my_options(foo = "BaZ")
my_options("foo")

## ----error=TRUE---------------------------------------------------------------
my_options(foo=1)

## -----------------------------------------------------------------------------
make_checker <- function(allowed){
  .allowed <- allowed
  function(x){
    x <- tolower(x)
    if (!x %in% .allowed){
      stop(sprintf("Allowed values are %s",paste0(.allowed, collapse=", ")), call.=FALSE)
    } else {
      x
    }
  }
}

## -----------------------------------------------------------------------------
my_new_options <- options_manager(foo = "hey", bar="fee"
  , .allowed = list(
      foo = make_checker( c("hey", "ho") )
    , bar = make_checker( c("fee", "fi", "fo", "fum") )
  ))

## ----error=TRUE---------------------------------------------------------------
my_new_options(bar="FEE")
my_new_options("bar")

my_new_options(foo="do")

