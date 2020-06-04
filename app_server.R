library("dplyr")
library("plotly")

# Read in data
source("scripts/scatter_plot.R")
source("scripts/bar_chart.R")
data <- read.csv("data/regional-agg_LiteracyRate.csv", 
                 stringsAsFactors = FALSE)

server <- function(input, output) {
  # Rendered plotly object that returns scatter plot
  output$scatter <- renderPlotly({
    return(scatter_plot(data, input$y_var))
  })
  # Renders barchart
  output$barchart <- renderPlotly({
    return(bar_chart(data, input$region))
  })
}
