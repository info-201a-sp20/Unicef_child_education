library(dplyr)
library(leaflet)

map_chart <- function(data) {
  plot_data <- data %>%
    select(
      Country,
      selected = "Total",
      Total.population,
      latitude,
      longitude
    ) %>%
    na.omit()
  
  plot_data$literacy_level <- cut(
    plot_data$selected, 
    c(0, 60, 80, 90, 95, 98.9, 99, 100),
    include.lowest = T,
    labels = c("<60%",'60-80%', '80-90%', '90-95%', '>95%', '99%','100%')
  )
  
  factpal <- colorFactor("RdYlGn", plot_data$literacy_level)
  
  leaflet(plot_data) %>%
    addTiles() %>%
    addCircleMarkers(
      lat = ~latitude,
      lng = ~longitude,
      popup = paste0(
        "Country: ", plot_data$Country, "<br>",
        "Literacy rate: ", plot_data$selected, "%<br>"
      ),
      stroke = FALSE,
      color = ~factpal(literacy_level),
      radius = 8,
      fillOpacity = 0.8
    ) %>%
    addLegend(
      'bottomright',
      pal = factpal,
      values = plot_data$literacy_level,
      title = 'The literacy rate',
       opacity = 1
    )
  return(map)
}
