library(dplyr)

summary_info <- function(data) {
  info <- list()
  info$num_countries <- data %>%
    nrow() - 1
  info$country_highest_total_rate <- data %>%
    filter(Total == max(Total)) %>%
    pull(Country)
  info$country_lowest_total_rate <- data %>%
    filter(Total == min(Total)) %>%
    pull(Country)
  info$avg_total_rate <- data %>%
    select(Total) %>%
    mean()
  info$num_least_developed_countries <- data %>%
    select("Least developed countries (LDC)") %>%
    sum()
}
