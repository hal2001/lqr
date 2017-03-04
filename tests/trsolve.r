library(lqr)
set.seed(1234)

n = 100

x = matrix(rnorm(n*n), n)
x = crossprod(x)
x[lower.tri(x)] = 0

y = matrix(rnorm(n))

all.equal(trsolve(x, y), solve(x, y))
