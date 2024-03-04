
# Method 1, look over whole dataset, building up a database
# of songs and urls
method1 <- function(hot){

    unique_song_ids <- c()
    first_url <- c()

    # loop over the all rows in the dataset
    for(j in 1:nrow(hot)){
    
        # check whether song_id is already in unique_song_ids
        this_song_id <- hot[j,"song_id"]
        in_vector <- FALSE
    
        for(k in seq_along(unique_song_ids)){
            
            if( unique_song_ids[k] == this_song_id ){
                in_vector <- TRUE
            }
    
        }
    
        if( !in_vector ){
    
            # find indices for this song_id
            inds <- which( hot$song_id == this_song_id )
    
            # create a sub-data frame
            subhot <- hot[inds,]
    
            # find the minimum week
            row_minweek <- which( subhot$chart_date == min(subhot$chart_date) )
            
            # update unique songs and urls
            unique_song_ids <- c(unique_song_ids, this_song_id )
            first_url <- c(first_url, subhot$chart_url[ row_minweek ] )
        }
    }
    return( list(unique_song_ids=unique_song_ids, first_url=first_url) )
}
                       

# Method 2, same as method 1, faster way to check
# whether song already in list
method2 <- function(hot){

    unique_song_ids <- c()
    first_url <- c()

    for(j in 1:nrow(hot)){
    
        # check whether song_id is already in unique_song_ids
        this_song_id <- hot[j,"song_id"]
        in_vector <- this_song_id %in% unique_song_ids

        if( !in_vector ){
    
            # find indices for this song_id
            inds <- which( hot$song_id == this_song_id )
    
            # create a sub-data frame
            subhot <- hot[inds,]
    
            # find the minimum week
            row_minweek <- which( subhot$chart_date == min(subhot$chart_date) )
            
            # update unique songs and urls
            unique_song_ids <- c(unique_song_ids, this_song_id )
            first_url <- c(first_url, subhot$chart_url[ row_minweek ] )
        }
    }
    return( list(unique_song_ids=unique_song_ids, first_url=first_url) )
}
                       
# Method 3, same as method 2, don't use which
method3 <- function(hot){

    unique_song_ids <- c()
    first_url <- c()

    for(j in 1:nrow(hot)){
    
        # check whether song_id is already in unique_song_ids
        this_song_id <- hot[j,"song_id"]
        in_vector <- this_song_id %in% unique_song_ids

        if( !in_vector ){
    
            # find indices for this song_id
            inds <- hot$song_id == this_song_id
    
            # create a sub-data frame
            subhot <- hot[inds,]
    
            # find the minimum week
            row_minweek <- which( subhot$chart_date == min(subhot$chart_date) )
            
            # update unique songs and urls
            unique_song_ids <- c(unique_song_ids, this_song_id )
            first_url <- c(first_url, subhot$chart_url[ row_minweek ] )
        }
    }
    return( list(unique_song_ids=unique_song_ids, first_url=first_url) )
}
                       

# Method 4, use factors instead of string comparisons
method4 <- function(hot){

    # new line here!
    hot$song_id <- as.factor( hot$song_id )
    #
    
    unique_song_ids <- c()
    first_url <- c()

    for(j in 1:nrow(hot)){
    
        # check whether song_id is already in unique_song_ids
        this_song_id <- hot[j,"song_id"]
        in_vector <- this_song_id %in% unique_song_ids

        if( !in_vector ){
    
            # find indices for this song_id
            inds <- which( hot$song_id == this_song_id )
    
            # create a sub-data frame
            subhot <- hot[inds,]
    
            # find the minimum week
            row_minweek <- which( subhot$chart_date == min(subhot$chart_date) )
            
            # update unique songs and urls
            unique_song_ids <- c(unique_song_ids, this_song_id )
            first_url <- c(first_url, subhot$chart_url[ row_minweek ] )
        }
    }
    return( list(unique_song_ids=unique_song_ids, first_url=first_url) )
}
                       

# Method 5, fix method 4
method5 <- function(hot){

    hot$song_id_factor <- as.factor( hot$song_id )

    unique_song_ids <- c()
    first_url <- c()

    for(j in 1:nrow(hot)){
    
        # check whether song_id is already in unique_song_ids
        this_song_id <- hot[j,"song_id"]
        this_song_id_factor <- hot[j,"song_id_factor"]
        in_vector <- this_song_id %in% unique_song_ids

        if( !in_vector ){
    
            # find indices for this song_id
            inds <- which( hot$song_id_factor == this_song_id_factor )
    
            # create a sub-data frame
            subhot <- hot[inds,]
    
            # find the minimum week
            row_minweek <- which( subhot$chart_date == min(subhot$chart_date) )
            
            # update unique songs and urls
            unique_song_ids <- c(unique_song_ids, this_song_id )
            first_url <- c(first_url, subhot$chart_url[ row_minweek ] )
        }
    }
    return( list(unique_song_ids=unique_song_ids, first_url=first_url) )
}
                       

