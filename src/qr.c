#include "lqr.h"
#include "include/sexp2dbl.h"

void dgeqrf_(cint_r m, cint_r n, dbl_r a, cint_r lda, dbl_r tau, dbl_r work, cint_r lwork, int_r info);
void dorgqr_(cint_r m, cint_r n, cint_r k, dbl_r a, cint_r lda, cdbl_r tau, dbl_r work, cint_r lwork, int_r info);

static inline int worksize(cint m, cint n)
{
  // dgeqrf's lwork is the same as dorgqr's
  int lwork;
  double tmp;
  
  dgeqrf_(&m, &n, &(double){0}, &m, &(double){0}, &tmp, &(int){-1}, &(int){0});
  lwork = (int) tmp;
  
  return MAX(lwork, 1);
}

// gets the R matrix which is MIN(m,n)xn upper triangular
static inline SEXP get_R(cint m, cint n, cdbl_r QR)
{
  SEXP R_;
  const int minmn = MIN(m, n);
  newRmat(R_, minmn, n, "dbl");
  double *const R = DBLP(R_);
  
  // if (m >= n)
  // {
  //   for (int j=0; j<n-1; j++)
  //   {
  //     memcpy(R + n*j, QR + m*j, (j+1)*sizeof(*QR));
  //     memset(R + j+1 + n*j, 0, (n-j-1)*sizeof(*QR));
  //   }
  //   
  //   memcpy(R + n*(n-1), QR + m*(n-1), n*sizeof(*QR));
  // }
  // else
  // {
  //   for (int j=0; j<m; j++)
  //   {
  //     memcpy(R + m*j, QR + m*j, (j+1)*sizeof(*QR));
  //     memset(R + j+1 + m*j, 0, (m-j-1)*sizeof(*QR));
  //   }
  //   
  //   memcpy(R + m*m, QR + m*m, (m*n-m*m)*sizeof(*QR));
  // }
  memset(R, 0, minmn*n*sizeof(*R));
  for (int j=0; j<n; j++)
  {
    for (int i=0; i<=j && i<minmn; i++)
      R[i + minmn*j] = QR[i + m*j];
  }
  
  return R_;
}

static inline SEXP get_Q(cint m, cint n, dbl_r QR, dbl_r tau, dbl_r work, cint lwork, int_r info)
{
  SEXP Q;
  const int minmn = MIN(m, n);
  newRmat(Q, m, minmn, "dbl");
  
  dorgqr_(&m, &minmn, &minmn, QR, &m, tau, work, &lwork, info);
  if (*info != 0)
  {
    FREE(work);FREE(tau);FREE(QR);
    THROW_LAPACKERR(*info);
  }
  
  memcpy(DBLP(Q), QR, m*minmn * sizeof(*QR));
  
  return Q;
}



SEXP R_qr(SEXP x, SEXP retq_, SEXP retr_)
{
  SEXP Q;
  SEXP R = R_NilValue; // suppress false positive compiler warning;
  int lwork;
  int info;
  double *work, *tau, *QR;
  
  CHECK_IS_FLAG(retq_, "retq");
  CHECK_IS_FLAG(retr_, "retr");
  
  const bool retq = INT(retq_);
  const bool retr = INT(retr_);
  
  if (!retq && !retr)
    error("at least one of Q or R must be returned");
  
  CHECK_IS_MATRIX(x);
  CHECK_IS_NUMERIC(x);
  
  const int m = nrows(x);
  const int n = ncols(x);
  const int minmn = MIN(m, n);
  
  lwork = worksize(m, n);
  
  work = malloc(lwork * sizeof(*work));
  tau = malloc(minmn * sizeof(*tau));
  QR = malloc(m*n * sizeof(*QR));
  if (tau == NULL || work == NULL || QR == NULL)
  {
    FREE(tau);FREE(work);FREE(QR);
    THROW_MEMERR;
  }
  
  sexp2dbl(QR, x, m*n);
  
  
  dgeqrf_(&m, &n, QR, &m, tau, work, &lwork, &info);
  if (info != 0)
  {
    FREE(work);FREE(tau);FREE(QR);
    THROW_LAPACKERR(info);
  }
  
  if (retr)
    R = get_R(m, n, QR);
  if (retq)
    Q = get_Q(m, n, QR, tau, work, lwork, &info);
  
  FREE(work);FREE(tau);FREE(QR);
  
  if (retq && retr)
  {
    SEXP ret, retnames;
    retnames = make_list_names(2, "Q", "R");
    ret = make_list(retnames, 2, Q, R);
    R_END;
    return ret;
  }
  else
  {
    R_END;
    if (retq)
      return Q;
    else if (retr)
      return R;
    else // to suppress compiler warnings; can't actually happen
      return R_NilValue;
  }
}
