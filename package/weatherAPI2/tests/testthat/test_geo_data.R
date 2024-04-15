
test_that( "geographic data looks ok", {

    lon <- -76.497
    lat <- 42.440
    info <- get_geo_data( lat, lon )
    expect_equal(
        names(info),
        c("@context", "id", "type", "geometry", "properties")
    )

})

