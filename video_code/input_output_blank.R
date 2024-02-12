
# Input
#   read.table, read.csv, etc, read_delim
#   load, readRDS
# Output
#   print, cat, sprintf
#   write.table, write.csv
#   save, saveRDS 


# R is designed for data analysis, so it includes many tools for reading and writing data

# read.* functions - for reading rectangular datasets (data tables)
# ?read.table

# read.csv uses comma delimiter and defaults to header = TRUE

# there are tidy alternatives that produce a tibble (read_delim, read_csv, etc.)

# scan and readLines are functions with more options giving more control


# like matlab and some other languages, R has its own data formats, .RData and .rds,
# which compress and store R objects

# use load to read in a .RData file that was saved with "save" function (see below)
# NOTE: no assignment is made when calling load

# .RData can hold multiple objects
# loading will overwrite existing objects of same name


# rds is a safer, but less often used, alternative
# assigns to an object, allows only one object to be saved
# note the warning about file format in documentation


# .RData and .rds use compression to reduce file sizes
# (note: look at file sizes of marathon_women.csv and marathon_women.RData)




# Output

# Easiest way to produce output is through the print function
# print is called when the object name is entered in the console

# need to explicitly call print when invoked inside of loops and functions.




# quiz yourself: why does this print the list?


# print is an example of a Generic Function
# ?print
# print.<TAB>
# looks at the class of an object, then calls print.<class>

# quick digression: S3 is one of R's three object-oriented programming systems
# to use it, define a method (a function) for a class and generic function
# the class is defined as soon as the method is defined

# d is just a plain old atomic vector

# now it's a diagmat object!
# for nicer example of printing sparse matrices, see the Matrix package

# "print" is flexible because you can define your own classes and methods for it
# but most of the time you don't want to go through the trouble
# "cat" is the function for printing text to the console
# ?cat

# note that cat is different from print here

# cat is often combined with functions for creating character strings

# paste and paste0
# ?paste

# combine with cat

# cat returns NULL

# vectors

# recycling

# use sprintf for more control
# ?sprintf



# sprintf accepts vectors and uses recycling

# use collapse to combine into one string if desired



# writing to files




# use write.csv to write a csv file
# look at the file
# ?write.csv


# saving R objects with save and saveRDS

# use .RData file extension with save

# save multiple objects

# saveRDS supports saving only a single file
# use .rds extension

# save and saveRDS use compression to reduce file sizes
# look at the file sizes
