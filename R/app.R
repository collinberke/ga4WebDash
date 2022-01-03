library(shiny)
library(tidyverse)

web_data <- read_csv("data/ga4_data.csv", col_types = list(
  event_date = col_date("%Y%m%d")
))

ga4App <- function(...){

  ui <- fluidPage(
    h1("Merchandise Store Summary Report"),
    sidebarLayout(
      sidebarPanel(
        dateRangeInput("date",
                       "What's the date range for the trend?",
                       start = min(web_data$event_date),
                       end = max(web_data$event_date),
                       max = max(web_data$event_date),
                       min = min(web_data$event_date)
        )
      ),
      mainPanel(
        trendVisTableOutput("trend_vis")
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

    trendVisTableServer("trend_vis", reactive(data()))

  }

  shinyApp(ui, server)

}
