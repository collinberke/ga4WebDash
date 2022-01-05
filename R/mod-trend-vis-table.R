#'
#' @export
#'
trendVisTableInput <- function(id){
  ns <- NS(id)
  fluidRow(
    column(12,
           h5("Show a trend line?"),
           selectInput(ns("trend_method"),
                       label = "Select a method:",
                       choices = c("None", "Mean", "Linear", "Loess"))
           )
  )
}

trendVisTableOutput <- function(id){
  ns <- NS(id)
  fluidRow(
    h3("Users"),
    plotOutput(ns("user_trend")),
    h3("Purchases"),
    plotOutput(ns("purchase_trend")),
    h4("Users & Purchases Table"),
    dataTableOutput(ns("table"))
  )
}

trendVisTableServer <- function(id, input_data) {
  stopifnot(is.reactive(input_data))

  moduleServer(id, function(input, output, session) {

    observeEvent(input$trend_method, {
      switch(input$trend_method,
             Linear = showNotification("Linear trend selected.", type = "message"),
             Mean = showNotification("Mean trend selected.", type = "message"),
             Loess = showNotification("Loess trend selected.", type = "message")
             )
    })

    mean_trend <- reactive({summarise(input_data(), across(-event_date, mean))})

    user_plot <- reactive({
      create_trend_plot(
        data = input_data(),
        mean_data = mean_trend()$users,
        date_var = event_date,
        mean_trend = input$trend_method,
        y_var = users,
        y_label = "Users"
      )
    })

    purchase_plot <- reactive({
      create_trend_plot(
        data = input_data(),
        mean_data = mean_trend()$purchase,
        date_var = event_date,
        mean_trend = input$trend_method,
        y_var = purchase,
        y_label = "Purchases"
      )
    })

    output$user_trend <- renderPlot({user_plot()})

    output$purchase_trend <- renderPlot({purchase_plot()})

    output$table <- renderDataTable(clean_col_names(input_data()), options = list(pageLength = 14))

  })
}
