
# Functions
#   how to define and call a function
#   parts of a function
#   calling functions - rules for ordering of multiple arguments
#   variable scoping (this video)


# lexical scoping: determines how R looks up values of objects
x_times_y <- function(x,y){
    return( x*y )
}
x_times_y( 3, 4 )

times_y <- function(x){
    return( x*y )
}
times_y(3)

y <- 4
times_y(3)

# what happens here? times_y uses the x passed to the function (4),
# then it does not see y, so it looks one level up, grabs y(3).
y <- 8
times_y(3)

# when a function is defined, it records the environment 
# it was defined in
environment( times_y )
ls()
environment()
environment()$y

# when a function is called, it creates a new sub-environment
times_y <- function(x){
    
    e1 <- environment()
    e0 <- parent.env( e1 )
    
    print(e1)
    print(e0)
    
    print( ls( e1 ) )
    print( ls( e0 ) )
    
    x*y
}

times_y(3)
rm(y)
times_y(3)


# things can get complicated when a function returns a function
f <- function(){
    print(environment())
    g <- function(x) x^2
    return( g )
}

environment(f)

g1 <- f()
environment(g1)

g2 <- f()
environment(g2)

g2(3)


# see if you can figure out what's going on in f1 and f2
f1 <- function(x){
    print( environment() )
    g <- function() x*y
    return( g )
}

y <- 3
g <- f1(4)
g()

environment(g)
ls( environment(g) )
environment(g)$x

y <- 8
g()


f2 <- function(x){
    z <- x*y
    g <- function() z
    return( g )
}

y <- 3
g1 <- f2(3)
g1()

y <- 8
g1()
g1
environment(g1)$z

g2 <- f2(3)
g2()
environment(g2)$z





