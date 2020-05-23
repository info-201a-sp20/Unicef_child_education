library(dplyr)
library(leaflet)

map_chart <- function(data) {
  plot_data <- data %>% 
    select(
      Country,
      Total,
      latitude,
      longitude
    ) %>%
    filter(
      !is.na(Total),
      !is.na(latitude)
    ) 
  
  plot_data$radius <- (plot_data$Total - min(plot_data$Total)) / 5

  map <- leaflet(data) %>%
    addTiles() %>%
    addCircleMarkers(
      lat = ~latitude,
      lng = ~longitude,
      popup = paste0(
        "Country: ", data$Country, "<br>",
        "Literacy rate: ", data$Total, "<br>"
      ),
      stroke = FALSE,
      radius = ~radius,
      fillOpacity = 0.5
    )
}

