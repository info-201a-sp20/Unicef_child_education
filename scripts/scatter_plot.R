library("dplyr")
library("ggplot2")
library("plotly")

scatter_plot <- function(data_frame, y_var) {
  plot_data <- na.omit(data_frame) %>%
    filter(Least.developed.countries..LDC. == "LDC") %>%
    select(Country, Total, Male, Female)
  var.equation <- paste0('~', y_var)
  scatter_title <- title(
    paste0(
      "Literacy Rates of",
      y_var,
      " of Least Developed Countries in 2018"
      )
    )
  scatter_plot <- ggplot(data = plot_data) +
    geom_point(mapping = aes(x = Country, y = y_var), color = "turquoise3") +
    ggtitle(scatter_title) +
    labs(y = "Literacy Rate (%)", x = "Country") +
    theme(axis.text.x = element_text(angle = 90))
  scatter_plot <- ggplotly(scatter_plot)
  return(scatter_plot)
}