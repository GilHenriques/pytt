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
#' 'I am ' %+% 31 %+% ' years old.'
#'
`%+%` <- function(a, b) {
  paste0(a, b)
}


#' Binary pattern-matching operator
#'
#' A binary version of the \code{\link[base]{grepl}} function.
#' Determines if a character string matches a specified pattern.
#' Similar to SQL's `LIKE` operator, but uses \link[base]{regular expression}
#' syntax instead of SQL's wildcard characters * and %.
#'
#' @param vector A character vector where matches are sought, or an object which
#' can be coerced by `as.character` to a character vector.
#' @param pattern A character string containing a
#' \link[base]{regular expression} to be matched in the given character vector.
#'
#' @return A logical vector (match or not for each element of `vector`).
#' @export
#'
#' @examples
#' c('Hello world!', '12345') %like% '[a-z]'
#'
`%like%` <- function(vector, pattern) {
  grepl(pattern, vector)
}

#' Binary operator to extract the first or last few characters of a string
#'
#' Extracts the leftmost (`%left%`) or rightmost (`%right%`) few characters
#' of character strings.
#'
#' @param vector A character vector from which substrings will be extracted
#' @param nr_chars An integer number of characters to be extracted.
#'
#' @return A character vector containing substrings of `vector`.
#' @export
#'
#' @examples
#' c('text', 'vec') %left% 4
#' c('text', 'vec') %right% 2
#'
`%left%` <- function(vector, nr_chars) {
  substr(vector, 1, nr_chars)
}

#' @rdname grapes-left-grapes
#' @export
`%right%` <- function(vector, nr_chars) {
  substr(vector, nchar(vector)-(nr_chars-1), nchar(vector))
}
