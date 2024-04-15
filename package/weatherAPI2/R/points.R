
#' Retrieve geographic data for given longitude and latitude
#'
#' Get the National Weather Service forecast grid information for a
#' given latitude and longitude coordinate.
#'
#' @param lat latitude in decimal degrees north (positive for northern hemisphere)
#' @param lon longitude in decimal degrees east (positive for eastern hemisphere)
#' @return a list with the following components:
#' \itemize{
#'   \item \code{@context} metadata
#'   \item \code{id} original url accessed
#'   \item \code{type} type of object
#'   \item \code{geometry} geometry, including coordinates
#'   \item \code{properties} information needed to gather further weather
#'                           data related to this coordinate
#' }
#' @examples
#' # get geographic information for Ithaca, NY
#' ithaca_info <- get_geo_data( 42.440, -76.497 )
#' print( ithaca_info$geometry )
#' print( ithaca_info$properties$relativeLocation$properties$city )
#' print( ithaca_info$properties$forecast )
#' @export
get_geo_data <- function( lat, lon ){
    myurl <- paste0( "https://api.weather.gov/points/", lat, ",", lon )
    weather_list <- jsonlite::fromJSON( myurl )
    return( weather_list )
}
