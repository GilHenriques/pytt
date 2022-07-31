.pytt_env <- new.env(parent = emptyenv())

#' Record the time difference between the execution of two lines of code
#'
#' Computes the time difference between a call to `tic` and a call to `toc`.
#'
#' @details Calling `tic` initiates a timer. After initiating the timer, `toc`
#' outputs the time difference. `toc` can be called multiple times. The
#' timer can be reset by calling `tic` again.
#'
#' Multiple timers (including nested timers) are supported: simply provide a
#' matching `name` argument to `tic` and to `toc`.
#'
#' @param name Character string specifying the name of the timer. Optional, but
#' necessary for running multiple timers.
#'
#' @export
#'
#' @examples
#'
#' # Example where `toc()` is called multiple times on the same timer:
#' tic()
#' print("Hello...")
#' Sys.sleep(1)
#' toc()
#' print("... world")
#' Sys.sleep(1)
#' toc()
#'
#' # Example with nested timers:
#' tic('outer')
#' for(i in 1:3){
#'   tic('inner')
#'   Sys.sleep(0.2)
#'   toc('inner')
#' }
#' toc('outer')
#'
tic <- function(name = 'timer') {
  assign(name, Sys.time(), envir = .pytt_env)
}

#' @rdname tic
#' @export
toc <- function(name = 'timer') {
  if(! exists(name, envir = .pytt_env)){
    stop('The `name` argument in toc() does not match the `name` of any existing timers. Initiate a timer with tic().')
  }
  duration <- Sys.time() - eval(parse(text = '.pytt_env$' %_% name))
  message(sprintf('%s: Time difference of %.4f %s', name, duration, units(duration)))
}

#' Make a simple progress bar in the terminal
#'
#' Simple wrapper around [progress::progress_bar()] that sacrifices
#' the amount of options in favor of being easier to use. The progress bar
#' displays percent completion, time elapsed, and estimated time to conclusion.
#' Optionally, a sound may be played when the progress bar is finished (from
#' [beepr::beep()]).
#'
#' @details Calling `progress_bar_start` initiates a progress bar. Calling
#' `progress_bar_tick` updates the progress. Should the argument `beep` be set
#' to `TRUE`, a sound will be played upon completion.
#'
#' @param repeats Integer. Number of ticks (events that move the progress bar
#' forward)
#' @param beep Logical. If `TRUE`, a sound will be played upon completion.
#'
#' @importFrom progress progress_bar
#' @importFrom beepr beep
#'
#' @export
#'
#' @examples
#' progress_bar_start(repeats = 10)
#' for(i in 1:10) {
#'  progress_bar_tick()
#'  Sys.sleep(0.1);
#' }
#'
progress_bar_start <- function(repeats) {
  assign('pb',
         progress::progress_bar$new(total = repeats,
                                    format = "(:spin) [:bar] :percent in :elapsed, eta: :eta",
                                    width = 80),
         envir = .pytt_env)
}

#' @rdname progress_bar_start
#' @export
progress_bar_tick <- function(beep = FALSE) {
  .pytt_env$pb$tick()
  if (beep && .pytt_env$pb$finished) beepr::beep(sound = 3)
}



#' Evaluate an expression multiple times in parallel
#'
#' Evaluates an expression in parallel, in multiple background R processes.
#' Alias: parallelise.
#'
#' @details Uses \code{\link[future]{plan}} from the `future` package to launch several background R processes, running on different processor cores on the same machine.
#' Uses \code{\link[doFuture]{registerDoFuture}} from the `doFuture` package and \code{\link[foreach]{foreach}} from the `foreach` package for the actual parallelization.
#' Uses \code{\link[doRNG]{%dorng%}} from the `doRNG` package to generate different random numbers in each repetition.
#'
#' Note for users who have set a `future` strategy or registered a backend prior to calling `parallelize`: while this function sets its own `future` strategy and `foreach` backend, it restores the user's settings on exit.
#'
#' @param repeats Integer number of times to evaluate the expression
#' @param expr `R` expression to evaluate
#' @param workers Integer number of processor cores to use. Maximum: number of processor cores on the system minus 1. If no value is provided, or if the value provided exceeds the maximum, defaults to the maximum.
#' @param seed A single value, interpreted as an integer,.
#'
#' @importFrom parallel detectCores
#' @importFrom doFuture registerDoFuture
#' @importFrom foreach setDoPar foreach `%dopar%`
#' @importFrom future plan
#' @importFrom doRNG `%dorng%`
#' @importFrom stats runif
#'
#' @export
#'
#' @examples
#' parallelize(repeats = 2, expr = rnorm(100), workers = 3, seed = 1)
#'
parallelize <- function(repeats, expr, workers, seed) {

  # Before calling the function, the user might have set a future strategy or registered a foreach backend. We don't want to break their setup, so we will save the user's settings and re-set them on exit
  old_plan <- future::plan(NULL)
  old_backend <- doFuture::registerDoFuture()
  on.exit(with(old_backend, foreach::setDoPar(fun = fun, data = data, info = info)), add = TRUE)
  on.exit(future::plan(old_plan), add = TRUE)

  max_workers <- parallel::detectCores() - 1
  if (missing(workers)) { workers <- max_workers
  } else if (!is.numeric(workers) || workers %% 1 != 0) {
    stop('The value of `workers` must be an integer.')
  } else if (workers > max_workers) {
    workers <- max_workers
    message('The value of `workers` exceeds the maximum value (number of processor cores in the system minus 1). Coercing to the maximum value.')
  }

  if(missing(seed)) seed <- runif(1, 0, 1e6)

  doFuture::registerDoFuture()
  future::plan('multisession', workers = workers)
  # Forked processing ('multicore') is not supported when running R from RStudio because it is considered unstable, so we will use 'multisession'

  output <- do.call(`%dorng%`, list(substitute(foreach::foreach(1:repeats, .options.RNG = seed)), substitute(expr)))

  # We don't want to print the random number sequence used by doRNG to generate random numbers...
  attr(output, 'rng') <- NULL; attr(output, 'doRNG_version') <- NULL

  return(output)
}

#' @rdname parallelize
#' @export
parallelise <- parallelize
