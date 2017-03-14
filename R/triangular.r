#' @export
trsolve <- function (A, ...)
{
  UseMethod("trsolve", A)
}

#' @export
trsolve.default <- function(A, b, uplo)
{
  uplo <- match.arg(toupper(uplo), c("U", "L"))
  .trsolve(A, b, uplo)
}

#' @export
trsolve.triangular <- function(A, b)
{
  .trsolve(A, b, attr(A, "uplo"))
}


.trsolve <- function(A, b, uplo)
{
  if (is.null(dim(b)))
    dim(b) <- c(length(b), 1)
  
  .Call(R_trsolve, A, b, uplo)
}
