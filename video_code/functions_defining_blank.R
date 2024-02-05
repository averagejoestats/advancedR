
# Functions
#   how to define and call a function
#   parts of a function
#   calling functions - rules for ordering of multiple arguments
#   variable scoping (next video)


# defining a function

# calling our function

# functions are objects

# 3 parts of a function

# 1. formals (is a function that) returns the arguments.
# what type of object does formals return?

# 2. body returns the body of the function
# ?body

# 3. environment returns the enclosing environment
# we'll come back to this when we talk about variable scoping


# functions can contain attributes, just like vectors

# we can set our own custom attributes


# shortcuts to defining a function

# function automatically returns last object evaluated
# return can be ommitted.
# However, I recommend including return(y) explicitly, for clarity

# assignment to y is unnecessary 

# or more simply

# can be placed on one line if body has only one line

# and brackets can be eliminated if there is only one expression

# general recommendation: make clear what the function computes and returns
# preferred styles may differ among programmers


# SIDENOTE: when does a function print the return value?

# never when assigning

# sometimes when simply calling




# multiple arguments and default values



# define a vector for testing the function




# try passing a function as an argument


# We need to allow the user to pass arguments to the fun
# However, we can't plan for every possibility without
# making the function very complicated
# ... saves the day


# one more thing, do.call can be used when fun is a string
# ?do.call



# there are specific rules for how the arguments you pass get
# assigned to the function arguments

# let's take a look at the plot function
# ?plot

# General rule: unnamed arguments get assigned to first unspecified argument
# x to first argument, y to second, c(0,20) to fourth, "o" to third

# If things become unclear, consider naming each argument explicitly

