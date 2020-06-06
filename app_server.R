library("dplyr")
library("plotly")
library("leaflet")

# Read in data
source("scripts/scatter_plot.R")
source("scripts/bar_chart.R")
source("scripts/map_chart.R")

data <- read.csv(
  "data/regional-agg_LiteracyRate.csv",
  stringsAsFactors = FALSE
)

server <- function(input, output) {
  # Renders scatter plot
  output$scatter <- renderPlotly({
    return(scatter_plot(data, input$y_var))
  })

  # Renders barchart
  output$barchart <- renderPlotly({
    return(bar_chart(data, input$area))
  })

  # Renders mapchart
  output$mapchart <- renderLeaflet({
    return(map_chart(data, input$gender, input$colors, input$legend))
  })
  
  # Renders barchart on summary page
  output$summ_barchart <- renderPlotly({
    return(bar_chart(data, input$area))
  })
  
  # Renders scatterplot on summary page
  output$summ_scatter <- renderPlotly({
    return(scatter_plot(data, input$y_var))
  })
  
  # Renders the map on summary page
  output$summ_map <- renderLeaflet({
    return(map_chart(data, input$gender, input$colors, input$legend))
  })
}
