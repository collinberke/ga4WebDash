
test_that("mean trend reactive is valid", {
   data <- reactiveVal()

    test_data <- dplyr::tribble(
    ~users, ~page_view, ~session_start, ~purchase,
      2664, 14465.3333,      3853.6667,  37.333333
  )

  testServer(trendVisTableServer, args = list(input_data = data), {
    data(dplyr::tribble(
      ~event_date, ~users, ~page_view, ~session_start, ~purchase,
      lubridate::as_date("2021-01-01"), 2365,  9767, 2594, 14,
      lubridate::as_date("2021-01-02"), 3262, 14964, 3682, 49,
      lubridate::as_date("2021-01-03"), 2365, 18665, 5285, 49
    ))
    session$flushReact()
    expect_equal(mean_trend(), test_data)

    session$flushReact()
    expect_equal(class(purchase_plot()), c("gg", "ggplot"))

    session$flushReact()
    expect_equal(class(user_plot()), c("gg", "ggplot"))
  })
})
