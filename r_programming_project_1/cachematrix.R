## The functions below work in tandem with one another to cache matrix
## inverses. By caching the inverse of a matrix after it is computed it is no
## longer necessary to recompute, saving processor time.
## Sample Usage (Try it out!):
##      > source("cachematrix.R")
##      > m1 <- matrix(c(7,0,-3,2,3,4,1,-1,-2), 3, 3)
##      > m1
##           [,1] [,2] [,3]
##      [1,]    7    2    1
##      [2,]    0    3   -1
##      [3,]   -3    4   -2
##      > cm1 <- makeCacheMatrix(m1)
##      > cacheSolve(cm1)
##           [,1] [,2] [,3]
##      [1,]   -2    8   -5
##      [2,]    3  -11    7
##      [3,]    9  -34   21
##      > inv <- cacheSolve(cm1)
##      getting cached data
##      > cinv <- makeCacheMatrix(inv)
##      > cacheSolve(cinv)
##                    [,1] [,2] [,3]
##      [1,]  7.000000e+00    2    1
##      [2,] -8.493206e-15    3   -1
##      [3,] -3.000000e+00    4   -2


## ---------------------------------------------------------------------------
## FUNCTION: makeCacheMatrix
## This function takes a matrix as its input and returns a cache matrix. The 
## cache matrix has the ability to hold its inverse, removing the need for 
## repeated computation.
makeCacheMatrix <- function(x = matrix()) {
	inv <- NULL
	set <- function(y) {
			x <<- y
			inv <<- NULL
	}
	get <- function() x
	setsolve <- function(solve) inv <<- solve
	getsolve <- function() inv
	list(set = set, get = get,
		 setsolve = setsolve,
		 getsolve = getsolve)
}

## ---------------------------------------------------------------------------
## FUNCTION: cacheSolve
## This function takes a cache matrix as input and returns its inverse. If the
## inverse has not been cached in this matrix, this function both computes and
## stores it. If it has been cached, this function simply retrieves it.
cacheSolve <- function(x, ...) {
	## Return a matrix that is the inverse of 'x'
	inv <- x$getsolve()
		if(!is.null(inv)) {
				message("getting cached data")
				return(inv)
		}
		data <- x$get()
		inv <- solve(data, ...)
		x$setsolve(inv)
		inv
}
