#ifndef __SEXP2DBL_H__
#define __SEXP2DBL_H__


static inline void sexp2dbl(double *const restrict dest, SEXP src, const int len)
{
  if (TYPEOF(src) == REALSXP)
    memcpy(dest, DBLP(src), len*sizeof(*dest));
  else if (TYPEOF(src) == INTSXP)
  {
    const int *const restrict src_pt = INTP(src);
    for (int i=0; i<len; i++)
      dest[i] = (double) src_pt[i];
  }
  else
    error("internal error in sexp2dbl(): src not a numeric type\n");
}


#endif
