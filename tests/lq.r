library(lqr)
set.seed(1234)

test = function(x)
{
  L = LQ(x, retq=FALSE)
  Q = LQ(x, retl=FALSE)
  stopifnot(all.equal(L%*%Q, x))

  Qt = t(Q)
  R = t(L)

  QR = qr(t(x))
  Q_R = qr.Q(QR)
  R_R = qr.R(QR)
  class(R_R) = "triangular"
  stopifnot(all.equal(Qt, Q_R, check.attributes=FALSE))
  stopifnot(all.equal(R, R_R, check.attributes=FALSE))
}



m = 5
n = 5
x = matrix(rnorm(m*n), m, n)
test(x)

m = 10
n = 3
x = matrix(rnorm(m*n), m, n)
test(x)

x = t(x)
test(x)
