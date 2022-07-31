test_that("names of timer work as expected", {
  tic("first")
  tic("second")
  expect_message(toc("first"), regexp = "first")
  expect_message(toc("second"), regexp = "second")
  expect_error(toc(), regexp = 'argument in toc')
})

test_that("future strategy goes back to default", {
  # Run parallelize without setting a future strategy
  parallelize(repeats = 3,
              expr = rnorm(1))

  # Should go back to default strategy (sequential)
  expect_true(
    (future::plan(NULL) |> deparse())[7] %like% 'sequential'
  )

  # Run parallelize but first set a future strategy (cluster)
  future::plan('cluster')
  parallelise(repeats = 3,
              expr = rnorm(1))

  # Should go back to cluster
  expect_true(
    (future::plan(NULL) |> deparse())[7] %like% 'cluster'
  )

  # Clean up
  future::plan('sequential')
})

test_that("future throws appropriate errors or messages", {
  expect_error(parallelize(repeats = 3,  expr = rnorm(1), workers = 'x'),
                'must be an integer')

  expect_message(parallelize(repeats = 3,  expr = rnorm(1), workers = 100),
                 'maximum value')
})

test_that("future outputs different/equal random numbers when expected to", {
  two_rand_nrs <- parallelize(repeats = 2, expr = rnorm(1), workers = 1)
  expect_false(two_rand_nrs[[1]] == two_rand_nrs[[2]])

  two_more_nrs <- parallelize(repeats = 2, expr = rnorm(1), workers = 1)
  expect_false(two_rand_nrs[[1]] == two_more_nrs[[1]])

  two_rand_nrs <- parallelize(repeats = 2, expr = rnorm(1), workers = 1, seed = 1)
  expect_false(two_rand_nrs[[1]] == two_rand_nrs[[2]])

  two_more_nrs <- parallelize(repeats = 2, expr = rnorm(1), workers = 1, seed = 1)
  expect_equal(two_rand_nrs, two_more_nrs)
})
