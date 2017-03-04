#include "lqr.h"

void dtrtrs_(cchar_r uplo, cchar_r trans, cchar_r diag, cint_r n, cint_r nrhs,
  cdbl_r a, cint_r lda, dbl_r b, cint_r ldb, int_r info);



SEXP R_trsolve(SEXP A, SEXP b)
{
  SEXP x_;
  int info;
  const char uplo = 'U';
  const char trans = 'N';
  const char diag = 'N';
  
  const int nrhs = ncols(b);
  const int n = nrows(A);
  if (n != ncols(A))
    error("inputs matrix 'A' must be square");
  
  newRmat(x_, n, nrhs, "dbl");
  double *const restrict x = DBLP(x_);
  memcpy(x, DBLP(b), n*nrhs*sizeof(*x));
  
  dtrtrs_(&uplo, &trans, &diag, &n, &nrhs, DBLP(A), &n, x, &n, &info);
  R_END;
  
  if (info != 0)
    error("LAPACK routine dtrtrs() returned error code %d\n", info);
  
  return x_;
}