#' lm_fit
#' 
#' Basic linear model fitter.
#' 
#' @param x
#' Feature matrix.
#' @param  y
#' Response variable.
#' 
#' @return
#' A list containing the coefficients, residuals, and effects of the model.
#' 
#' @export
lm_fit <- function(x, y)
{
  if (nrow(x) >= ncol(x))
  {
    qr <- QR(x)
    Q <- qr$Q
    coef <- trsolve(qr$R, crossprod(Q,  y))
  }
  else
  {
    lq <- LQ(x)
    Q <- lq$Q
    coef <- crossprod(Q,  trsolve(lq$L, y))
  }
  
  resid <- y - x %*% coef
  eff <- crossprod(Q, y)
  
  
  list(coefficients=coef, residuals=resid, effects=eff)
}
