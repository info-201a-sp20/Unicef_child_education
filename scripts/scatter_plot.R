library("dplyr")
library("ggplot2")
library("plotly")

scatter_plot <- function(data_frame, y_var) {
  plot_data <- na.omit(data_frame) %>%
    filter(Least.developed.countries..LDC. == "LDC") %>%
    select(Country, Total, Male, Female)
  scatter_plot <- ggplot(data = plot_data) +
    geom_point(mapping = aes(x = Country, y = input$y_var), color = "turquoise3") +
    ggtitle("Literacy Rates in Least Developed Countries") +
    labs(y = "Literacy Rate (%)", x = "Country") +
    theme(axis.text.x = element_text(angle = 90))
  scatter_plot <- ggplotly(scatter_plot)
  return(scatter_plot)
}
