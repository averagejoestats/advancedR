
# Vectors
#     Atomic Vectors  (This Video)
#         Matrices
#         Arrays
#     Lists           (Next Video)
#         Data Frames


# Atomic Vectors - What we normally consider as a vector in R
a <- 1:20
a

# "atomic" because each element of "a" is indivisible
# has the additional property that all elements are of the same type
typeof(a)
# ?typeof

# logical
b <- c(TRUE, FALSE, FALSE, TRUE)
b
typeof(b)

# integer
a
d <- c( 1L, 2L, 3L )
typeof(d)

# double
e <- c( 5, 8, 3)
typeof(e)
e <- c( 5.3, pi, exp(1) )
e
typeof(e)

# complex
i
1i
g <- 0 + 1i
typeof(g)
typeof( fft( rnorm(10) ) )

# character
f <- c("hello", "there")
f
typeof(f)


# NA, NULL, NaN, -Inf, Inf
#     NA is used to indicate missing values
#     NULL is a generic length-0 object, serving several purposes
a <- c(3.7, NA, 7.2)
a
b <- c(3.7, NULL, 7.2)
b
d <- c(3.7, sqrt(-1), 7.2)
d
e <- c(3.7, Inf, 7.2)
e + 1 

is.na( a )
is.nan( a )
is.nan( b ) 
is.nan( d )
is.finite( a )
is.finite( d )
is.finite( e )
# try these functions on the other objects to see what they return


# if you try to combine types in a vector, R automatically 
# coerces to "higher" type
# logical < integer < double < complex < character
a <- c(TRUE, FALSE)
a
typeof(a)

b <- c( a, 0L )
b
typeof(b)

d <- c( b, 1.0 )
typeof(d)
d

e <- c( d, 0+1i)
e
typeof(e)

f <- c( e, "square root of -1")
f
typeof(f)


# NOTES:
# automatic coercion is a common source of silent bugs
# R does not distinguish between scalar and length-1 vector
# look at how "c" function is used above
# can use '' or "" for strings but most people use ""

# coercion can be useful - some functions do it automatically 
sum( c(TRUE, FALSE, FALSE) )
mean( c(TRUE, FALSE, FALSE) )
nchar( c(1.23, 12, pi, exp(1), "fff" ) ) 


# R has functions for manual coercion
as.integer( c(TRUE, FALSE, FALSE) )
as.character( c(1.23, 12, pi, exp(1) ) )
as.double( c(1L, 2L) )
as.complex( c(1,2) )

# "as" function less often used,
# but could be handy if you have to loop over types stored in variable
as( c(TRUE, FALSE, FALSE), "character" )
as( c(TRUE, FALSE, FALSE), "double" )

# vectors have certain properties
b <- 1:10
b

# length
length( b )

# names
a <- 1:3
a
names(a)

# names can be set with "names" function or specified when vector is created
names(a) <- c("bill", "susan", "jamie")
a
b <- c( bill = 3.5, susan = 9, jamie = 0 )
b
names_a <- names(a)
names_a

# our first example of a replacement function for setting an attribute of an object
# ?names
?names

# also works for length    
b
length(b)
length(b) <- 7
b

# remove names with unname or as.vector
unname(b)
b
b <- unname(b)
b
as.vector(b)

# Exercise: What do as.vector and is.vector do?


# DIGRESSION: <- vs =
# try to use <- when assigning a value to a variable
b = c( bill = 3.5, susan = 9, jamie = 0 )
# vs
b <- c( bill = 3.5, susan = 9, jamie = 0 )
# they do the same thing, but note that = is used for 
# arguments to "c" function

# you actually can use <- in arguments, but this sets a value
b <- c(bill = 3.5, susan = 9, jamie <- 0 )
b
bill
susan
jamie

# This is confusing and not advisable. To keep things straight,
# use  <-  for assignment outside functions,
# use  =   for setting arguments in functions


# dim attribute for matrices
a <- 1:8
length(a)
dim(a)

# a matrix is simply a vector with a "dim" attribute
a
dim(a) <- c(4,3)
dim(a) <- c(4,2)
dim(a)
a
dim(a) <- c(8,1)
a
dim(a) <- NULL
a

# note how values get ordered - this is called "column major" ordering

# can also define matrices directly with "matrix" function
# ?matrix
?matrix
m <- matrix( data = 1:8, nrow = 4, ncol = 2 )
m <- matrix( 1:8, nrow = 4, ncol = 2, byrow = TRUE )
m

colnames(m) <- c("column 1", "column 2" )
m
rownames(m) <- c("r1","r2","r3","r4")
m

colnames(m)
rownames(m)



# "class" function returns c("matrix","array")
class(m)
class(1:8)


# an array is a d-dimensional object for d >= 2
m
dim(m)
dim(m) <- c(2,2,2)
m

# we'll study the purpose of the class of an object later
# for now, you can view it as a way to get info about an object

# recycling: Many R objects use the concept of recycling 
# to fill out objects
matrix( 1:3, 3, 4 )
matrix( 1:3, 4, 3 )
matrix( 1:5, 4, 3 )
matrix(  NA, 4, 3 )

# Exercises:
#     special vectors: factors, dates, date-times

# generic attributes - metadata for R objects
m <- matrix( 1:8, 4, 2 )
attributes(m)

# get and set them with attr function
attr( m, "dim" ) <- c(1,8)
attr( m, "color" ) <- "magenta"
attr( m, "weight in pounds") <- 37.2
attributes(m)



