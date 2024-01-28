
# create some fake netIDs
n <- 50
let <- function(n){ sample(letters,n,replace=TRUE) }
num <- function(n){ sample(0:9,n,replace=TRUE) }
netID <- paste0( let(n), let(n), let(n), num(n), num(n), num(n) )

length(unique(netID))

# create column names for the gradebook data frame
ex_names <- paste0( "ex", sprintf("%02d",1:12) )
quiz_names <- paste0( "quiz", sprintf("%02d",1:12) )
proj_names <- "project"
ncols <- sum( c(1, length(ex_names), length(quiz_names), length(proj_names) ) )

# create the gradebook and name the columns
grade_book <- as.data.frame( matrix(NA, n, ncols) )
colnames( grade_book ) <- c("netID", ex_names, quiz_names, proj_names )

# for fun, shuffle the columns
grade_book <- grade_book[, sample(1:ncol(grade_book)) ]

# create a netid column
grade_book[["netID"]] <- netID

# simulate the grades
merit <- 0.4*rnorm(nrow(grade_book))
expit <- function(x) exp(x)/(1+exp(x))

for( j in 1:length(ex_names) ){
    probs <- expit( merit + 1.2 + 0.6*rnorm(1,0.6,1.0) )
    grade_book[[ ex_names[j] ]] <- rbinom( n = n, prob = probs, size = 20 )
}

for( j in 1:length(quiz_names) ){
    probs <- expit( merit + 1.2 + 0.6*rnorm(1,0.6,1.0) )
    grade_book[[ quiz_names[j] ]] <- rbinom( n = n, prob = probs, size = 20 )
}

for(j in seq_along(proj_names) ){
    probs <- expit( merit + 1.2 )
    grade_book[[ proj_names[j] ]] <- rbinom( n = n, prob = probs, size = 100 )
}

# set some values to NA
for(j in seq_along(ex_names)){
    num_miss <- rbinom( n = 1, prob = 0.04, size = 50 )
    which_na <- sample( 1:nrow(grade_book), num_miss )
    grade_book[[ ex_names[j] ]][ which_na ] <- NA
}

# save the file
write.csv(grade_book, file = "../datasets/grade_book.csv", row.names = FALSE )
