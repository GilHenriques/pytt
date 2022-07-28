test_that("names of timer work as expected", {
  tic("first")
  tic("second")
  expect_message(toc("first"), regexp = "first")
  expect_message(toc("second"), regexp = "second")
  expect_error(toc(), regexp = 'argument in toc')
})
