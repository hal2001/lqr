/* Automatically generated. Do not edit by hand. */
  
  #include <R.h>
  #include <Rinternals.h>
  #include <R_ext/Rdynload.h>
  #include <stdlib.h>

extern SEXP R_lq(SEXP x, SEXP retl_, SEXP retq_);
extern SEXP R_qr(SEXP x, SEXP retq_, SEXP retr_);
extern SEXP R_trsolve(SEXP A, SEXP b, SEXP uplo);

static const R_CallMethodDef CallEntries[] = {
  {"R_lq", (DL_FUNC) &R_lq, 3},
  {"R_qr", (DL_FUNC) &R_qr, 3},
  {"R_trsolve", (DL_FUNC) &R_trsolve, 3},
  {NULL, NULL, 0}
};

void R_init_lqr(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
