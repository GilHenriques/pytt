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
