
#' S3 method (function) to print the forecast
#'
#' Nicely print the information in a weather forecast object.
#'
#' @param x a "weather_forecast" object, returned from
#' \code{get_7day_forecast}.
#' @param nperiods number of 1/2 day periods to print. Defaults to 2.
#' @param ... further arguments passed to print
#' @return NULL
#' @examples
#' ithaca_info <- get_geo_data( 42.440, -76.497 )
#' forecast <- get_7day_forecast( ithaca_info )
#' print(forecast, 2)
#' print(forecast, 4)
#' forecast
#' @export
print.weather_forecast <- function( x, ..., nperiods = NULL ){

    fdb <- x$properties$periods
    if( is.null( nperiods ) ){ nperiods <- nrow( fdb ) }

    start_times <- fdb$startTime
    start_dates <- as.POSIXct( substr( start_times, 1, 19), format = "%FT%T" )
    end_times <- fdb$endTime
    start_dates <- as.POSIXct( substr( end_times, 1, 19), format = "%FT%T" )


    st0 <- paste0(
        "Forecast for ",
        x$properties$city, ", ", x$properties$state, " ",
        "(", x$properties$coordinates[1], ", ", x$properties$coordinates[2], ")"
    )
    cat(st0,"\n\n")

    for(j in 1:nperiods){
        st1 <- paste0(
            fdb$name[j], " ", format( start_dates[j], "%F"), ": ",
            fdb$temperature[j], " ", fdb$temperatureUnit[j], ", ",
            "winds ", fdb$windSpeed[j], " from the ", fdb$windDirection[j],
            "\n\n"
        )
        cat(st1)
        st2 <- strsplit( fdb$detailedForecast[j], " " )[[1]]
        cat( st2, fill = TRUE )
        cat("\n\n")
    }
    invisible(NULL)
}
