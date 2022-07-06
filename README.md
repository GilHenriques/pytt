
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

### Binary operators

The package includes a series of binary operators that manipulate
strings. These are wrappers around the base functions `paste0`, `grepl`,
and `substr`:

``` r
library(pytt)

# Paste operator (`paste0`):
pytt_i_panna <- 'pytt i panna'
'Pyttipanna is also called ' %_% pytt_i_panna
#> [1] "Pyttipanna is also called pytt i panna"

# Pattern-matching operator (`grepl`):
c('Pytt i panna', 'Pyttipanna') %like% '\\s'
#> [1]  TRUE FALSE

# Substring (first or last few characters) operator (`substr`):
pytt_i_panna %left% 6
#> [1] "pytt i"
pytt_i_panna %right% 2
#> [1] "na"
```
