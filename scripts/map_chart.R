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
    na.omit()

  plot_data$radius <- (plot_data$Total - min(plot_data$Total)) / 5

  map <- leaflet(plot_data) %>%
    addTiles() %>%
    addCircleMarkers(
      lat = ~latitude,
      lng = ~longitude,
      popup = paste0(
        "Country: ", plot_data$Country, "<br>",
        "Literacy rate: ", plot_data$Total, "<br>"
      ),
      stroke = FALSE,
      radius = ~radius,
      fillOpacity = 0.5
    )
}
