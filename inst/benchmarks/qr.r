library(lqr)
library(rbenchmark)

rqr <- function(x)
{
  tmp <- qr(x, LAPACK=TRUE)
  list(Q=qr.Q(tmp), R=qr.R(tmp))
}

cols <- c("test", "replications", "elapsed", "relative")
reps <- 25

m = 2000
n = 500
x = matrix(rnorm(m*n), m, n)

benchmark(QR(x), rqr(x), replications=reps, columns=cols)
