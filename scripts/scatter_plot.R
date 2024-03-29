library("dplyr")
library("ggplot2")
library("plotly")

scatter_plot <- function(data_frame, y_var) {
  if (y_var == "Total") {
    y_var_name <- "Youth"
  } else if (y_var == "Female") {
    y_var_name <- "Youth Females"
  } else if (y_var == "Male") {
    y_var_name <- "Youth Males"
  }
  plot_data <- na.omit(data_frame) %>%
    filter(Least.developed.countries..LDC. == "LDC") %>%
    select(Country, Total, Female, Male)
  scatter_plot <- ggplot(data = plot_data) +
    geom_point(
      mapping = aes(
        x = Country,
        y = plot_data[, y_var],
        text = paste0(
          "Country: ", Country,
          "<br>",
          "Literacy Rate: ", plot_data[, y_var]
        )
      ),
      color = "turquoise3"
    ) +
    ggtitle(paste0("Literacy Rates of ", y_var_name, " in LDC")) +
    labs(y = "Literacy Rate (%)", x = "Country") +
    theme(axis.text.x = element_text(angle = 90))
  scatter_plot <- ggplotly(scatter_plot, tooltip = "text")
  return(scatter_plot)
}