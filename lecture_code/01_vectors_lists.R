
# look at the course repo.

# make a new directory for your personal version of the files

# how to pull new files

# what to do if you have a conflict


# Course tip: attempt at least 1 part of 1 exercise before tuesday class


# R function documentation
# - tip: don't guess wildly
?seq
typeof( seq( 1, 10 ) )
typeof( 1:10 )
typeof( c(1,2,3,4,5,6,7,8,9,10) )

seq_len( 7 )
seq_along( rnorm(10) )
seq_along( numeric(0) )

a <- rnorm(10)
1:length(a)

a <- numeric(0)
1:length(a)


# atomic vector automatic coercion
# - accidental coercion
# - intentional coercion (sum use case)

a <- c(1.3, 6.8, 4.3 )
b <- c( a, 1L )
typeof(b[1])
typeof(b[4])
typeof(b)

d <- c( b, "9.2" )
d

b
as.character(b)
b
b <- as.character(b)
b

a
typeof( sum( a > 4 ) )
typeof( sum( as.integer( a > 4 ) ) )

# matrix examples



# list examples
list()
c()


















