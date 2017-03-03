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



## Benchmarks

```r
library(lqr)
library(rbenchmark)

rqr <- function(x)
{
  tmp <- qr(x, LAPACK=TRUE)
  list(Q=qr.Q(tmp), R=qr.R(tmp))
}

cols <- cols <- c("test", "replications", "elapsed", "relative")
reps <- 25

m = 5000
n = 1000
x = matrix(rnorm(m*n), m, n)

benchmark(QR(x), rqr(x), replications=reps, columns=cols)
##     test replications elapsed relative
## 1  QR(x)           25  15.135    1.000
## 2 rqr(x)           25  53.302    3.522
```

OpenBLAS with 4 threads on a 4 core 2nd generation Intel Core i5 were used for this benchmark.

Several other benchmarks can be found in the `inst/benchmarks/` subdirectory of the source tree for the package.  The above was based on the benchmark found in the file `qr.r`, but with a larger problem size.  The supplied benchmarks are small and should complete reasonably quickly.  However, the performance of **lqr** scales up somewhat (relative to base R) as problem sizes grow.
