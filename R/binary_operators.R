#' Binary paste operator
#'
#' A binary version of the \code{\link[base]{paste0}} function.
#'
#' @param a An \code{R} object, to be converted to a character vector
#' @param b An \code{R} object, to be converted to a character vector
#'
#' @return A character vector of the concatenated values.
#' @export
#'
#' @examples
#' 'I am ' %+% 31 %+% 'years old.'
#'
`%+%` <- function(a, b) {
  paste0(a, b)
}
