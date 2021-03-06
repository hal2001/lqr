% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/triangular.r
\name{trsolve}
\alias{trsolve}
\alias{trsolve.default}
\alias{trsolve.triangular}
\title{trsolve}
\usage{
trsolve(A, b, ...)

\method{trsolve}{default}(A, b, uplo, ...)

\method{trsolve}{triangular}(A, b, ...)
}
\arguments{
\item{A}{System of equations. If the matrix is of class \code{triangular}, such as
the L and R matrices from \code{LQ()} and \code{QR()} respectively, then
only the triangle containing information will be used.  For a general matrix,
the triangle specified by \code{uplo} will be used.}

\item{b}{The "right hand side(s)".}

\item{...}{Ignored.}

\item{uplo}{A character, either "U" or "L" for upper and lower triangle, respectively.
This argument is ignored for objects of class \code{triangular} and should
only be used when you wish to use one triangle of a general matrix.}
}
\value{
The solution(s) to the system of equations as a matrix..
}
\description{
Solve a triangular system of equations.  This is significantly faster than
using \code{solve()}.
}
\details{
Using \code{trsolve()} with a general matrix and the \code{uplo} parameter
does not result in any data copying.
}
