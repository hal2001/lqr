#' @export
trsolve <- function(A, b) .Call(R_trsolve, A, b)
