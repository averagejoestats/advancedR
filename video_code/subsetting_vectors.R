
# subsetting atomic vectors, matrices, and arrays

# atomic vectors
a <- c(1,4,9,16)
a

a[3]
a[ c(3,4) ]
a[ c(4,3) ]
a[ c(1,1,2,2,3) ]
a[ -2 ]
a[ c(-1,-2) ]
a[ c(-1, 2) ]
a[ 6 ]
a[ NA ]
a[ c(3,NA) ]

# named atomic vectors
b <- c( e = exp(1), pi = pi, tau = 2*pi, "3" = 3 )
b
b[1]
b["e"]
b[ c("pi","e") ]
b[ c("pi",3) ]
c("pi",3)
# why doesn't the last one work?

# logical subsetting
b > 4
b[ b > 4 ]
b[ TRUE ]
b[ c(TRUE,FALSE) ]
b[ c(TRUE,FALSE,TRUE) ]
which( b > 4 )
b[ which( b > 4 ) ]

# which vs logical when vector contains missing values
b <- c( b, NA )
b
b > 4 
b[ b > 4 ]
b[ which( b>4 ) ]

# matrices
m <- outer( 1:4, 0.01*(1:3), "+")
m
m[1,2]
m[1:2,2]
m[1:3,2]
m[1:3,2:3]
m[,2]
m[4,]
n <- m[,2]
n
n[3,1]
# be vigilant about R's automatic coercion to vectors
n <- m[,2 , drop=FALSE]
n[3,1]
m[4, , drop = FALSE ]

# treating matrix as a vector
m
m[5]
m[ c(1,6,11) ]
m[ -2 ]
m > 4
m[ m > 4 ]

# multiple-index subsetting
which( m > 4 )
m[ which(m>4) ]

# subset via a matrix of row-column pairs
which( m > 4, arr.ind = TRUE )
ww <- which( m>4, arr.ind = TRUE)
m[ ww ]

# see automatic coercion at work. 
m[ ww[2,] ]
ww[2,]
class( ww[2,] )
m[ ww[2,,drop=FALSE] ]



# arrays
LETTERS[1:12]
arr <- array( letters[1:12], c(2,3,2) ) 
arr
arr[ 2, 1, 2 ]
arr[ 5 ]
arr[ 7 ]

# these look similar but do different things!
arr[2,1,2]
arr[c(2,1,2)]

# make sure it's a matrix
inds <- matrix( c(2,1,2), 1, 3, byrow = TRUE )
inds
arr[ inds ]
inds <- matrix( c(2,1,2, 2,3,1), 2, 3, byrow = TRUE )
inds
arr[inds]


# subsetting and assignment
# vectors
a <- c(1,4,9,16)
a
b <- c(e = exp(1), pi = pi, tau = 2*pi, NA )
b
b[4] <- a[1]
b
names(b)[4] <- "one"
b

b[1:3] <- a[2]
b

b[4] <- a[ c(4,3) ]
b

b[1:4] <- a[c(1,2)]
b

b[ ] <- 0
b
b <- 0
b

# matrices
m <- outer(1:4, 0.01*(1:3), "+" )
m

m[4,3] <- 999
m

m[9] <- 888
m

m[ matrix( c(3,3), 1, 2 ) ] <- -1
m

m[ m < 2 ] <- NA
m


# arrays
arr <- array( letters[1:12], c(2,3,2) )
arr

arr[1,2,1] <- "eee"
arr

arr[ 5 ] <- "ccc"
arr

arr[ ] <- "gone"
arr








