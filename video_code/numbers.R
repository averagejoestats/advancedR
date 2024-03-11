
# very small double precision numbers
x <- 1
for(j in 1:350){
    x <- x/10
    print(c(j,x))
}

10^(-323)
10^(-324)

2^(-1074)
2^(-1075)

2^(-1073) - 10^(-323)

exp(-745)

# smallest number representable ( about 10^(-324) ) is different from
# the smallest difference between two floating points
( 1 + 10^(-15) ) - 1
( 1 + 10^(-16) ) - 1

( 1000 + 10^(-15) ) - 1000


# accumulation of floating point rounding errors
# when integrating the normal distribution
by <- 0.001
x <- seq(-50,50,by=by)
n <- length(x)
y <- by/sqrt(pi)*exp(-x^2)

sorty <- sort(y)
revsorty <- rev(sort(y))

# add them from left to right (small, then big, then small)
integral <- 0
for(j in 1:n){ integral <- integral + y[j] }
integral - 1

# add up the small ones first
integral <- 0
for(j in 1:n){ integral <- integral + sorty[j] }
integral - 1

# add up the big ones first
integral <- 0
for(j in 1:n){ integral <- integral + revsorty[j] }
integral - 1

# use the sum function
sum(y) - 1
# ?sum


# some more examples
sqrt(2)*sqrt(2) - 2

sqrt(1357)*sqrt(1357) - 1357

sqrt(1358)*sqrt(1358) - 1358

cos(0)
cos(0) - 1 

cos(pi/2)

# sin(x) = x - x^3/6 + ...
# so this error should be roughly 2^(-36)
sin( 2^(-12) ) - 2^(-12)


# errors grow with size of numbers
n <- 2^16
error <- rep(NA, n)
for(j in 1:n){
    error[j] <- sqrt(j)*sqrt(j) - j
}
range( error )
plot(1:n,error)


# but not here. Why not?
n <- 2^16
error <- rep(NA, n)
for(j in 1:n){
    error[j] <- sqrt(j^2)*sqrt(j^2) - j^2 
}
range( error )
plot(1:n,error)


# computing determinants can cause underflow or overflow
mydet <- function(mat){
    ee <- eigen(mat)
    return( prod( ee$values ) )
}

n <- 1000
A <- exp( - abs( outer(1:n, 1:n, "-" ) ) )

mydet(A)
mydet(A/10)
mydet(10*A)

# compute the log determinant instead
mylogdet_bad <- function(mat){
    ee <- eigen(mat)
    return( log( prod( ee$values) ) )
}

mylogdet_good <- function(mat){
    ee <- eigen(mat)
    return( sum( log( ee$values ) ) )
}

mylogdet_bad(A)
mylogdet_good(A)

mylogdet_bad(A/10)
mylogdet_good(A/10)

mylogdet_bad(A*10)
mylogdet_good(A*10)

