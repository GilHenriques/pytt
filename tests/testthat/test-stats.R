test_that("standard error of zero- or one-length vectors", {
  expect_equal(se(c()), NA_real_)
  expect_equal(se(1), NA_real_)
})
