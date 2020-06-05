library("dplyr")
library("ggplot2")
library("reshape2")


bar_chart <- function(data_frame, area) {
  plot_data <- na.omit(data_frame) %>%
    group_by(Region) %>%
    mutate(Male = sum(Male) / n(),
           Female = sum(Female) / n()) %>%
    select(Region, Male, Female) %>%
    filter(Region != "")
  area_list <- c()
  plot_data <- plot_data[!duplicated(plot_data$Region), ]
  plot_data <- melt(plot_data[, c('Region', 'Male', 'Female')], id.vars = 1)
  bar_chart <- ggplot(plot_data, aes(x = value, y = area_list)) +
    geom_bar(aes(fill = variable), stat = "identity", position = "dodge") +
    ggtitle("Literacy Rates of Youth Males and Females in 2018 by Region") +
    labs(y = "Region", x = "Literacy Rate (%)") +
    labs(fill = "Gender")
  return(bar_chart)
}
