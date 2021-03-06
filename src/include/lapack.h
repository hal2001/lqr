#ifndef __LAPACK_H__
#define __LAPACK_H__


// QR
void dgeqrf_(cint_r m, cint_r n, dbl_r a, cint_r lda, dbl_r tau, dbl_r work,
  cint_r lwork, int_r info);
void dorgqr_(cint_r m, cint_r n, cint_r k, dbl_r a, cint_r lda, cdbl_r tau,
  dbl_r work, cint_r lwork, int_r info);


// LQ
void dgelqf_(cint_r m, cint_r n, dbl_r a, cint_r lda, dbl_r tau, dbl_r work,
  cint_r lwork, int_r info);
void dorglq_(cint_r m, cint_r n, cint_r k, dbl_r a, cint_r lda, cdbl_r tau,
  dbl_r work, cint_r lwork, int_r info);


// solve triangular system
void dtrtrs_(cchar_r uplo, cchar_r trans, cchar_r diag, cint_r n, cint_r nrhs,
  cdbl_r a, cint_r lda, dbl_r b, cint_r ldb, int_r info);


// triangular b = A*b
void dtrmm_(cchar_r side, cchar_r uplo, cchar_r transa, cchar_r diag, cint_r m,
  cint_r n, cdbl_r alpha, cdbl_r a, cint_r lda, dbl_r b, cint_r ldb);


#endif
