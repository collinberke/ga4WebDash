test_that("dateRangeFloorMonth() outputs UI element for a month", {
  # Create test date
  start_date <- as.Date("2021-01-15")
  # Expectation of test
  expect_snapshot(dateRangeInput("x", start_date, label = "Select a date range:"))
})
