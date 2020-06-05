library("dplyr")
library("leaflet")
library("RColorBrewer")

# Interactive map chart for literacy data of 2019
map_chart <- function(data, gender, colors, legend) {
  data$literacy_level <- cut(
    data[[gender]],
    c(0, 60, 80, 90, 95, 98.9, 99, 100),
    include.lowest = T,
    labels = c("<60%", "60-80%", "80-90%", "90-95%", ">95%", "99%", "100%")
  )

  # Color scheme with the given colorScheme parameters
  factpal <- colorFactor(colors, data[["literacy_level"]])
  plot_data <- data %>% filter(!is.na(literacy_level))


  # The interactive map with gl
  map <- leaflet(plot_data) %>%
    addTiles() %>%
    addCircleMarkers(
      lat = ~latitude,
      lng = ~longitude,
      popup = paste0(
        "Country: ", plot_data$Country, "<br>",
        gender, " literacy rate: ", plot_data[[gender]], "%<br>"
      ),
      stroke = FALSE,
      color = ~ factpal(literacy_level),
      radius = 8,
      fillOpacity = 0.8
    ) 
  
  if(legend) {
    map <- map %>%
      addLegend(
        "bottomright",
        pal = factpal,
        values = plot_data$literacy_level,
        title = "The literacy rate",
        opacity = 1
      )
  }
  return(map)
}
