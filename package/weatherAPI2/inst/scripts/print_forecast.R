
library("weatherAPI2")
args <- commandArgs( trailingOnly = TRUE )
lat <- as.numeric( args[1] )
lon <- as.numeric( args[2] )
grid_info <- get_geo_data( lat, lon )
forecast <- get_7day_forecast( grid_info )
print( forecast, nperiods = 4 )
