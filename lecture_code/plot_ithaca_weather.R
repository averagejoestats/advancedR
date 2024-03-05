
data_dir <- "/home/joe/Dropbox/teaching/repos/advancedR/datasets"

# download most recent file from web:
fname <- "CRNH0203-2024-NY_Ithaca_13_E.txt"
url <- paste0("https://www.ncei.noaa.gov/pub/data/uscrn/products/hourly02/2024/",fname)
download.file(url, file.path(data_dir, fname) )

# search for the weather datasets
fnames <- list.files( "../datasets", pattern = "Ithaca" )
fnames

# read in the first dataset to initialize a data frame
dat <- read.table( file.path( data_dir, fnames[1] ), header = FALSE )

# loop over the rest of the files and rbind them
for(j in 2:length(fnames)){
    dat <- rbind(
        dat,
        read.table( file.path( data_dir, fnames[j] ), header = FALSE )
    )
}

# Create some data variables for plotting purposes
dat$date <- as.Date( as.character(dat$V4), format = "%Y%m%d" )
dat$year <- as.numeric( format(dat$date, "%Y"))
dat$doy  <- as.numeric( format(dat$date, "%j"))
dat$dom  <- as.numeric( format(dat$date, "%d"))
dat$dom_decimal <- dat$dom + dat$V5/2400
dat$doy_decimal <- dat$doy + dat$V5/2400
dat$month <- as.numeric( format(dat$date, "%m" ) )
dat$temp <- dat$V9
dat$temp[ dat$temp < -1000 ] <- NA
dat$tempF <- dat$temp*9/5 + 32


# plot the february data, highlighting one year
#pdf("ithaca_feb_temps.pdf", width=9, height = 8)
plot(
    NA, type = "n",
    xlim = c(1,29), ylim = c(-40,80),
    xlab = "February", ylab = "Temperature"
)
for( y in 2004:2024 ){
    # grab data for february
    ii <- dat$year == y & dat$month == 2
    # plot the data
    lines( dat$dom_decimal[ii], dat$tempF[ii], col = "gray" )
    if( y == 2024 ){
        lines( dat$dom_decimal[ii], dat$tempF[ii], lwd = 2, col = "black" )
    }
}
mtext("February Temperatures Ithaca 2004-2024",line = 1 )
abline( 32, 0, col = "blue", lty = 2 )
#dev.off()





# plot the february data, highlighting one year
#pdf("ithaca_feb_temps.pdf", width=9, height = 8)
plot(
    NA, type = "n",
    xlim = c(1,120), ylim = c(-40,80),
    xlab = "", ylab = "Temperature", axes = FALSE
)
for( y in 2004:2024 ){
    # grab data for february
    ii <- dat$year == y & dat$month %in% c(1,2,3,4)
    # plot the data
    lines( dat$doy_decimal[ii], dat$tempF[ii], col = "gray" )
    if( y == 2024 ){
        lines( dat$doy_decimal[ii], dat$tempF[ii], lwd = 2, col = "black" )
    }
}
mtext("Temperatures Ithaca 2004-2024",line = 1 )
abline( 32, 0, col = "blue", lty = 2 )
#dev.off()
axis(1, at = 0.5 + c(0,31,59,89,119), labels = rep("",5) )
axis(1, at = c(14, 45, 75, 105), labels = c("January","February","March","April"), tick = FALSE )
axis(2)
box()













# some exercises:

# 1. Write a function that takes in a vector of years and colors, and 
#    highlights those years with those colors
# 2. Add a legend for the years (see ?legend)
# 3. Calculate the mean or median temperature for each hour, and add a line
#    for the median.
# 4. Calculate the median over all years over a 24 hour moving window, and
#    add a line for that median.

