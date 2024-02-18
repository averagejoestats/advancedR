
# Tools for debugging code

# chapter 22 of Advanced R, Hadley Wickham second edition

# Debugging

# Be methodical and persistent.
# You should have an undefeated record vs known bugs that you want to fix

# recall formula for conditional expectation in multivariate normal
# covariance matrix for Y = [Y1] is S = [ S11 S12 ]
#                           [Y2]        [ S21 S22 ]
#
# conditional expectation of Y2 given Y1 = y1 is S21 S11^-1 y1                        

# define the covariance matrix and a data vector y
n <- 10
A <- matrix( rnorm(n*n), n, n )
S <- A %*% t(A)
y <- A %*% rnorm(n)

# here is a function for conditional expectation that might return an error
cond_exp <- function(S, y, i1, i2){
    y2hat <- S[i2,i1] %*% solve( S[i1,i1], y[i1] )
    return(y2hat)
}

# Exp of last one given first n-1
cond_exp( S, y, 1:(n-1), n )
# Exp of last two given first n-2
cond_exp( S, y, 1:(n-2), (n-1):n )
# Exp of last one given second-to-last
cond_exp( S, y, n-1, n )
# Exp of last last two given third-to-last
cond_exp( S, y, n-2, (n-1):n )
# Ruh-Roh

# How to debug:

# Method 1, define all arguments, evaluate each term to find the problem
i1 <- n-2
i2 <- (n-1):n
S[i2,i1]
S[i1,i1]
y[i1]
solve( S[i1,i1], y[i1] )
S[i2,i1] %*% solve( S[i1,i1], y[i1] )
# ?matmult


# Method 2, add some print statements
cond_exp <- function( S, y, i1, i2 ){
    print( S[i2,i1] )
    print( S[i1,i1] )
    print( y[i1] )
    print( solve( S[i1,i1], y[i1] ) )
    print( dim( S[i2,i1] ) )
    print( dim( solve( S[i1,i1], y[i1] ) ) )
    y2hat <- S[i2,i1] %*% solve( S[i1,i1], y[i1] )
    return(y2hat)
}

cond_exp( S, y, n-2, (n-1):n )

# this is probably better
cond_exp <- function( S, y, i1, i2 ){
    print("S21")
    print( S[i2,i1] )
    print("S11")
    print( S[i1,i1] )
    print("y1")
    print( y[i1] )
    print( solve( S[i1,i1], y[i1] ) )
    print( dim( S[i2,i1] ) )
    print( dim( solve( S[i1,i1], y[i1] ) ) )
    y2hat <- S[i2,i1] %*% solve( S[i1,i1], y[i1] )
    return(y2hat)
}

cond_exp( S, y, n-2, (n-1):n )


# Method 3, debug()
cond_exp <- function( S, y, i1, i2 ){
    y1 <- y[i1]
    S11 <- S[i1,i1]
    S21 <- S[i2,i1]
    y2hat <- S21 %*% solve( S11, y1 )
    return(y2hat)
}

debug( cond_exp )

cond_exp( S, y, n-2, (n-1):n )
# n for "next"
# s for "step" - like next, but enters function if next line is a function
# f for "finish" - if inside a function or loop, finishes it and returns up a level
# c for "continue" - finish execution of the whole function
# Q for "quit"

# evaluation of the function enters debugging mode at beginning of function

# let's fix it
cond_exp <- function( S, y, i1, i2 ){
    y1 <- y[i1]
    S11 <- S[i1,i1,drop=FALSE]
    S21 <- S[i2,i1,drop=FALSE]
    y2hat <- S21 %*% solve( S11, y1 )
    return(y2hat)
}
cond_exp( S, y, n-2, (n-1):n )

# how about that!

# Method 4 (very similar to method 3) - browser()
cond_exp <- function( S, y, i1, i2 ){
    y1 <- y[i1]
    S11 <- S[i1,i1]
    S21 <- S[i2,i1]
    browser()
    y2hat <- S21 %*% solve( S11, y1 )
    return(y2hat)
}
cond_exp( S, y, n-2, (n-1):n )


# Because we redefined the function, the debugger didn't open
# Otherwise, to disable debugging on a function, use
undebug( cond_exp )

# debugger opens at the point for browser is placed


# Method 5 (Rstudio only) - code breakpoints
cond_exp <- function( S, y, i1, i2 ){
    y1 <- y[i1]
    S11 <- S[i1,i1]
    S21 <- S[i2,i1]
    y2hat <- S21 %*% solve( S11, y1 )
    return(y2hat)
}
cond_exp( S, y, n-2, (n-1):n )



# for errors nested deep inside functions, 
# use traceback to see where the error occurred
f1 <- function(x){
    y2 <- f2(x)
    return(y2)
}

f2 <- function(x){
    y1 <- f3(x)
    y2 <- y1 - mean(y1)
    return(y2)
}

f3 <- function(x){
    return(solve(x))
}

f1( matrix(0,2,2) )
traceback()



