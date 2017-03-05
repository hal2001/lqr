library(lqr)
library(rbenchmark)

cols <- c("test", "replications", "elapsed", "relative")
reps <- 25

m = 2500
n = 500
x = matrix(rnorm(m*n), m, n)
y = t(x)

benchmark(QR(x), LQ(x), replications=reps, columns=cols)
benchmark(QR(y), LQ(y), replications=reps, columns=cols)
