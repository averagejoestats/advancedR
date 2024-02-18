
# Tools for handling errors in functions

# chapter 8

# the following function may or may not produce an error

# use 'try' to skip the error


# use tryCatch for more control of how to handle the error
# ?tryCatch

# first let's see what an error condition looks like



# first, let's try lapply
# applies the function 'solve' to each element of matrix_list


# let's make it return something more meaningful


# so far, we haven't actually used the condition to modify how we want
# the function to behave upon receiving one of these errors
# let's inspect the condition object to see if we can use it


# this gives us a hint for how to handle it




# to save computing time, it may be a good idea to loop over your
# matrices, and make sure they are all square, and throw an error if not

# use "stop" to exit the function with an error
# use "warning" to signal something unusual happened, but continue




