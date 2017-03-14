library(lqr)
set.seed(1234)

m = 20
n = 5
x = matrix(rnorm(m*n), m, n)
y = rnorm(m)

mdl1 = lm.fit(x, y)
mdl2 = lm_fit(x, y)


stopifnot(all.equal(matrix(mdl1$residuals), mdl2$residuals))
stopifnot(all.equal(matrix(mdl1$coefficients), mdl2$coefficients))
