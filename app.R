library(shiny)
library(tidyverse)

web_data <- read_csv("data/ga4_data.csv", col_types = list(
  event_date = col_date("%Y%m%d")
))

ui <- fluidPage(
  h1("Merchandise Store Summary Report"),
  #> Inputs
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("date",
                     "What's the date range for the trend?",
                     start = min(web_data$event_date),
                     end = max(web_data$event_date),
                     max = max(web_data$event_date),
                     min = min(web_data$event_date)
                     ),
      h4("Users & Purchases Table"),
      dataTableOutput("table")
    ),
    mainPanel(
      fluidRow(
        h3("Users"),
        plotOutput("user_trend"),
        h3("Purchases"),
        plotOutput("purchase_trend")
      )
    )
  )
)

server <- function(input, output, session) {

  data <- reactive({
    web_data %>%
      filter(
        .data[["event_date"]] >= input$date[[1]],
        .data[["event_date"]] <= input$date[[2]]
      )
    })

  output$user_trend <- renderPlot({
    ggplot(data(), aes(x = event_date, y = users)) +
      geom_line(size = 2) +
      labs(x = "", y = "Users") +
      theme_minimal() +
      theme(
        axis.text = element_text(size = 14),
        panel.grid.minor = element_blank()
      )
  })

  output$purchase_trend <- renderPlot({
    ggplot(data(), aes(x = event_date, y = purchase)) +
      geom_line(size = 2) +
      labs(x = "", y = "Purchases") +
      theme_minimal() +
      theme(
        axis.text = element_text(size = 14),
        panel.grid.minor = element_blank()
        )
  })

  output$table <- renderDataTable(data(), options = list(pageLength = 14))

}

shinyApp(ui, server)
