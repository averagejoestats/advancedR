
test_that( "forecast object looks ok", {

    lon <- -76.497
    lat <- 42.440
    info <- get_geo_data( lat, lon )
    forecast <- get_7day_forecast( info )
    expect_equal(
        names(forecast),
        c("@context", "type", "geometry", "properties")
    )

})

