#' Standard error
#'
#' Computes the standard error of the values in `x`. By default removes missing
#' values before the computation proceeds (this behavior is the opposite of
#' base R functions).
#'
#' @details Like [stats::var()] this uses denominator $n-1$.
#' The standard error of a length-one or zero-length vector is `NA`.
#'
#' @param x A numeric vector
#' @param na.rm Logical. Should missing values be removed?
#'
#' @importFrom stats na.omit sd
#'
#' @export
#'
#' @examples
#' se(c(1:5, NA))^2
#' se(c(1:5, NA), na.rm = FALSE)^2
#'
se <- function(x, na.rm = TRUE) sd(x, na.rm = na.rm) / sqrt(length(na.omit(x)))
