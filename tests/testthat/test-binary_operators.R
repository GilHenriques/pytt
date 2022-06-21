test_that("binary paste operator works", {
  expect_equal('I am ' %+% 31 %+% ' years old',
               paste0('I am ', 31, ' years old'))
})
