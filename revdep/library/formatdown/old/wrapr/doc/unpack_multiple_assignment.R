## -----------------------------------------------------------------------------
library(wrapr)
# example data
d <- data.frame(
  x = 1:9,
  group = c('train', 'calibrate', 'test'),
  stringsAsFactors = FALSE)

knitr::kable(d)

# split the d by group
(parts <- split(d, d$group))
train_data <- parts$train
calibrate_data <- parts$calibrate
test_data <- parts$test

knitr::kable(train_data)

knitr::kable(calibrate_data)

knitr::kable(test_data)

## -----------------------------------------------------------------------------
# clear out the earlier results
rm(list = c('train_data', 'calibrate_data', 'test_data', 'parts'))

# split d and unpack the smaller data frames into separate variables
unpack(split(d, d$group),
       train_data = train,
       test_data = test,
       calibrate_data = calibrate)

knitr::kable(train_data)

knitr::kable(calibrate_data)

knitr::kable(test_data)

## -----------------------------------------------------------------------------
# split d and unpack the smaller data frames into separate variables
unpack[traind = train, testd = test, cald = calibrate] := split(d, d$group)

knitr::kable(traind)

knitr::kable(cald)

knitr::kable(testd)

## -----------------------------------------------------------------------------
unpack(split(d, d$group), train, test, calibrate)

knitr::kable(train)

knitr::kable(calibrate)

knitr::kable(test)

# try the unpack[] assignment notation

rm(list = c('train', 'test', 'calibrate'))

unpack[test, train, calibrate] := split(d, d$group)

knitr::kable(train)

knitr::kable(calibrate)

knitr::kable(test)

## -----------------------------------------------------------------------------
rm(list = c('train', 'test', 'calibrate'))
unpack(split(d, d$group), train, holdout=test, calibrate)

knitr::kable(train)

knitr::kable(calibrate)

knitr::kable(holdout)

## ----error=TRUE---------------------------------------------------------------
rm(list = c('train', 'holdout', 'calibrate'))

unpack(split(d, d$group), train, test)

knitr::kable(train)

knitr::kable(test)

# we didn't unpack the calibrate set
calibrate


## ----error=TRUE---------------------------------------------------------------

# the split call will not return an element called "holdout"
unpack(split(d, d$group), training = train, testing = holdout)

# train was not unpacked either
training


