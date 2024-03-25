
# dplyr: follow chapter 3 of R for Data Science by Hadley Wickham
# https://r4ds.hadley.nz/data-transform.html

# filter
# select
# group_by
# summarize
# left_join
# inner_join
# mutate

# read in the marathon dataset
dat <- read.csv("../datasets/marathon_men.csv")
head(dat)
class(dat)

# use dplyr to do some exploratory analyses
library("dplyr")

## Subsetting rows:

# use 'filter' to subset rows according to a condition (year == 2015)
table( dat$year )
dat_2015 <- filter( dat, year == 2015 )
table( dat_2015$year )
dat_2015
as_tibble(dat_2015)
glimpse(dat_2015)

# get all times less than 2:07
filter( dat, time_minutes < 127 )

# equivalent to
dat[ dat$time_minutes < 127, ]

# sort them using arrange
arrange( filter( dat, time_minutes < 127 ), time_minutes )
arrange( filter( dat, time_minutes < 127 ), desc(time_minutes) )

# pipes: left-side result is the first argument to right side function
dat |> filter(time_minutes < 127 )
# filter( dat, time_minutes < 127 )

dat |> filter(time_minutes < 127 ) |> arrange( time_minutes )
# arrange( filter( dat, time_minutes < 127 ), time_minutes )


## Subsetting columns:

# select to select certain columns
dat_slim <- select(
    dat, match_name, marathon, year, time_minutes, vaporfly 
)
head(dat_slim)

dat_names <- select( dat, contains("name") ) 
dat_names <- select( dat, contains(name) )   # doesn't work
head( dat_names )
# also has starts_with, ends_with
?select

# use 'where' for customized conditions
dat |> select( where(is.logical) ) |> head()
dat |> select( where(function(x) is.logical(x) || is.numeric(x) )) |>head()


## Grouping rows

# group_by is closely related to split and tapply
dat_grouped <- group_by( dat, marathon, year )
dat_grouped
dim(dat)
dim(dat_grouped)
attributes( dat_grouped )

# functions to get information about groupings
group_data( dat_grouped )
print( group_data( dat_grouped ), n = Inf )
dat_grouped |> group_data() |> print(n = Inf)
group_keys( dat_grouped )

# indices of each group
group_rows( dat_grouped )
dat_grouped[ group_rows( dat_grouped )[[4]], ]

# groups numbers of each index
group_indices( dat_grouped )
dat_grouped[1:31,] |> distinct( marathon, year )

# other functions
groups( dat_grouped )
group_size( dat_grouped )
n_groups( dat_grouped )


# group_by is often combined with summarize
summarize( dat_grouped, mean(time_minutes) )
summarize( dat_grouped, avg_time = mean(time_minutes) )
summarize( dat_grouped, n() )
count( dat, marathon, year )

## use your pipes

# get the average time for each race for each shoe type
dat |>
    group_by( marathon, year, vaporfly )         |>
    summarize( avg_time = mean(time_minutes ) )  |>
    print( n = Inf )

dat |>
    group_by( marathon, year, vaporfly )                      |>
    summarize( avg_time = mean(time_minutes, na.rm = TRUE) )  |>
    print( n = Inf )

dat |>
    filter( !is.na(vaporfly) )                   |>
    group_by( marathon, year, vaporfly )         |>
    summarize( avg_time = mean(time_minutes) )   |>
    print( n = Inf )

dat |>
    filter( !is.na(vaporfly) )                   |>
    group_by( marathon, year, vaporfly )         |>
    summarize( avg_time = mean(time_minutes) )   |>
    as.data.frame( digits = 5 )


# how would we create a dataset with a row for each marathon-year,
# and a column for the difference between vaporfly and non-vaporfly?

# first, calculate averages using group_by and summarize
dat_avgs <- dat                                  |>
    filter( !is.na(vaporfly) )                   |>
    group_by( marathon, year, vaporfly )         |>
    summarize( avg_time = mean(time_minutes) )  

dat_avgs 

# get separate datasets for the two vaporfly values
dat_avgs_FALSE <- filter( dat_avgs, !vaporfly )
dat_avgs_TRUE  <- filter( dat_avgs,  vaporfly )

dat_avgs_FALSE
dat_avgs_TRUE


# left_join tries to match second data frame to first
dat_avgs_both <- left_join( 
    dat_avgs_FALSE, dat_avgs_TRUE, by = c("marathon","year") 
)
nrow(dat_avgs_FALSE)
nrow(dat_avgs_TRUE )
nrow(dat_avgs_both )
head(dat_avgs_both)
# not quite what we want

# we don't need the vaporfly column in these datasets
dat_avgs_FALSE <- filter( dat_avgs, !vaporfly ) |> select(!vaporfly)
dat_avgs_TRUE  <- filter( dat_avgs,  vaporfly ) |> select(!vaporfly)

# inner join produces new data frame with only rows that appear in both
dat_avgs_both <- inner_join(
    dat_avgs_FALSE,
    dat_avgs_TRUE,
    by = c("marathon","year"),
    suffix = c("_FALSE","_TRUE") 
)
print( dat_avgs_both, n = Inf )


## add columns to data frame using mutate

# difference of times
dat_avgs_both |> mutate( avg_time_diff = avg_time_TRUE - avg_time_FALSE )

dat_avgs_both |> 
    mutate( avg_time_diff = avg_time_TRUE - avg_time_FALSE ) |>
    arrange(year) |>
    print(n = Inf)



# How could we analyze this dataset using a model?
dat$marathon_year <- paste( dat$marathon, dat$year )
m1 <- lme4::lmer( 
    "time_minutes ~ vaporfly + (1|marathon_year) + (1|match_name)", 
    data = dat 
)
summary(m1)


