test_that("binary paste operator works", {
  expect_equal('I am ' %_% 31 %_% ' years old',
               paste0('I am ', 31, ' years old'))
})

test_that("binary pattern-matching operator works", {
  x <- c("Abba", "123", "ABBA!")
  expect_equal(x %like% "a", c(TRUE, FALSE, FALSE))
  expect_equal(x %like% "A", c(TRUE, FALSE, TRUE))
  expect_equal(x %like% "[1-9]", c(FALSE, TRUE, FALSE))
})

test_that("binary left/right operator works", {
  x <- c("Abba", "123", "ABBA!")
  expect_equal(x %left% 4, c("Abba", "123", "ABBA"))
  expect_equal(x %right% 1, c("a", "3", "!"))
})

test_that("not-in works", {
  expect_equal(c('text', 'vec') %notin% c('ice-cream', 'world', 'text'),
               c(FALSE, TRUE))

  expect_equal('vec' %notin% c('ice-cream', 'world', 'text'), TRUE)
})
