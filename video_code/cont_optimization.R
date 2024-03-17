

# Babylonian square roots
g <- function(x, k){ x^2 - k }
g1 <- function(x, k){ 2*x }

k <- 7
x <- 1.0

cat( sprintf( "%11.9f  %11.9f\n", x, x^2 ) )
for(j in 1:10){
    x <- x - g(x,k)/g1(x,k)
    cat( sprintf( "%11.9f  %11.9f\n", x, x^2 ) )
}
    


# newton's method for minimization, univariable
f <- function(x){ exp( 2*x - 4 ) + exp( 2 - x ) }
f1 <- function(x){ 2*exp( 2*x - 4 ) - exp( 2 - x ) }
f2 <- function(x){ 4*exp( 2*x - 4 ) + exp( 2 - x ) }

xvec <- seq(-2,4,by=0.01)
plot( xvec, f(xvec), type = "l" )

x <- rep(NA, 10)
x[1] <- 0
cat( sprintf( "%11.9f  %11.9f\n", x[1], f(x[1]) ) )
for(j in 2:10){
    x[j] <- x[j-1] - f1(x[j-1])/f2(x[j-1])
    cat( sprintf( "%11.9f  %11.9f\n", x[j], f(x[j]) ) )
}
    
plot( xvec, f(xvec), type = "l" )
points( x, f(x), col = "magenta" )

