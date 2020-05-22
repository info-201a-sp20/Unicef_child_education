library("dplyr")
library("ggplot2")
library("reshape2")

literacy_data <-
  read.csv("data/regional-agg_LiteracyRate.csv", stringsAsFactors = FALSE)

bar_chart <- function(data_frame) {
  plot_data <- na.omit(data_frame) %>%
    group_by(Region) %>%
    mutate(Male = sum(Male) / n(),
           Female = sum(Female) / n()) %>%
    select(Region, Male, Female) %>%
    filter(Region != "")
  plot_data <- plot_data[!duplicated(plot_data$Region), ]
  plot_data <- melt(plot_data[, c('Region', 'Male', 'Female')], id.vars = 1)
  bar_chart <- ggplot(plot_data, aes(x = value, y = Region)) +
    geom_bar(aes(fill = variable), stat = "identity", position = "dodge") +
    ggtitle("Literacy Rates of Youth Males and Females in 2018 by Region") +
    labs(y = "Region", x = "Literacy Rate (%)") +
    labs(fill = "Gender")
  return(bar_chart)
}