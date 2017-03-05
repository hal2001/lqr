library(rbenchmark)
library(lqr)
set.seed(1234)

cols <- c("test", "replications", "elapsed", "relative")
reps <- 25

n = 2000

x = matrix(rnorm(n*n), n)
x = crossprod(x)
x[lower.tri(x)] = 0

y = matrix(rnorm(n))



benchmark(solve(x, y), trsolve(x, y, "U"), replications=reps, columns=cols)
