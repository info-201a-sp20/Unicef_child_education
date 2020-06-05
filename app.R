library("shiny")
library("plotly")

# Load server and users' interface
source("app_ui.R")
source("app_server.R")

# Create website of application
shinyApp(ui = ui, server = server)
