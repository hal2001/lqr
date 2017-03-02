#' QR
#' 
#' Factors a matrix x = QR, where Q is orthogonal and R is upper triangular.
#' 
#' @details
#' This is cheaper to compute than LQ when m>>n.
#' 
#' The QR is computed via \code{dgeqrf()}.  Q is extracted via \code{dorgqr()}.
#' 
#' @param x
#' A numeric matrix.
#' @param retq,retr
#' Should Q and/or R be returned?
#' 
#' @return
#' If both \code{retq} and \code{retr}, then a list containing \code{Q} and
#' \code{R} is returned.  Otherwise, just the requested object is returned.
#' If neither \code{retq} and \code{retr} is \code{TRUE}, then the function
#' errors.
#' 
#' @examples
#' \dontrun{
#' library(lqr)
#' m <- 10
#' n <- 3
#' x <- matrix(rnorm(m*n), m, n)
#' 
#' Q <- QR(x, retr=FALSE)
#' 
#' R <- QR(x, retq=FALSE)
#' 
#' QandR <- QR(x)
#' 
#' # error!
#' neither <- QR(x, retq=FALSE, retr=FALSE)
#' }
#' 
#' @export
QR <- function(x, retq=TRUE, retr=TRUE) .Call(R_qr, x, retq, retr)
