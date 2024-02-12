
# Input
#   read.table, read.csv, etc, read_delim
#   load, readRDS
# Output
#   print, cat, sprintf
#   write.table, write.csv
#   save, saveRDS 


# R is designed for data analysis, so it includes many tools for 
# reading and writing data

# read.* functions - for reading rectangular datasets (data tables)
# ?read.table
dat <- read.table("../datasets/marathon_women.csv",header=TRUE,sep=",")
class(dat)
typeof(dat)
head(dat)


# read.csv uses comma delimiter and defaults to header = TRUE
dat <- read.csv("../datasets/marathon_women.csv")
head(dat)

# there are tidy alternatives that produce a tibble 
# (read_delim, read_csv, etc.)
library("readr")
dat <- read_csv("../datasets/marathon_women.csv")
dat

# scan and readLines are functions with more options giving more control


# like matlab and some other languages, R has its own data 
# formats, .RData and .rds, which compress and store R objects

# use load to read in a .RData file that was saved with "save" 
# function (see below) NOTE: no assignment is made when calling load
ls()
load("../datasets/my_list.RData") # loads object called 'mylist'
ls()
mylist

# .RData can hold multiple objects
# loading will overwrite existing objects of same name
load("../datasets/multiple_objects.RData")
ls()
obj1
obj2
obj3

# rds is a safer, but less often used, alternative
# assigns to an object, allows only one object to be saved
# note the warning about file format in documentation
infoRDS( "../datasets/my_list.rds")
ls()
readRDS( "../datasets/my_list.rds")
ls()
my_list <- readRDS( "../datasets/my_list.rds")
ls()
my_list

# .RData and .rds use compression to reduce file sizes
# (note: look at file sizes of marathon_women.csv and 
# marathon_women.RData)




# Output

# Easiest way to produce output is through the print function
print(my_list)
# print is called when the object name is entered in the console
my_list

# need to explicitly call print when invoked inside of 
# loops and functions.
for(j in 1:3){ my_list }

prints_nothing <- function(){
    my_list
    return(NULL)
}
prints_nothing()
sv <- prints_nothing()

for(j in 1:3){ print( my_list ) }

prints_something <- function(){
    print(my_list)
    return(NULL)
}
prints_something()
sv <- prints_something()

# quiz yourself: why does this print the list?
prints_something <- function(){ my_list }
prints_something()
sv <- prints_something()
sv


# print is an example of a Generic Function
# ?print
# print.<TAB>
# looks at the class of an object, then calls print.<class>

# quick digression: S3 is one of R's three object-oriented 
# programming systems to use it, define a method (a function) 
# for a class and generic function the class is defined as soon 
# as the method is defined
print.diagmat <- function(d){ print(diag(x=d)) }

# d is just a plain old atomic vector
d <- 1:10
d
class(d) <- "diagmat"
print(d)
d[1,3]
# now it's a diagmat object!
# for nicer example of printing sparse matrices, see the Matrix package
Matrix::Diagonal( x = 1:10 )

# "print" is flexible because you can define your own classes and 
# methods for it but most of the time you don't want to go through 
# the trouble. "cat" is the function for printing text to the console
# ?cat
print("Hello, darkness, my old friend")
cat("Hello, darkness, my old friend")
cat("Hello, darkness, my old friend\n")
cat("Hello, darkness, my old friend\nI've come to talk with you again\n")
cat("\nHello, darkness, my old friend\nI've come to talk with you again\n\n")

# note that cat is different from print here
lyrics <- "\nHello, darkness, my old friend\nI've come to talk with you again\n\n"
print(lyrics)

# cat is often combined with functions for creating character strings

# paste and paste0
# ?paste
first <- "Joe"
last <- "Montana"
paste(first, last)
paste0(first, last)
paste0(first, " ", last )
paste(last, first, sep = ", " )

# combine with cat
cat( paste( first, last, "\n\n" ) )

# cat returns NULL
sv <- cat( paste( first, last, "\n\n" ) )
lyrics
sv <- print(lyrics)

# vectors
first <- c("Joe","Hannah","Tony")
last <- c("Montana","Montana","Montana")
sv <- paste( first, last )
sv
sv[1]
sv[2]

# recycling
last <- "Montana"
paste(first, last)
cat( paste(first,last))
paste(first, last, "\n")
cat( paste(first, last, "\n") )



# use sprintf for more control
# ?sprintf
first <- "Joe"
last <- "Montana"
sprintf( "%s %s\n", first, last )
sprintf( "%s    %s\n", first, last )
sprintf( "%10s %8s\n", first, last )
sprintf( "%10s %10s\n", first, last )




# sprintf accepts vectors and uses recycling
first <- c("Joe","Hannah","Tony")
last <- "Montana"
sprintf( "%s %s\n", first, last )
cat( sprintf( "%s %s\n", first, last ) )
cat( sprintf( "%10s %10s\n", first, last ) )

first <- "Joe"
num <- 4
team <- "San Francisco 49ers"
sprintf( 
    "%s %s won %d Super Bowl titles with the %s.\n", 
    first, last, num, team 
)
cat(sprintf( 
    "%s %s won %d Super Bowl titles with the %s.\n", 
    first, last, num, team 
))

pct <- 62.7
cat(sprintf( "%s %s compated %f% of his passes.\n" , first, last, pct ))
cat(sprintf( "%s %s compated %f%% of his passes.\n" , first, last, pct ))
cat(sprintf("%s %s compated %4.1f%% of his passes.\n",first,last,pct))
cat(sprintf("%s %s compated %8.1f%% of his passes.\n",first,last,pct))
cat(sprintf("%s %s compated %1.1f%% of his passes.\n",first,last,pct))
cat(sprintf("%s %s compated %4.2f%% of his passes.\n",first,last,pct))


# use collapse to combine into one string if desired
first <- c("Joe","Hannah","Tony")
last <- "Montana"
sprintf( "%s %s\n", first, last )
cat( sprintf( "%s %s\n", first, last ) )
paste( sprintf( "%s %s\n", first, last ), collapse = " || " )



# writing to files
dat_women <- read.csv( "../datasets/marathon_women.csv")
head(dat_women)
dat_men <- read.csv( "../datasets/marathon_men.csv")
head(dat_men)

dat_women$sex <- "female"
dat_women[["sex"]] <- "female"
head(dat_women)

dat_men$sex <- "male"

dat_both <- rbind( dat_women, dat_men )
head( dat_both )
tail( dat_both )


# use write.csv to write a csv file
write.csv( dat_both, file = "../datasets/marathon_both.csv" )
# look at the file
# ?write.csv
write.csv( 
    dat_both, 
    file = "../datasets/marathon_both.csv", 
    row.names = FALSE 
)

# saving R objects with save and saveRDS

# use .RData file extension with save
mylist <- list( vec=1:4, mat=matrix(1:8, 4, 2), fun=function(x) x^2)
mylist
save( mylist, file = "../datasets/my_list.RData" )
rm(mylist)
mylist
load("../datasets/my_list.RData")
mylist

# save multiple objects
obj1 <- mylist[[1]]
obj2 <- mylist[[2]]
obj3 <- mylist[[3]]
save( obj1, obj2, obj3, file = "../datasets/multiple_objects.RData" )

# saveRDS supports saving only a single file
# use .rds extension
saveRDS( mylist, file = "../datasets/my_list.rds" )


# save and saveRDS use compression to reduce file sizes
dat_RData <- read.csv("../datasets/marathon_women.csv")
save( dat_RData, file = "../datasets/marathon_women.RData")
# look at the file sizes

    
    
    
    
    
    
    
    
    





