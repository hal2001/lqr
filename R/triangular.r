#' trsolve
#' 
#' Solve a triangular system of equations.  This is significantly faster than
#' using \code{solve()}.
#' 
#' @details
#' Using \code{trsolve()} with a general matrix and the \code{uplo} parameter
#' does not result in any data copying.
#' 
#' @param A
#' System of equations. If the matrix is of class \code{triangular}, such as
#' the L and R matrices from \code{LQ()} and \code{QR()} respectively, then
#' only the triangle containing information will be used.  For a general matrix,
#' the triangle specified by \code{uplo} will be used.
#' @param b
#' The "right hand side(s)".
#' @param uplo
#' A character, either "U" or "L" for upper and lower triangle, respectively.
#' This argument is ignored for objects of class \code{triangular} and should
#' only be used when you wish to use one triangle of a general matrix.
#' @param ...
#' Ignored.
#' 
#' @return
#' The solution(s) to the system of equations as a matrix..
#' 
#' @rdname trsolve
#' @export
trsolve <- function (A, b, ...)
{
  UseMethod("trsolve", A)
}

#' @rdname trsolve
#' @method trsolve default
#' @export
trsolve.default <- function(A, b, uplo, ...)
{
  if (!is.matrix(A))
    stop("argument 'A' must be a matrix")
  
  uplo <- match.arg(toupper(uplo), c("U", "L"))
  .trsolve(A, b, uplo)
}

#' @rdname trsolve
#' @method trsolve triangular
#' @export
trsolve.triangular <- function(A, b, ...)
{
  .trsolve(A, b, attr(A, "uplo"))
}



.trsolve <- function(A, b, uplo)
{
  if (is.null(dim(b)))
    dim(b) <- c(length(b), 1)
  
  .Call(R_trsolve, A, b, uplo)
}
