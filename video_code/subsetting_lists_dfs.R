
# subsetting lists and data frames

# Lists: [ ] vs [[ ]] vs $
A <- list( 1:4, matrix( NA, 4, 3 ), function(x) x^2 )
A

# [ ] returns a list
A[1]
A[2]
A[3]
A[c(1,2)]

# [[ ]] returns the element of the list
A[[ 1 ]]
A[[ 2 ]]
A[[ 3 ]]

# [[ ]] and [ ] can be combined
A[[ 2 ]][ 4, 3 ]
A[[ 2 ]][ 4, 3 ] <- 0
A[[ 2 ]]

A[[ 3 ]]
A[[ 3 ]]( 7 )

# what does this do? Why [[ 1 ]]?
A[ 2 ][[ 1 ]][ 4,3 ]

# hierarchical indexing
A[[ c(1,2) ]]
A[[ 1 ]][2]
A[ c(1,2) ]

A[[ 1 ]][[ 2 ]]

# wait, why does the [[ 2 ]] work?
a <- (1:4)^2
a
a[2]
a[[2]]

# $elem returns list element named "elem" (if one exists)
A
names(A) <- c("vec","mat","fun")
A

A$vec
A$mat
A$fun

# named lists can also be accessed with [[ ]]
A[1]
A[[1]]
A[ "vec" ]
class( A[ "vec" ] )
A[[ "vec" ]]
class( A[[ "vec" ]] )

# caution: $ does partial matching, [[ ]] does not
A$ma
A[[ "ma" ]]
A[  "ma"  ]
# for this reason I consider [[ ]] to be safer than $
# fewer silent bugs

# assign NULL to eliminate a list element
A <- list( vec = 1:4, mat = matrix(NA, 4, 3), fun = function(x) x^2 )
A$fun <- NULL
A
length(A)
names(A)

A <- list( vec = 1:4, mat = matrix(NA, 4, 3), fun = function(x) x^2 )
A[[ "fun" ]] <- NULL
A

A <- list( vec = 1:4, mat = matrix(NA, 4, 3), fun = function(x) x^2 )
A[[ 3 ]] <- NULL
A

b <- 1:10
b
b[10] <- NULL


# data.frames share behavior of matrices and lists
dat <- data.frame( lets = letters[1:10], nums = 1:10 )
dat

# pull a single element
dat[ 5, 1 ]

# pulling out a column coerces to atomic vector
dat[ , 1 ]
dat[ , 2 ]

# pulling out a row does not
dat[ 5, ]
class( dat[5,] )

# multiple columns
dat[ , c(2,1) ]
class( dat[ , c(2,1) ] )

dat[ , c(2,1,2) ]

# single-index subsetting treats the data.frame as a list
# and does not coerce to an atomic vector
dat[ 1 ]
class( dat[ 1 ] )
dat[[1]]
dat[ c(2,1) ]

# multiple indices treats it as a matrix
dat[5,1]
dat[5,2]


# can combine [ ] with names
dat
dat[ , "lets" ]
dat[ , c("nums","lets") ]
# these behave like matrices

# these behave like lists
dat[ "lets" ]
dat[ 1 ]

# $ works, but beware of partial matching
dat$lets
dat$lets[ 1:4 ]


# [[ ]] works
dat[[ 1 ]]
dat[[ 1 ]][3]
dat[[ c(1,3) ]]   # this works, but not recommended

dat[[ "nums" ]]
dat[[ "nums" ]][ 6 ]


# subset function
# ?subset
subset( dat, subset = nums > 6 )
subset( dat, subset = nums > 6, select = "lets" )

# same as this
dat[ dat$nums > 6, ]
dat[ dat$nums > 6, "lets"]

