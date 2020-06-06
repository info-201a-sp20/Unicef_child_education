library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("RColorBrewer")

# Overview page
overview_panel <- tabPanel(
  tags$header(
    id = "tab_title",
    "Overview"),
  tags$header(
    id = "panel_title",
    titlePanel("Project Overview")
    ),
    mainPanel(
    tags$p(
      id = "overview_p",
      "The purpose of this project is to analyze youth literacy rate data to
       indicate certain correlations it may have with characteristics of the
       population. The characteristcs we chose to analyze were the countries\'
       \"Least Developing Countries\" status, gender, ")
    )
  )


# Widget to define a variable for the scatter plot
scatter_sidebar_content <- sidebarPanel(
  # An input to select variable for scatter plot
  selectInput(
    "y_var",
    label = "Population:",
    choices = list(
      "Youth" = "Total",
      "Youth Females" = "Female",
      "Youth Males" = "Male"
    )
  ),
  # A description of why we chose a scatter plot
  hr(),
  h4("Our Reasoning:"),
  p("In this chart, we wanted to see if there was a similar relationship
    between the least developing countries (LDC) and their overall youth
    literacy rates. We thought it'd be best to plot this on a scatter plot
    so we could clearly interpret whether the literacy rates of the youth
    were generally high or low.")
)

# Prints out scatter plot
scatter_main_content <- mainPanel(
  plotlyOutput(outputId = "scatter")
)

# Formats the page and stores a tab panel for the scatter panel
scatter_panel <- tabPanel(
    tags$header(
      id = "tab_title",
      "Literacy Rates in LDC"),
  titlePanel("Literacy Rates in Least Developed Countries"),
  sidebarLayout(
    scatter_sidebar_content,
    scatter_main_content
  )
)


# Widget to pick gender and region
barchart_sidebar <- sidebarPanel(
  checkboxGroupInput(
    "area",
    h3("Region:"),
    choices = list(
      "Sub-Saharan Africa" = "SSA",
      "South Africa" = "SA",
      "Middle East and North Africa" = "MENA",
      "Latin America and the Carribean" = "LAC",
      "Europe and Central Asia" = "ECA",
      "East Asia and Pacific" = "EAP"
    ),
    selected = "SSA"
  ),
  # A description of why we chose a bar chart
  hr(),
  h4("Our Reasoning:"),
  p("We created the chart to explore the difference of literacy rate
   across gender (male and female) grouped by regions of the world.
   The data is grouped by the region and plotted by the average literacy
   rate of males and females in each group. The bar plot with two
   percentages of each gender would allow us to compare the differences
   across gender and regions.")
)

# Prints barchart
barchart_main_content <- mainPanel(
  plotlyOutput(outputId = "barchart")
)

# Puts barchart page together
barchart_panel <- tabPanel(
  tags$header(
    id = "tab_title",
    "Literacy Rates By Region"),
  titlePanel("Literacy Rates Based on Regions"),
  sidebarLayout(
    barchart_sidebar,
    barchart_main_content
  )
)

# Widget to pick gender and color s  cheme,
# choose whether show legend or not
mapchart_sidebar <- sidebarPanel(
  # Widget to choose the youth population for the plot
  selectInput(
    "gender",
    "Population: ",
    choices = list(
      "Youth" = "Total",
      "Youth Females" = "Female",
      "Youth Males" = "Male"
    ),
    selected = "Youth"
  ),
  
  # Widget to choose the wanted color scheme for the map
  selectInput(
    "colors",
    "Color Scheme: ",
    rownames(subset(brewer.pal.info, category %in% c("seq", "div"))),
    selected = "RdYlGn"
  ),
  
  # Widget to have the legend
  checkboxInput("legend", "Show legend", TRUE),
  
  # Description why we choose the chart
  hr(),
  h4("Our reasoning: "),
  p("We want to know if the high or low literacy rate countries
    are clustered by their locations and have the overall look of
    literacy rate globally.Therefore, we have visualizations
    of the world map with the literacy rate of each country represented
    by a circle whose color represent its litercy values.")
)

# Prints map chart with chosen variables
mapchart_main_content <- mainPanel(
  leafletOutput("mapchart")
)

# Puts map chart page together
map_panel <- tabPanel(
  tags$header(
    id = "tab_title",
    "Youth Literacy Rate Map"),
  titlePanel("Youth Literacy Rate by Locations"),
  sidebarLayout(
    mapchart_sidebar,
    mapchart_main_content
  )
)

# Defines the 5 pages
ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
  "Literacy Rates Around the World",
  overview_panel,
  barchart_panel,
  scatter_panel,
  map_panel
  # summary
))
