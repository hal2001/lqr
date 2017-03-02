library(lqr)
set.seed(1234)

m = 5
n = 5
x = matrix(rnorm(m*n), m, n)

Q1 = QR(x, retr=FALSE)
Q2 = qr.Q(qr(x))
stopifnot(all.equal(Q1, Q2))

R1 = QR(x, retq=FALSE)
R2 = qr.R(qr(x))
stopifnot(all.equal(R1, R2))

QR = QR(x, retq=TRUE, retr=TRUE)
stopifnot(all.equal(QR$Q, Q2))
stopifnot(all.equal(QR$R, R2))



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
