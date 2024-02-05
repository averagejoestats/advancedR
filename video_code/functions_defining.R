
# Functions
#   how to define and call a function
#   parts of a function
#   calling functions - rules for ordering of multiple arguments
#   variable scoping (next video)


# defining a function
square <- function(x){
    # square the argument and assign to y
    y <- x^2
    # return the value
    return(y)
}

# calling our function
square
square(4)
a <- square(4)
a

# functions are objects
fun <- square
fun(4)

# 3 parts of a function

# 1. formals (is a function that) returns the arguments.
# what type of object does formals return?
formals( square )
class( formals )

# 2. body returns the body of the function
# ?body
body( square )
class( body( square ) )

# 3. environment returns the enclosing environment
# we'll come back to this when we talk about variable scoping
environment( square )

# functions can contain attributes, just like vectors
attributes( square )
attributes( square )$srcref
attr( square, "srcref" )

# we can set our own custom attributes
attr( square, "type" ) <- "polynomial"
attributes(square)


# shortcuts to defining a function

# function automatically returns last object evaluated
# return can be omitted.
square <- function(x){
    y <- x^2
}
square(4)
a <- square(4)
a
# However, I recommend including return(y) explicitly, for clarity

# assignment to y is unnecessary 
square <- function(x){
    return( x^2 )
}
square(4)

# or more simply
square <- function(x){
    x^2
}
square(4)

# can be placed on one line if body has only one line
square <- function(x){ x^2 }
square(4)

# and brackets can be eliminated if there is only one expression
square <- function(x) x^2
square(4)

# general recommendation: make clear what the function computes and returns
# preferred styles may differ among programmers


# SIDENOTE: when does a function print the return value?

# never when assigning
z <- square(3)
z

# sometimes when simply calling
square <- function(x){ x^2 }
square(3)

square <- function(x){ y <- x^2 }
square(3)

square <- function(x){ return( y <- x^2 ) }
square(3)

# multiple arguments and default values
center1 <- function(x, fun = "mean", p = 0.5 ){
    
    if( fun == "mean" ){
        x0 <- x - mean(x)
    } else if( fun == "median" ){
        x0 <- x - median(x)
    } else if( fun == "quantile" ){
        x0 <- x - quantile(x, probs = p )
    } else {
        stop("unrecognized function name")
    }
    return(x0)
    
}

# define a vector for testing the function
y <- (1:9)^2
y

mean(y)
center1()
center1(y)
center1(y, fun = "mean" )

median(y)
center1(y, fun = "median" )

quantile(y, probs = 0.5)
center1(y, fun = "quantile" )

quantile(y, probs = 0.25)
center1(y, fun = "quantile", p = 0.25 )


# try passing a function as an argument
center2 <- function(x, fun = mean, p = 0.5){
    x0 <- x - fun(x)
    return(x0)
}

center2(y)
center2(y, fun = median )
center2(y, fun = quantile )
debug( center2 )
center2(y, fun = quantile )
undebug(center2)
center2(y, fun = quantile, p = 0.5 )

# We need to allow the user to pass arguments to the fun
# However, we can't plan for every possibility without
# making the function very complicated
# ... saves the day
center3 <- function(x, fun = mean, ...){
    x0 <- x - fun(x, ...)
    return(x0)
}

center3(y)
center3(y, median)    
center3(y, quantile)
center3(y, quantile, probs = 0.5)
center3(y, quantile, probs = 0.25)


# one more thing, do.call can be used when fun is a string
# ?do.call
do.call( "mean", list(y) )
do.call( "quantile", list(y, probs = 0.25) )

center4 <- function(x, fun = "mean", ... ){
    print(list(x,...))
    x0 <- x - do.call( fun, list(x,...) )
    return(x0)
}

center4(y)
center4(y, "median" )
center4(y, "quantile", probs = 0.25 )


# there are specific rules for how the arguments you pass get
# assigned to the function arguments
?seq
x <- seq(0,1,by=0.1)
seq(0,1,length.out=5)


# let's take a look at the plot function
# ?plot
#?plot
y <- x + rnorm(length(x))
plot(x,y)
plot(x,y, "o")
plot(x,y, xlim = c(0,1.5), "o" )


# General rule: unnamed arguments get assigned to first unspecified argument
# x to first argument, y to second, c(0,20) to fourth, "o" to third

# If things become unclear, consider naming each argument explicitly
plot(x,y, xlim = c(0,1.5), type = "o" )