# Method 6, no factors
method6 <- function(hot){

    hot$song_id_numeric <- as.numeric( as.factor( hot$song_id ) )

    unique_song_ids <- c()
    first_url <- c()

    for(j in 1:nrow(hot)){
    
        # check whether song_id is already in unique_song_ids
        this_song_id <- hot[j,"song_id"]
        this_song_id_numeric <- hot[j,"song_id_numeric"]
        in_vector <- this_song_id %in% unique_song_ids

        if( !in_vector ){
    
            # find indices for this song_id
            inds <- which( hot$song_id_numeric == this_song_id_numeric )
    
            # create a sub-data frame
            subhot <- hot[inds,]
    
            # find the minimum week
            row_minweek <- which( subhot$chart_date == min(subhot$chart_date) )
            
            # update unique songs and urls
            unique_song_ids <- c(unique_song_ids, this_song_id )
            first_url <- c(first_url, subhot$chart_url[ row_minweek ] )
        }
    }
    return( list(unique_song_ids=unique_song_ids, first_url=first_url) )
}
                       

# Method 7, use the split function
method7 <- function(hot){

    split_hot <- split(hot, hot$song_id )

    unique_song_ids <- rep(NA, length(split_hot))
    first_url <- rep(NA, length(split_hot))

    for(j in 1:length(split_hot)){
        unique_song_ids[j] <- split_hot[[j]]$song_id[1]
        min_ind <- which( 
            split_hot[[j]]$chart_date == min(split_hot[[j]]$chart_date ) 
        )
        first_url[j] <- split_hot[[j]]$chart_url[min_ind]
    }

    return( list(unique_song_ids=unique_song_ids, first_url=first_url) )

}
                       
# Method 8, use the split function, 
# presort so we don't have to search for min
method8 <- function(hot){

    cat("calculating date\n")
    hot$chart_date <- as.Date( hot$chart_date )
    cat("getting ordering\n")
    ord <- order( hot$chart_date )
    cat("reordering hot\n")
    hot_ord <- hot[ord,]

    cat("splitting\n")
    split_hot <- split(hot_ord, hot$song_id )

    unique_song_ids <- rep(NA, length(split_hot))
    first_url <- rep(NA, length(split_hot))

    cat("looping\n")
    for(j in 1:length(split_hot)){
        unique_song_ids[j] <- split_hot[[j]]$song_id[1]
        first_url[j] <- split_hot[[j]]$chart_url[1]
    }

    cat("returning\n")
    return( list(unique_song_ids=unique_song_ids, first_url=first_url) )

}
                       

# Method 9, squeeze a little juice out
method9 <- function(hot){

    cat("calculating date\n")
    hot$chart_date <- as.Date( hot$chart_date )
    cat("getting ordering\n")
    ord <- order( hot$chart_date )
    cat("reordering hot\n")
    hot_ord <- hot[ord,]

    cat("splitting\n")
    split_hot <- split(hot_ord[,c("song_id","chart_url")], hot$song_id )

    unique_song_ids <- rep(NA, length(split_hot))
    first_url <- rep(NA, length(split_hot))

    cat("looping\n")
    for(j in 1:length(split_hot)){
        unique_song_ids[j] <- split_hot[[j]]$song_id[1]
        first_url[j] <- split_hot[[j]]$chart_url[1]
    }

    cat("returning\n")
    return( list(unique_song_ids=unique_song_ids, first_url=first_url) )

}
                       

# Method 10, tapply
method10 <- function(hot){

    hot$chart_date <- as.Date( hot$chart_date )
    ord <- order( hot$chart_date )
    hot_ord <- hot[ord,]
    first_url <- tapply(hot_ord$chart_url, hot_ord$song_id, function(x) x[1] )

    return(first_url)

}
                       

# Method 11, can we go faster?
method11 <- function(hot){

    #hot$chart_date <- as.Date( hot$chart_date )
    ord <- order( hot$chart_date )
    hot_ord <- hot[ord,]
    first_url <- tapply(hot_ord$chart_url,hot_ord$song_id,function(x) x[1] )
    return(first_url)

}
                       
# Method 12, assume already ordered
method12 <- function(hot){

    first_url <- tapply( hot$chart_url, hot$song_id, function(x) x[1] )

    return(first_url)

}
                       
# Method 13, assume already ordered, use duplicated
method13 <- function(hot){

    dups <- duplicated( hot$song_id )
    first_url <- hot$chart_url[!dups]
    unique_song_ids <- hot$song_id[!dups]
    return( list( first_url=first_url, unique_song_ids=unique_song_ids ) )

}
                       

# Method 14, use duplicated, don't assume ordered
method14 <- function(hot){

    hot$chart_date <- as.Date( hot$chart_date )
    ord <- order( hot$chart_date )
    hot_ord <- hot[ord,]
    dups <- duplicated( hot_ord$song_id )
    first_url <- hot_ord$url[!dups]
    unique_song_ids <- hot_ord$song_id[!dups]
    return( list( first_url=first_url, unique_song_ids=unique_song_ids ) )

}
                       

# Method 15, use duplicated, don't assume ordered, faster ordering
method15 <- function(hot){
    
    hot$chart_date <- as.numeric(gsub("-","",hot$chart_date))
    ord <- order( hot$chart_date )
    hot_ord <- hot[ord,]
    dups <- duplicated( hot_ord$song_id )
    first_url <- hot_ord$url[!dups]
    unique_song_ids <- hot_ord$song_id[!dups]
    return( list( first_url=first_url, unique_song_ids=unique_song_ids ) )
    
}

