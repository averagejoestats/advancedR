
# https://docs.google.com/document/d/1g6YpoHgvUT28CuFyvB5I6yyC63wvsCrDvt6fwer-0fE/edit


# flight data
# read in the data from one day
dat <- read.csv("../datasets/airline_2019-07-01.csv")
nrow(dat)
ncol(dat)
dim(dat)
head(dat)
str(dat)


# pull out data for tail number 303NV.



# Figure out its path (in order) throughout the day



# add a month_name column to the data frame, giving the english name of the month





# what were the busiest airports on July 1, 2019?



# Which airlines had the most flights? Can you translate the codes?



# How many individual airplanes flew?




# which destinations can be reached non-stop from Ithaca, Syracuse, Elmira, and Binghamton




# how many destinations can be reached in two flights from
# Ithaca, Syracuse, Elmira, and Binghamton
# (ignore timing issues)




# use the data to build up a distance matrix. Each row is an origin
# airport, and each column is a destination airport, and the entries
# of the matrix are the distances between the airports



# compute the distance traveled by tail number 303NV
# check your answer manually by looking at the distance matrix
# Can you access the distances without writing a loop?




# write a function that has tail number as the argument, and returns
# the distance traveled by the plane with that tail number


# write a function that has an origin and destination as arguments.
# The function should look up the distance between the origin and
# destination in your distance matrix and return it. It should return
# NA if the matrix doesn't have a distance for that origin and destination









# write a function that computes the minimum distance between a Origin-Dest pair
# if no connection exists between the pair, find the intermediate destination
# that minimizes the distance. If you can't get from the origin to the destination
# in two trips, return NA








# use your function to compute the minimum distance between every pair of airports
# in one or two flights, and store the result in a matrix.











# create an R object that allows you to easily look up the data
# for a particular tail number


# the object should allow you to access the indices in dat that correspond
# to a specific tail number


# you should also design a way to test whether your object works as it should
# this could simply be another piece of code that accesses the indices in
# a different way.


# if you finish early, see if you can improve the speed of the code that
# creates the object. You can time your code like this
t1 <- proc.time()
# < put your code here >
print( proc.time() - t1 )

