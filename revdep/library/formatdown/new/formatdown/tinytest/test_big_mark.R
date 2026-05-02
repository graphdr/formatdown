test_big_mark <- function() {

  # Options: big_mark and big_interval
  #         format_dcml()
  #         format_numbers(..., format = "dcml")

  # Possible values are:   default ,  or:
  #         big_mark            "" , "thin" , "\\\\,"
  #         big_interval         3 ,  any positive integer

  # correct behaviors
  x <- 123400

  # big_mark
  ans401 <- "$123400$"
  expect_equal(ans401, format_dcml(x))
  expect_equal(ans401, format_dcml(x, big_mark = ""))
  expect_equal(ans401, format_dcml(x, big_mark = NULL))
  expect_equal(ans401, format_dcml(x, big_mark = NA))

  ans402 <- "$123\\,400$"
  expect_equal(ans402, format_dcml(x, big_mark = "thin"))
  expect_equal(ans402, format_dcml(x, big_mark = "\\\\,"))

  # big_interval
  ans403 <- "$123\\,400$"
  expect_equal(ans403, format_dcml(x, big_mark = "thin"))
  expect_equal(ans403, format_dcml(x, big_mark = "thin", big_interval = 3))
  expect_equal(ans403, format_dcml(x, big_mark = "thin", big_interval = 3L))

  ans404 <- "$12\\,3400$"
  expect_equal(ans404, format_dcml(x, big_mark = "thin", big_interval = 4))

  # interactions
  # empty mark ignores interval
  ans405 <- "$123400$"
  expect_equal(ans405, format_dcml(x, big_mark = "", big_interval = 3))
  # zero interval overrides mark
  expect_equal(ans405, format_dcml(x, big_mark = "thin", big_interval = 0))
  # mark ignored if interval > no. of digits
  expect_equal(ans405, format_dcml(x, big_mark = "thin", big_interval = 6))

  # vector input
  x <- c(123456, 789012)
  ans406 <- c("$12\\,34\\,60$", "$78\\,90\\,10$")
  expect_equal(ans406, format_dcml(x, 5, big_mark = "thin", big_interval = 2))

  # errors
  x <- 123400
  expect_error(format_dcml(x, big_mark = ","))
  expect_error(format_dcml(x, big_mark = 0))
  expect_error(format_dcml(x, big_mark = "\\,"))

  expect_error(format_dcml(x, big_mark = "thin", big_interval = 1.5))
  expect_error(format_dcml(x, big_mark = "thin", big_interval = -1))
  expect_error(format_dcml(x, big_mark = "thin", big_interval = Inf))

  expect_error(format_dcml(x, big_mark = "thin", big_interval = NA))
  expect_error(format_dcml(x, big_mark = "thin", big_interval = NULL))

  # function output not printed
  invisible(NULL)
}

test_big_mark()
