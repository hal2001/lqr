#include "lqr.h"

void dgelqf_(cint_r m, cint_r n, dbl_r a, cint_r lda, dbl_r tau, dbl_r work, cint_r lwork, int_r info);
void dorglq_(cint_r m, cint_r n, cint_r k, dbl_r a, cint_r lda, cdbl_r tau, dbl_r work, cint_r lwork, int_r info);


static inline int worksize(cint m, cint n)
{
  int lwork;
  double tmp;
  
  dgelqf_(&m, &n, &(double){0}, &m, &(double){0}, &tmp, &(int){-1}, &(int){0});
  lwork = (int) tmp;
  
  return MAX(lwork, 1);
}

static inline SEXP get_L(cint m, cint n, cdbl_r LQ)
{
  SEXP L_;
  const int minmn = MIN(m, n);
  newRmat(L_, m, minmn, "dbl");
  double *const L = DBLP(L_);
  
  memset(L, 0, minmn*m*sizeof(*L));
  for (int j=0; j<minmn; j++)
  {
    for (int i=j; i<m; i++)
      L[i + m*j] = LQ[i + m*j];
  }
  
  return L_;
}

static inline SEXP get_Q(cint m, cint n, dbl_r LQ, dbl_r tau, dbl_r work, cint lwork, int_r info)
{
  SEXP Q;
  const int minmn = MIN(m, n);
  newRmat(Q, minmn, n, "dbl");
  
  dorglq_(&minmn, &n, &minmn, LQ, &m, tau, work, &lwork, info);
  if (*info != 0)
  {
    FREE(work);FREE(tau);FREE(LQ);
    THROW_LAPACKERR(*info);
  }
  
  memcpy(DBLP(Q), LQ, minmn*n * sizeof(*LQ));
  
  return Q;
}



SEXP R_lq(SEXP x, SEXP retl_, SEXP retq_)
{
  SEXP Q;
  SEXP L = R_NilValue; // suppress false positive compiler warning
  int lwork;
  int info;
  double *work, *tau, *LQ;
  
  CHECK_IS_FLAG(retq_, "retq");
  CHECK_IS_FLAG(retl_, "retl");
  
  const bool retq = INT(retq_);
  const bool retl = INT(retl_);
  
  if (!retq && !retl)
    error("at least one of Q or R must be returned");
  
  CHECK_IS_MATRIX(x);
  CHECK_IS_NUMERIC(x);
  
  const int m = nrows(x);
  const int n = ncols(x);
  const int minmn = MIN(m, n);
  
  lwork = worksize(m, n);
  
  work = malloc(lwork * sizeof(*work));
  tau = malloc(minmn * sizeof(*tau));
  LQ = malloc(m*n * sizeof(*LQ));
  if (tau == NULL || work == NULL || LQ == NULL)
  {
    FREE(tau);FREE(work);FREE(LQ);
    THROW_MEMERR;
  }
  
  sexp2dbl(LQ, x, m*n);
  
  
  dgelqf_(&m, &n, LQ, &m, tau, work, &lwork, &info);
  if (info != 0)
  {
    FREE(work);FREE(tau);FREE(LQ);
    THROW_LAPACKERR(info);
  }
  
  if (retl)
    L = get_L(m, n, LQ);
  if (retq)
    Q = get_Q(m, n, LQ, tau, work, lwork, &info);
  
  FREE(work);FREE(tau);FREE(LQ);
  
  if (retq && retl)
  {
    SEXP ret, retnames;
    retnames = make_list_names(2, "Q", "L");
    ret = make_list(retnames, 2, Q, L);
    UNPROTECT(4);
    return ret;
  }
  else
  {
    UNPROTECT(1);
    if (retq)
      return Q;
    else // if (retl)
      return L;
  }
}
