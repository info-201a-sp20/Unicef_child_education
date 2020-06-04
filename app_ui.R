library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")

# Widget to define a variable for the scatter plot
scatter_sidebar_content <- sidebarPanel(
  # An input to select variable for scatter plot
  selectInput(
    "y_var",
    label = "Literacy Rates of:",
    choices = list(
      "Youth" = "Total",
      "Females" = "Female",
      "Males" = "Male"
    )
  ),
  # A description of why we chose a scatter plot
  h4("Our Reasoning:"),
  p("In this chart, we wanted to see if there was a similar relationship
    between the least developing countries (LDC) and their overall youth
    literacy rates. We thought it'd be best to plot this on a scatter plot
    so we could clearly interpret whether the literacy rates of the youth
    were generally high or low.")
)

# Prints out scatter plot
scatter_main_content <- mainPanel(
  plotlyOutput("scatter")
)

# Formats the page and stores a tab panel for the scatter panel
scatter_panel <- tabPanel(
  "Scatter",
  titlePanel("Literacy Rates in Least Developed Countries"),
  sidebarLayout(
    scatter_sidebar_content,
    scatter_main_content
  )
)


# Widget to pick gender and region
barchart_sidebar <- sidebarPanel(
  selectInput(
    "region",
    label = "Region:",
    choices = list(
      "Sub-Saharan Africa" = "SSA",
      "South Africa" = "SA",
      "Middle East and North Africa" = "MENA",
      "Latin America and the Carribean" = "LAC",
      "Europe and Central Asia" = "ECA",
      "East Asia and Pacific" = "EAP"
    )
  )
)

# Prints barchart
barchart_main_content <- mainPanel(
  plotlyOutput(outputId = "barchart")
)

# Puts barchart page together
barchart_panel <- tabPanel(
  "Barchart",
  sidebarLayout(
    barchart_sidebar,
    barchart_main_content
  )
)

# Defines the 5 pages 
ui <- navbarPage(
  "Literacy Rates Around the World",
  # overview, 
  barchart_panel,
  scatter_panel
  # map_panel,
  # summary
)
