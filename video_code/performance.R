
# Measuring and Improving Performance in R programs

# In order to make your code run faster and use less memory,
# you need to be able to measure how much resources are used
# by each part of your program.

# After you know which parts are slowest, focus your energy
# on improving the bottlenecks.

# When tinkering with your code, it's important to automatically
# test that your new code gives the same answer as your old code.
# Otherwise, you may end up with faster code that is wrong.


# some general advice on performance in R

# "vectorized" operations are faster
x <- rnorm(1e7)

# start timer
t1 <- proc.time()

# calculate e^x in a loop
y <- rep(NA,length(x))
for(j in 1:length(x)){ y[j] <- exp(x[j]) }

# record time
t2 <- proc.time()

# calculate e^x with vectorized function
y <- exp(x)

# stop timer
t3 <- proc.time()

# print timing results
print(t2-t1)
print(t3-t2)


## appending to objects many times is slow
x <- rnorm(1e5)

t1 <- proc.time()

y <- c()
for(j in 1:length(x)){ y <- c(y, exp(x[j]) ) }

t2 <- proc.time()

print(t2-t1)
# the same applies to rbind and cbind. It's almost always better
# to initialize a vector with NAs and fill it up than to build
# it as you go.


# use the right object for the job
n <- 8000
X <- matrix( rnorm(n*n), n, n )
D <- as.data.frame(X)

t1 <- proc.time()
for(j in 1:10000){
    i1 <- sample(1:n,1)
    i2 <- sample(1:n,1)
    X[i1,i2] <- exp( X[i1,i2] )
}
t2 <- proc.time()
print(t2-t1)


t1 <- proc.time()
for(j in 1:10000){
    i1 <- sample(1:n,1)
    i2 <- sample(1:n,1)
    D[i1,i2] <- exp( D[i1,i2] )
}
t2 <- proc.time()
print(t2-t1)

# apply isn't perfect. use built-in functions when possible
# usually the function defined specifically for your task is
# faster than the more general one
t1 <- proc.time()
y <- apply(X, 2, sum)
t2 <- proc.time()
y <- colSums(X)
t3 <- proc.time()
print(t2-t1)
print(t3-t2)



# suppose we want to quickly build a dataset that has the url for
# the first week each unique song appears on the chart
hot <- read.csv( "../datasets/Hot_100.csv" )
head( hot )


# time the code using proc.time
# we'll use a subset of the hot database because this code is very slow
hot1e4 <- hot[ sample( 1:nrow(hot), 1e4 ), ]
t1 <- proc.time()
source("performance_funs.R")
result1 <- method1( hot1e4 )
t2 <- proc.time()
print(t2-t1)
        
# use profvis to figure out where the slow parts are
library("profvis")
profvis({
    source("performance_funs.R")
    result1 <- method1( hot1e4 )
})

# try method2
profvis({
    source("performance_funs.R")
    result2 <- method2( hot1e4 )
})

# make sure the results are the same
identical( result1, result2 )
all.equal( result1, result2 )

# try not using which
profvis({
    source("performance_funs.R")
    result3 <- method3( hot1e4 )
})
# doesn't help, maybe makes things worse

profvis({
    source("performance_funs.R")
    result4 <- method4( hot1e4 )
})
# makes things worse

identical( result1, result4 )

profvis({
    source("performance_funs.R")
    result5 <- method5( hot1e4 )
})

identical( result5, result1 )
    
profvis({
    source("performance_funs.R")
    result6 <- method6( hot1e4 )
})

identical( result6, result1 )

# use a larger dataset
hot1e5 <- hot[ sample(1:nrow(hot),1e5), ]
profvis({
    source("performance_funs.R")
    result6 <- method6( hot1e5 )
})


debug(method7)
result7 <- method7( hot )
profvis({
    source("performance_funs.R")
    result7 <- method7( hot )
})

source("performance_funs.R")
profvis({
    t1 <- proc.time()
    result8 <- method8( hot )
    print( proc.time() - t1 )
})
    
source("performance_funs.R")
t1 <- proc.time()
result8 <- method8( hot[,c("chart_date","song_id","chart_url")] )
print( proc.time() - t1 )

source("performance_funs.R")
t1 <- proc.time()
result9 <- method9( hot[,c("chart_date","song_id","chart_url")] )
print( proc.time() - t1 )

profvis({
source("performance_funs.R")
t1 <- proc.time()
result10 <- method10( hot[,c("chart_date","song_id","chart_url")] )
print( proc.time() - t1 )
})

profvis({
source("performance_funs.R")
t1 <- proc.time()
result11 <- method11( hot[,c("chart_date","song_id","chart_url")] )
print( proc.time() - t1 )
})

hot_ord <- hot[ order(hot$chart_date), ]

source("performance_funs.R")
t1 <- proc.time()
result12 <- method12( hot_ord[,c("song_id","chart_url")] )
print( proc.time() - t1 )

source("performance_funs.R")
t1 <- proc.time()
result13 <- method13( hot_ord )
print( proc.time() - t1 )

source("performance_funs.R")
t1 <- proc.time()
result14 <- method14( hot )
print( proc.time() - t1 )

source("performance_funs.R")
t1 <- proc.time()
result15 <- method15( hot )
print( proc.time() - t1 )
