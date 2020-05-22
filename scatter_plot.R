library("dplyr")
library("ggplot2")

literacy_data <-
  read.csv("data/regional-agg_LiteracyRate.csv", stringsAsFactors = FALSE)

scatter_plot <- function(data_frame) {
  plot_data <- na.omit(data_frame) %>%
    filter(Least.developed.countries..LDC. == "LDC") %>%
    select(Country, Total)
  scatter_plot <- ggplot(data = plot_data) +
    geom_point(mapping = aes(x = Country, y = Total), color = "turquoise3") +
    ggtitle("Literacy Rates of Youth of Least Developed Countries in 2018") +
    labs(y = "Literacy Rate (%)", x = "Country") +
    theme(axis.text.x = element_text(angle = 90))
  return(scatter_plot)
}
