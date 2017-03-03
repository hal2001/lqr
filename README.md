# lqr

* **Version:** 0.1-0
* **Status:** [![Build Status](https://travis-ci.org/wrathematics/lqr.png)](https://travis-ci.org/wrathematics/lqr)
* **License:** [![License](http://img.shields.io/badge/license-BSD%202--Clause-orange.svg?style=flat)](http://opensource.org/licenses/BSD-2-Clause)
* **Author:** Drew Schmidt



A streamlined interface for carefully optimized, high-performance access to the QR and LQ orthogonal factorizations.  L and R are lower and upper triangular matrices respectively, and Q is an orthogonal matrix.

You can read more about the QR factorization [here](http://www.netlib.org/lapack/lug/node40.html) and the LQ factorization [here](http://www.netlib.org/lapack/lug/node41.html).



## Installation

<!-- To install the R package, run:

```r
install.package("coop")
``` -->

The development version is maintained on GitHub, and can easily be installed by any of the packages that offer installations from GitHub:

```r
### Pick your preference
devtools::install_github("wrathematics/lqr")
ghit::install_github("wrathematics/lqr")
remotes::install_github("wrathematics/lqr")
```



## Example Usage

You can compute Q and/or R via `QR()` and L and/or Q via `LQ()`.  If m>>n then you should use QR and for m<<n use LQ.  For example:

```r
library(lqr)
m <- 3
n <- 10
x <- matrix(rnorm(m*n), m, n)

lq <- LQ(x)
## List of 2
##  $ Q: num [1:3, 1:10] -0.3805 -0.3031 -0.0648 0.0017 -0.2542 ...
##  $ L: num [1:3, 1:3] 3.5771 0.2538 0.0454 0 2.5589 ...

all.equal(lq$L %*% lq$Q, x)
## [1] TRUE
```
