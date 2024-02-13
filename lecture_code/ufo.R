
# dat <- read.csv("../datasets/nuforc_reports.csv")
# dat$date <- as.Date( substr( dat$date_time, 1, 10 ) )
# 
# ii <- which( dat$date > as.Date("2021-01-01") )
# subdat <- dat[ii,]
# 
# saveRDS( subdat, file = "../datasets/ufo2021.rds" )


ufo <- readRDS("../datasets/ufo2021.rds")
ufo[1,]

print_ufo <- function(x){
    print("city")
    print(x$city)
}

print_ufo( ufo[1,] )

colnames(ufo)



# create a function to print out info from a single ufo report. Example below.
# Feel free to make it look as you wish.


 
# summary:
# Viewed some red lights in the sky appearing to be moving north and slower than an airplane.
# 
# city:
# Visalia
# 
# state:
# CA
# 
# date:
# 2021-12-15
# 
# shape:
# light
# 
# duration:
# 2 minutes
# 
# stats: Occurred : 12/15/2021 21:45  (Entered as : 12/15/2021 9:45 PM) Reported: 12/15/2021 10:30:54 PM 22:30 Posted: 12/19/2021 Location: Visalia, CA Shape: Light Duration:2 minutes
# 
# report_link:
# http://www.nuforc.org/webreports/165/S165881.html





# Create a function for printing the text in a nice format. You'll want to break the
# lines at a reasonable width (perhaps 80 characters).





# Try to figure out which UFO sightings are "real", as in there was an actual object
# flying in the sky, observed by someone.
