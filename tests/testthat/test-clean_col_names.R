test_that("clean_col_names title cases columns", {
  # Create sample data
  data <- tribble(~event_name, ~users, ~page_view, ~session_start, ~purchase)
  test_names <- c("Event Name", "Users", "Page View", "Session Start", "Purchase")
  # Test expectations
  expect_named(clean_col_names(data), test_names)
})
