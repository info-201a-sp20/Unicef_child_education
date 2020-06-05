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

}
