library(lqr)
set.seed(1234)

m = 2
n = 5
x = matrix(rnorm(m*n), m, n)

L = LQ(x, retq=FALSE)
Q = LQ(x, retl=FALSE)
stopifnot(all.equal(L%*%Q, x))

Qt = t(Q)
R = t(L)

QR = qr(t(x))
Q_R = qr.Q(QR)
R_R = qr.R(QR)
stopifnot(all.equal(Qt, Q_R))
stopifnot(all.equal(R, R_R))



m = 10
n = 3
x = matrix(rnorm(m*n), m, n)

Q1 = QR(x, retr=FALSE)
Q2 = qr.Q(qr(x))
stopifnot(all.equal(Q1, Q2))

R1 = QR(x, retq=FALSE)
R2 = qr.R(qr(x))
stopifnot(all.equal(R1, R2))



x = t(x)

Q1 = QR(x, retr=FALSE)
Q2 = qr.Q(qr(x))
stopifnot(all.equal(Q1, Q2))

R1 = QR(x, retq=FALSE)
R2 = qr.R(qr(x))
stopifnot(all.equal(R1, R2))
