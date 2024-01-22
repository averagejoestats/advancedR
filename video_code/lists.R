
# Vectors
#     Atomic Vectors    (Previous Video)
#         Matrices
#         Arrays
#     Lists             (This Video)
#         Data Frames


# Lists

# Lists are non-atomic vectors. Each element of a list is an R object
# with no restriction that each element must be the same type

# example: dimnames
m <- matrix( 1:8, 4, 2 )
colnames(m) <- c("column 1", "column 2")
rownames(m) <- c("r1","r2","r3","r4")
m

colnames(m)
rownames(m)
dimnames(m)

# The analog to "c" is "list"
a <- c( 1:4, letters[1:10], NULL )
a

a <- list( 1:4, letters[1:10], function(x) x^2, NULL )
a

typeof(a)
class(a)

# Lists can be named
a <- list( 
    my_numbers = 1:4, 
    some_letters = letters[1:6], 
    fun = function(x) log(x) 
)
a
a[[1]]
a$my_numbers

# names works on lists as well
names(a)
typeof( names(a) )

# lists can contain lists!
b <- list( a, rnorm(10) )
b

length(b)
length( b[[1]] )

# Data frames are a special type of list:
# Each list element is a vector of the same length
a <- c("six","afraid","seven")
b <- c(7,8,9)
d <- c(1 + 0i, 0 + 1i, -1 + 0i)

ll <- list( a, b, d )

dat <- data.frame( a, b, d )
dat
typeof( dat$b )

colnames(dat)
rownames(dat)

# these two attributes treat a data frame as a list
length(dat)
names(dat)

typeof(dat)
class(dat)

# other attributes
nrow(dat)
ncol(dat)
nrow(m)
ncol(m)

dimnames(dat)

dat <- data.frame( words = a, reals = b, comps = d )
dat


# as.data.frame converts matrix to a data.frame
m
as.data.frame(m)
class( as.data.frame(m) )


# column names get transferred
m
class(m)
m <- as.data.frame(m)
m
class(m)
colnames(m) <- c("col1","col2")
m

# Tibbles are an alternative data frame with many nice properties
library("tibble")
dat
tib <- as_tibble( dat )
tib <- tibble( words = a, reals = b, comps = d )
tib

dat <- as.data.frame( matrix( rnorm(4000), 200, 20 ) )
dat
tib <- as_tibble( dat )
tib
print( tib, width = 100 )



# Columns need not be atomic vectors!
# used by sf package to include points of a polygon in a data frame
dat <- data.frame(
    city = c("Ithaca","Syracuse","Binghamton"),
    coordinates = I( list( c(42.443,-76.48), c(43.035,-76.136), c(42.097,-75.910) ) )
)
dat
dat$coordinates
    



