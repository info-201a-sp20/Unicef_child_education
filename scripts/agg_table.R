library(dplyr)

agg_table <- function(data) {
  table <- data %>%
    group_by(Africa.sub.regions) %>%
    filter(!is.na(Africa.sub.regions)) %>%
    summarize(avg_percent = sum(Total, na.rm = TRUE) / n(),
              female_percent = sum(Female, na.rm = TRUE) / n(),
              male_percent = sum(Male, na.rm = TRUE) / n()) %>%
    arrange(desc(avg_percent))
  return(table)
}
