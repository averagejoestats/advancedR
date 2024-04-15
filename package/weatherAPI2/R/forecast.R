
#' Seven-Day descriptive forecast
#'
#' Given an object with geographic information about a point (the output of
#' the function \code{get_geo_data}), return an object containing information
#' about the National Weather Service forecast for the next 7 days.
#'
#' @param point_info object returned by \code{\link{get_geo_data}}
#' @return a list of class "weather_forecast" containing the following components
#' \itemize{
#'   \item \code{@context} metadata
#'   \item \code{type} type of object
#'   \item \code{geometry} geometry, including coordinates
#'   \item \code{properties} information about the forecast
#' }
#' Importantly, the \code{properties} components is a list that whose
#' \code{$periods} element is a data frame containing the forecast.
#' @examples
#' ithaca_info <- get_geo_data( 42.440, -76.497 )
#' forecast <- get_7day_forecast( ithaca_info )
#' print(forecast)
#' @export
get_7day_forecast <- function( point_info ){
    sv <- httr::GET( point_info$properties$forecast )
    forecast <- jsonlite::fromJSON( httr::content( sv, as = "text", encoding = "UTF-8" ) )
    forecast$properties$city <- point_info$properties$relativeLocation$properties$city
    forecast$properties$state <- point_info$properties$relativeLocation$properties$state
    forecast$properties$coordinates <-
        point_info$properties$relativeLocation$geometry$coordinates
    class(forecast) <- "weather_forecast"
    return(forecast)
}
