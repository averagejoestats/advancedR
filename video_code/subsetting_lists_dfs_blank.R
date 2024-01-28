
# subsetting lists and data frames

# Lists: [ ] vs [[ ]] vs $

# [ ] returns a list

# [[ ]] returns the element of the list

# [[ ]] and [ ] can be combined



# what does this do? Why [[ 1 ]]?

# hierarchical indexing

# wait, why does the [[ 2 ]] work?


# $elem returns list element named "elem" (if one exists)


# named lists can also be accessed with [[ ]]

# caution: $ does partial matching, [[ ]] does not
# for this reason I consider [[ ]] to be safer than $
# fewer silent bugs

# assign NULL to eliminate a list element





# data.frames share behavior of matrices and lists

# pull a single element

# pulling out a column coerces to atomic vector

# pulling out a row does not

# multiple columns

# single-index subsetting treats the data.frame as a list
# and does not coerce to an atomic vector

# multiple indices treats it as a matrix

# can combine [ ] with names
# these behave like matrices

# these behave like lists

# $ works, but beware of partial matching

# [[ ]] works



# subset function
# ?subset

# same as this

