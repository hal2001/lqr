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
