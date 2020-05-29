## Matrix inversion is usually a costly computation
## and there may be some benefit to caching the inverse
## of a matrix rather than compute it repeatedly 
## (there are also alternatives to matrix inversion 
## that we will not discuss here). Your assignment is 
## to write a pair of functions that cache the inverse 
## of a matrix.

## This function creates a special "matrix" object that 
## can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y 
    inv <<- NULL
  }
  get <- function() x
  setInverse <- function(solveMatrix) inv <<- solveMatrix
  setInverse <- function() inv
  list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)

}


## This function computes the inverse of the special
## "matrix" returned by makeCacheMatrix above. If the 
## inverse has already been calculated (and the matrix 
## has not changed), then the cachesolve should retrieve 
## the inverse from the cache.

cacheSolve <- function(x, ...) {
  inv <- x$getInverse()
  if (!is.null(inv)) {
    message('get cached data')
    return(inv)
  }
  data <- x$get()
  inv <- solve(data)
  x$setInverse(inv)
  inv
}
