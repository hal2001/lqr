#' LQ
#' 
#' Factors a matrix x = LQ, where Q is orthogonal and L is lower triangular.
#' 
#' @details
#' This is cheaper to compute than LQ when m<<n.
#' 
#' The LQ is computed via \code{dgelqf()}.  Q is extracted via \code{dorglq()}.
#' 
#' @param x
#' A numeric matrix.
#' @param retl,retq
#' Should L and/or Q be returned?
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
#' m <- 3
#' n <- 10
#' x <- matrix(rnorm(m*n), m, n)
#' 
#' L <- LQ(x, retq=FALSE)
#' 
#' Q <- LQ(x, retl=FALSE)
#' 
#' LandQ <- LQ(x)
#' 
#' # error!
#' neither <- LQ(x, retl=FALSE, retq=FALSE)
#' }
#' 
#' @export
LQ <- function(x, retl=TRUE, retq=TRUE) .Call(R_lq, x, retl, retq)
