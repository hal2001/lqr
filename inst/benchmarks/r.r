library(lqr)
library(rbenchmark)

rqr <- function(x) qr.R(qr(x, LAPACK=TRUE))

cols <- c("test", "replications", "elapsed", "relative")
reps <- 25

m = 2000
n = 500
x = matrix(rnorm(m*n), m, n)

benchmark(QR(x, retq=FALSE), rqr(x), replications=reps, columns=cols)
