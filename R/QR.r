#' QR
#' 
#' TODO
#' 
#' @details
#' TODO
#' 
#' @param x
#' 
#' @param retq,retr
#' Should Q and/or R be returned?
#' 
#' @return
#' TODO
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
