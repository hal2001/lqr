#' LQ
#' 
#' TODO
#' 
#' @details
#' TODO
#' 
#' @param x
#' 
#' @param retl,retq
#' Should L and/or Q be returned?
#' 
#' @return
#' TODO
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
