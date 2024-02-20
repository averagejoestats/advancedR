

# here are the debugger commands:
# n for "next"
# s for "step" - like next, but enters function if next line is a function
# f for "finish" - if inside a function or loop, finishes it and returns up a level
# c for "continue" - finish execution of the whole function
# Q for "quit"


# debugger is meant for functions, but it can be useful for debugging
# something wrong in a loop

# to have an example to work with, let's try coding up Pascal's triangle
# 1
# 1 1
# 1 2 1
# 1 3 3 1
# 1 4 6 4 1
# and so on
pascals_triangle <- matrix(NA, 6, 6 )






# debug the code below and check that each of the three statistics works after you debug it.
# you should try using the debugger, to get practice with it.

# you can invoke the debugger (a.k.a. browser) by doing debug(rank_songs), or placing
# the code "browser()" at the top of the function, or by putting in a code break in
# Rstudio.



hot <- read.csv("../datasets/Hot_100.csv")

get_unique_songs <- function( dat ){
    return( unique( dat$song_id ) )
}

weeks_on_chart <- function( dat ){
    unique_songs <- get_unique_songs( dat )
    weeks_on_chart <- rep( NA, length(unique_songs) )
    for(j in 1:length( unique_songs ) ){
        ii <- which( dat$song_id == unique_songs )
        weeks_on_chart[i] <- max( dat$weeks_on_chart[ii] )
    }
    ord <- order( weeks_on_chart, decreasing = TRUE )
    return( data.frame( song = unique_songs[ord], weeks_on_chart = weeks_on_chart[ord] ) )
}

weeks_in_top10 <- function( dat ){
    unique_songs <- get_unique_songs( dat )
    weeks_in_top10 <- rep( NA, length( unique_songs ) )
    for(j in 1:length( unique_songs ) ){
        ii <- which( dat$song_id == unique_songs )
        weeks_in_top10[i] <- sum( dat$week_position[ii] <= 10 )
    }
    ord <- order( weeks_in_top10, decreasing = TRUE )
    return( data.frame( song = unique_songs[ord], weeks_in_top10 = weeks_in_top10[ord] ) )
}

weeks_at_num1 <- function( dat ){
    unique_songs <- get_unique_songs( dat )
    weeks_at_num1 <- rep( NA, length( unique_songs ) )
    for(j in 1:length( unique_songs ) ){
        ii <- which( dat$song_id == unique_songs )
        weeks_at_num1[i] <- sum( dat$week_position[ii] <= 10 )
    }
    ord <- order( weeks_in_top10, decreasing = TRUE )
    return( data.frame( song = unique_songs[ord], weeks_at_num1 = weeks_in_top10 ) )
}

rank_songs <- function( dat, stat = "weeks on chart" ){
    if( stat == "weeks on chart"  ){
        rank_db <- weeks_on_chart( dat )
    }
    else if( stat == "weeks in top 10" ){
        rank_db <- weeks_in_top10( dat )
    }
    else if( stat == "weeks at num 1"  ){
        rank_db <- weeks_at_num1( dat  )
    }
    else { stop("unrecognize statistic") }
    return( rank_db )
}


r <- rank_songs( hot, "weeks on chart" )

