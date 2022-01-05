test_that("data reactive is filtered by date", {
  # Create test data
  test_data <- dplyr::tribble(
    ~event_date,
    lubridate::as_date("2020-11-02"),
    lubridate::as_date("2020-11-03"),
    lubridate::as_date("2020-11-04")
  )
  # Test expectations
  shiny::testServer(ga4App(server), {
    session$setInputs(date = c("2020-11-02", "2020-11-04"))

    expect_equal(data()[, 1], test_data)
  })
})
