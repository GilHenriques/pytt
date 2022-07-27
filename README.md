
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pytt

<!-- badges: start -->

[![R-CMD-check](https://github.com/GilHenriques/pytt/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/GilHenriques/pytt/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

**Pyttipanna** is a Swedish dish made by mixing together small bits and
pieces of leftover food. The word means “small bits in a pan”. Much like
a pyttipanna, `{pytt}` is a collection of bits and pieces thrown
together. It includes very simple utility functions that I use commonly.
Most functions in `{pytt}` are simply wrappers around other functions.

## Installation

You can install pytt from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("GilHenriques/pytt")
```

## Functions included in `{pytt}`

-   A series of binary concatenation operators:
    -   `%_%` for pasting without separator
    -   `%__%` for pasting with a space separator
    -   `%,_%`, `%._%`, and `%:_%` for separating with a comma/dot/colon
        followed by a space
-   An SQL-style binary pattern-matching operator: `%like%`
-   Binary operators to extract the first or last few characters of a
    string: `%left%` and `%right%`
-   A negated `%in%`operator: `%!in%`
-   A standard error function: `se()`
-   A timer: `tic()` and `toc()` (includes support for multiple timers
    and nested timers)
-   A progress bar: `progress_bar_start(repeats = ...)` and
    `progress_bar_tick()`. Optionally, a sound may be played when the
    progress bar is finished.
