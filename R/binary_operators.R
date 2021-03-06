#' Binary paste operator
#'
#' A binary version of the [base::paste()] function. Concatenates
#' vectors after converting to character.
#'
#' @details `%_%` concatenates arguments without a separator, similar to
#'[base::paste0()].
#'
#'`%__%` (with two underscores) separates the arguments with a space, similar
#'to `paste(..., sep = ' ')`.
#'
#'`%,_%` separates the arguments with a comma followed by a space, similar to
#'`paste(..., sep = ', ')`.
#'
#'`%._%` separates the arguments with a period followed by a space, similar to
#'`paste(..., sep = '. ')`.
#'
#'`%:_%` separates the arguments with a colon followed by a space, similar to
#'`paste(..., sep = ': ')`.
#'
#' @param a An \code{R} object, to be converted to a character vector
#' @param b An \code{R} object, to be converted to a character vector
#'
#' @return A character vector of the concatenated values.
#' @export
#'
#' @examples
#' 'I am' %__% 31 %_% ' years old.'
#'
`%_%` <- function(a, b) {
  paste0(a, b)
}

#' @rdname grapes-_-grapes
#' @export
`%__%` <- function(a, b) {
  paste(a, b, sep = ' ')
}

#' @rdname grapes-_-grapes
#' @export
`%._%` <- function(a, b) {
  paste(a, b, sep = '. ')
}

#' @rdname grapes-_-grapes
#' @export
`%,_%` <- function(a, b) {
  paste(a, b, sep = ', ')
}

#' @rdname grapes-_-grapes
#' @export
`%:_%` <- function(a, b) {
  paste(a, b, sep = ': ')
}

#' Binary pattern-matching operator
#'
#' A binary version of the [base::grepl()] function.
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

#' Negated `%in%` operator
#'
#' Returns the logical negation of the binary [base::match()].
#' Aliases: `%!in%` and `%not_in`.
#'
#' @param x Vector or `NULL`: the values to be matched
#' @param vector Vector or `NULL`: the values to be matched against
#'
#' @return A logical vector of the same length as `x`; returns `TRUE` when the
#' element of `x` is absent from `vector` and `FALSE` when the element of `x` is
#' present in `vector`.
#' @export
#'
#' @examples
#' c('text', 'vec') %notin% c('ice-cream', 'world', 'text')
#'
`%notin%` <- function(x, vector){
  !(x %in% vector)
}

#' @rdname grapes-notin-grapes
#' @export
`%!in%` <- `%notin%`

#' @rdname grapes-notin-grapes
#' @export
`%not_in%` <- `%notin%`
