#include "lqr.h"


SEXP R_trsolve(SEXP A, SEXP b, SEXP triang)
{
  SEXP x_;
  int info;
  const char uplo = *STR(triang);
  const char trans = 'N';
  const char diag = 'N';
  
  CHECK_IS_MATRIX(A);
  CHECK_IS_NUMERIC(A);
  CHECK_IS_NUMERIC(b);
  
  const int nrhs = ncols(b);
  const int n = nrows(A);
  if (n != ncols(A))
    error("input matrix 'A' must be square");
  
  newRmat(x_, n, nrhs, "dbl");
  double *const restrict x = DBLP(x_);
  memcpy(x, DBLP(b), n*nrhs*sizeof(*x));
  
  dtrtrs_(&uplo, &trans, &diag, &n, &nrhs, DBLP(A), &n, x, &n, &info);
  R_END;
  
  if (info != 0)
    THROW_LAPACKERR(info);
  
  return x_;
}
