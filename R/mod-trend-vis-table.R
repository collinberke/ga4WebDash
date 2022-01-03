
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

    output$user_trend <- renderPlot({
      ggplot(input_data(), aes(x = event_date, y = users)) +
        geom_line(size = 2) +
        labs(x = "", y = "Users") +
        theme_minimal() +
        theme(
          axis.text = element_text(size = 14),
          panel.grid.minor = element_blank()
        )
    })

    output$purchase_trend <- renderPlot({
      ggplot(input_data(), aes(x = event_date, y = purchase)) +
        geom_line(size = 2) +
        labs(x = "", y = "Purchases") +
        theme_minimal() +
        theme(
          axis.text = element_text(size = 14),
          panel.grid.minor = element_blank()
        )
    })

    output$table <- renderDataTable(clean_col_names(input_data()), options = list(pageLength = 14))
  })
}
