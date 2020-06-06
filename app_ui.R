library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("RColorBrewer")

# Overview page
overview_panel <- tabPanel(
  "Overview",
  titlePanel("Project Overview"),
  mainPanel(
    p("The purpose of this project is to analyze youth literacy rate data to
      indicate certain correlations it may have with characteristics of the
      population. The characteristcs we chose to analyze were the countries\'
      \"Least Developed Countries\" status, gender, and general location."),
    p("Our data is the Youth literacy rate for 15-24 years in different
      countries. The data was found on the ",
      a(href = "https://data.unicef.org/resources/dataset/education-data/",
        "UNICEF"),
      "website. UNICEF referenced the databases from the UNESCO
      Institute for Statistics and Education for All Global Monitoring Report
      2013/14: Teaching and Learning – Achieving Quality for All by UNESCO for
      their data."),
    p("Literacy rates of youths are a good indicator of flaws in the education
      system and could provide interesting conclusions when compared with other
      data (e.g. country GDP). Furthermore, literacy is a crucial factor in
      human development and economic growth, making it very important to
      improve our education systems."),
    img(src = "kids_in_classroom.jpeg", align = "left")
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
  "Scatter",
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
    selected = c("SSA", "SA")
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
  "Literacy Rates By Region",
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
  "Youth Literacy Rate Map",
  titlePanel("Youth Literacy Rate by Locations"),
  sidebarLayout(
    mapchart_sidebar,
    mapchart_main_content
  )
)

# Summary page
summary_panel <- tabPanel(
  "Summary Takeaways",
  titlePanel("Summary Takeaways"),
  mainPanel(
    h3("Takeaway #1"),
    plotlyOutput(outputId = "summ_barchart"),
    p(),
    p("There is a generally higher percentage of literate male youths than
      female. The bar chart above displays the male/female youth literacy
      percentage for South Africa (SA) and Sub-Saharan Africa (SSA). This
      observation may be due to remnants of sexism and traditional values
      in the education system. It implies a need for an emphasis on
      female education."),
    h3("Takeaway #2"),
    plotlyOutput(outputId = "summ_scatter"),
    p(),
    p("The distribution of literacy rates among the Least Developed Countries
      is surprisingly scattered. The scatter plot above displays the literacy
      rate of all youths in every Least Developed Country (LDC). The obvious
      assumption about literacy rates in LDCs is that it will be generally
      lower, but, as shown in the scatter plot, there are many LDCs that have
      near 100% youth literacy rate. This suggests that the LDC category used
      in the data may not be current, education reform in LDCs has been
      successful, or the literacy rate data is inaccurate."),
    h3("Takeaway #3"),
    leafletOutput(outputId = "summ_map"),
    p(),
    p("The lower youth literacy rates tend to be concentrated around central
      to lower African regions. The map above displays the youth literacy
      rate by region, where the color scale is red-yellow-green, corresponding
      to the literacy rate percentages as shown in the legend. As shown, most
      of the red dots (<60% literacy rate) are concentrated around the central
      and lower African regions. This suggests that education efforts are not
      as strong and/or successful in the central and lower African regions.
      The observation implies a need for education reform in those regions to
      focus resources on educating youth.")
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
  map_panel,
  summary_panel
))
