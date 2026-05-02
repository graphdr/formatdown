## -----------------------------------------------------------------------------
d <- data.frame(
  x = 1:9,
  group = c('train', 'calibrate', 'test'),
  stringsAsFactors = FALSE)

knitr::kable(d)

## -----------------------------------------------------------------------------
parts <- split(d, d$group)
train_data <- parts$train
calibrate_data <- parts$calibrate
test_data <- parts$test

## -----------------------------------------------------------------------------
knitr::kable(train_data)

knitr::kable(calibrate_data)

knitr::kable(test_data)

## -----------------------------------------------------------------------------
rm(list = c('train_data', 'calibrate_data', 'test_data', 'parts'))

## -----------------------------------------------------------------------------
library(wrapr)

to[
  train_data <- train,
  calibrate_data <- calibrate,
  test_data <- test
  ] <- split(d, d$group)

## -----------------------------------------------------------------------------
knitr::kable(train_data)

knitr::kable(calibrate_data)

knitr::kable(test_data)

## -----------------------------------------------------------------------------
rm(list = c('train_data', 'calibrate_data', 'test_data', 'to'))

to[
  train_data <- train,
  calibrate_data <- calibrate,
  test_data <- test
  ] := split(d, d$group)

ls()

## -----------------------------------------------------------------------------
rm(list = c('train_data', 'calibrate_data', 'test_data'))

## -----------------------------------------------------------------------------
split(d, d$group) %.>% to[
  train_data <- train,
  calibrate_data <- calibrate,
  test_data <- test
  ]

ls()

## -----------------------------------------------------------------------------
rm(list = c('train_data', 'calibrate_data', 'test_data'))

## -----------------------------------------------------------------------------
split(d, d$group) %.>% to(
  train_data <- train,
  calibrate_data <- calibrate,
  test_data <- test
)

ls()

## -----------------------------------------------------------------------------
rm(list = c('train_data', 'calibrate_data', 'test_data'))

## -----------------------------------------------------------------------------
split(d, d$group) %.>% unpack(
  .,
  train_data <- train,
  calibrate_data <- calibrate,
  test_data <- test
)

ls()

## -----------------------------------------------------------------------------
rm(list = c('train_data', 'calibrate_data', 'test_data'))

## -----------------------------------------------------------------------------
unpack(
  split(d, d$group),
  train_data <- train,
  calibrate_data <- calibrate,
  test_data <- test
)

ls()

## -----------------------------------------------------------------------------
rm(list = c('train_data', 'calibrate_data', 'test_data'))

## -----------------------------------------------------------------------------
unpack(
  split(d, d$group),
  train_data = train,
  calibrate_data = calibrate,
  test_data = test
)

ls()

## -----------------------------------------------------------------------------
rm(list = c('train_data', 'calibrate_data', 'test_data'))

## -----------------------------------------------------------------------------
unpack(
  split(d, d$group),
  train -> train_data,
  calibrate -> calibrate_data,
  test -> test_data
)

ls()

## -----------------------------------------------------------------------------
rm(list = c('train_data', 'calibrate_data', 'test_data'))

## ---- error=TRUE--------------------------------------------------------------
unpack(
  split(d, d$group),
  train_data <- train,
  calibrate_data <- calibrate_misspelled,
  test_data <- test
)

## -----------------------------------------------------------------------------
ls()

## -----------------------------------------------------------------------------
unpack(
  split(d, d$group),
  train_data <- train,
  test_data <- test
)

ls()

## -----------------------------------------------------------------------------
rm(list = c('train_data', 'test_data'))

## -----------------------------------------------------------------------------
split(d, d$group) %.>%
  to[
     train,
     test
     ]

ls()

## -----------------------------------------------------------------------------
rm(list = c('train', 'test'))

## -----------------------------------------------------------------------------
train_source <- 'train'

split(d, d$group) %.>%
  to[
     train_result = .(train_source),
     test
     ]

ls()

