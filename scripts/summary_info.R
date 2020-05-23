library(dplyr)

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
  
  info$lowest_total_rate <- data %>%
    filter(Total == min(Total, na.rm = TRUE)) %>%
    pull(Total)
  
  info$avg_total_rate <- data %>%
    na.omit() %>%
    select(Total) %>%
    summarise(avg = mean(Total))
    
  info$num_least_developed_countries <- data %>%
    filter(Least.developed.countries..LDC. == "LDC") %>%
    count()
  return(info)
}
