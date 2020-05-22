library("dplyr")
library("ggplot2")
library("reshape2")
library("forcats")

literacy_data <-
  read.csv("data/regional-agg_LiteracyRate.csv", stringsAsFactors = FALSE)

bar_chart <- function(data_frame) {
  plot_data <- melt(data_frame[, c('Country', 'Male', 'Female')], id.vars = 1)
  plot_data <- na.omit(plot_data) %>%
    group_by(Country) %>%
    select(Country, variable, value)
  bar_chart <- ggplot(plot_data, aes(x = value, y = Country)) +
    geom_bar(aes(fill = variable), stat = "identity", position = "dodge") +
    ggtitle("Literacy Rates of Youth Males and Females in 2018") +
    labs(y = "Country", x = "Literacy Rate (%)") +
    labs(fill = "Gender")
  return(bar_chart)
}

bar_chart(literacy_data)

# Function

literacy_data <-
  read.csv("data/regional-agg_LiteracyRate.csv", stringsAsFactors = FALSE)

rates_by_region <- function(data_frame) {
  plot_data <- na.omit(data_frame) %>%
    group_by(Region) %>%
    mutate(Male = sum(Male) / n(),
           Female = sum(Female) / n()) %>%
    select(Region, Male, Female)
  plot_data$Region[17] <- "Other"
  plot_data$Region[25] <- "Other"
  plot_data$Region[26] <- "Other"
  plot_data$Region[28] <- "Other"
  plot_data$Region[56] <- "Other"
  plot_data$Region[63] <- "Other"
  plot_data <- plot_data[!duplicated(plot_data$Region), ]
  plot_data <- melt(plot_data[, c('Region', 'Male', 'Female')], id.vars = 1)
  bar_chart <- ggplot(plot_data, aes(x = value, y = Region)) +
    geom_bar(aes(fill = variable), stat = "identity", position = "dodge") +
    ggtitle("Literacy Rates of Youth Males and Females in 2018 by Region") +
    labs(y = "Region", x = "Literacy Rate (%)") +
    labs(fill = "Gender")
  return(bar_chart)
}

rates_by_region(literacy_data)
