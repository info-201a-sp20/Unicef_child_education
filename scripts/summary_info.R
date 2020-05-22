library(dplyr)
literacy_rate_data <- read.csv("data/regional-agg_LiteracyRate.csv", stringsAsFactors = FALSE)
sum_inform <- function(data) {
  info <- list()
  info$num_countries <- data %>%
    nrow()
  
  info$country_highest_total_rate <- data %>%
    filter(Total == max(Total, na.rm = TRUE)) %>%
    pull(Country)
  
  info$country_lowest_total_rate <- data %>%
    filter(Total == min(Total, na.rm = TRUE)) %>%
    pull(Country)
  
  info$avg_total_rate <- data %>%
    filter(!is.na(Total)) %>%
    select(Total) %>%
    
  info$num_least_developed_countries <- data %>%
    filter(Least.developed.countries..LDC. == "LDC") %>%
    count()
  return(info)
}

sum_inform(literacy_rate_data)
