
# Tools for debugging code

# chapter 22 of Advanced R, second edition

# Debugging

# Be methodical and persistent.
# You should have an undefeated record vs known bugs that you want to fix

# recall formula for conditional expectation in multivariate normal
# covariance matrix for Y = [Y1] is S = [ S11 S12 ]
#                           [Y2]        [ S21 S22 ]
#
# conditional expectation of Y2 given Y1 = y1 is S21 S11^-1 y1                        

# define the covariance matrix and a data vector y

# here is a function for conditional expectation that might return an error

# Exp of last one given first n-1
# Exp of last two given first n-2
# Exp of last one given second-to-last
# Exp of last last two given third-to-last
# Ruh-Roh

# How to debug:

# Method 1, define all arguments, evaluate each term to find the problem
# ?matmult


# Method 2, add some print statements


# this is probably better



# Method 3, debug()

# n for "next"
# s for "step" - like next, but enters function if next line is a function
# f for "finish" - if inside a function or loop, finishes it and returns up a level
# c for "continue" - finish execution of the whole function
# Q for "quit"

# evaluation of the function enters debugging mode at beginning of function

# let's fix it

# how about that!

# Method 4 (very similar to method 3) - browser()


# Because we redefined the function, the debugger didn't open
# Otherwise, to disable debugging on a function, use

# debugger opens at the point for browser is placed



# for errors nested deep inside functions, use traceback to see where the error occurred





