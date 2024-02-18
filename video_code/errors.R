
# Tools for handling errors in functions

# chapter 8 of advanced R, second edition

# the following function may or may not produce an error
inverse <- function(M){ solve(M) }
mat <- matrix( 1:10, 5, 2 )
inverse(mat)
mat <- diag( x = 1:5 )
inverse(mat)
mat <- diag( x = rep(0,5) )
inverse(mat)

# use 'try' to skip the error
mat <- diag( x = rep(0,5) )
res <- try( invmat <- inverse(mat) )

mat <- diag( x = rep(2,5) )
res <- try( invmat <- inverse(mat) )


# use tryCatch for more control of how to handle the error
# ?tryCatch

# first let's see what an error condition looks like
library("rlang")
mat <- matrix( 1:10, 5, 2 )
res <- catch_cnd( inverse(mat) )

inverse_list <- function( matrix_list ){
    inverse_list <- list()
    for(j in 1:length(matrix_list)){
        print(j)
        inverse_list[[j]] <- 
            tryCatch(
                expr = { solve( matrix_list[[j]] ) },
                error = function(cnd){ print(cnd) }
            )
    }
    return(inverse_list)
}

matrix_list <- list( diag(x=1:5), diag(x=rep(0,5)), matrix(1:10,5,2) )

# first, let's try lapply
# applies the function 'solve' to each element of matrix_list
ilist <- lapply( matrix_list, solve )
ilist

ilist <- inverse_list( matrix_list )
ilist


# let's make it return something more meaningful
inverse_list <- function( matrix_list ){
    inverse_list <- list()
    for(j in 1:length(matrix_list)){
        print(j)
        inverse_list[[j]] <- 
            tryCatch(
                expr = { solve( matrix_list[[j]] ) },
                error = function(cnd){ 
                    print(cnd) 
                    return(NA)
                }
            )
    }
    return(inverse_list)
}

ilist <- inverse_list( matrix_list )
ilist


# so far, we haven't actually used the condition to modify how we want
# the function to behave upon receiving one of these errors
# let's inspect the condition object to see if we can use it
cnd1 <- catch_cnd( solve(matrix_list[[2]] ) )
str( cnd1 )
cnd1$message
cnd1$call

cnd2 <- catch_cnd( solve(matrix_list[[3]] ) )
str( cnd2 )
cnd2$message
cnd2$call

# this gives us a hint for how to handle it


# let's make it return something more meaningful
grepl( "is exactly singular", cnd1$message )
grepl( "is exactly singular", cnd2$message )
grepl( "must be square", cnd1$message )
grepl( "must be square", cnd2$message )

inverse_list <- function( matrix_list ){
    inverse_list <- list()
    for(j in 1:length(matrix_list)){
        print(j)
        inverse_list[[j]] <- 
            tryCatch(
                expr = { solve( matrix_list[[j]] ) },
                error = function(cnd){
                    if( grepl( "is exactly singular", cnd$message ) ){
                        return( array(NA, dim(matrix_list[[j]]) ) )
                    } else if( grepl( "must be square", cnd$message ) ){
                        stop( cnd$message )
                    } else {
                        stop( cnd$message )
                    }
                }
            )
    }
    return(inverse_list)
}

inverse_list( matrix_list )
matrix_list <- list( diag(x=1:5), diag(x=rep(0,5)), matrix(1:25,5,5) )
ilist <- inverse_list( matrix_list )




# to save computing time, it may be a good idea to loop over your
# matrices, and make sure they are all square, and throw an error if not

# use "stop" to exit the function with an error
# use "warning" to signal something unusual happened, but continue
inverse_list <- function( matrix_list ){
    inverse_list <- list()
    
    for( j in 1:length(matrix_list) ){
        if( nrow( matrix_list[[j]] ) != ncol( matrix_list[[j]] ) ){
            stop( paste( "Matrix", j, "is not square." ) )
        }
    }
    
    for(j in 1:length(matrix_list)){
        print(j)
        inverse_list[[j]] <- 
            tryCatch(
                expr = { solve( matrix_list[[j]] ) },
                error = function(cnd){
                    if( grepl( "is exactly singular", cnd$message ) ){
                        warning(paste("Matrix",j,"is singular"))
                        return( array(NA, dim(matrix_list[[j]]) ) )
                    } else {
                        stop( cnd$message )
                    }
                }
            )
    }
    return(inverse_list)
}

matrix_list <- list( diag(x=1:5), diag(x=rep(0,5)), matrix(1:10,5,2) )
ilist <- inverse_list( matrix_list )
matrix_list <- list( diag(x=1:5), diag(x=rep(0,5)), matrix(1:25,5,5) )
ilist <- inverse_list( matrix_list )



