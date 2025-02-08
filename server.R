#' Load necessary libraries
#' @importFrom shiny renderPlot reactive source

library(shiny)

#' Source custom functions
source("src/functions.R")

#' Load and prepare earthquake data
earthquake_data <- load_earthquake_data() %>%
  prepare_earthquake_data()

#' Define server logic
#'
#' This function defines the server logic for the Shiny app.
server <- function(input, output) {
  # Reactive expression to filter data based on user input
  filtered_data <- reactive({
    earthquake_data %>%
      filter(year == input$year,
             mag >= input$mag_range[1],
             mag <= input$mag_range[2])
  })

  # Render map plot
  output$map_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = long, y = lat, color = mag)) +
      geom_point(size = 3) +
      theme_minimal() +
      labs(title = "Earthquake Locations",
           x = "Longitude",
           y = "Latitude",
           color = "Magnitude")
  })

  # Render magnitude distribution plot
  output$mag_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = mag)) +
      geom_histogram(binwidth = 0.5, fill = "blue", color = "black") +
      theme_minimal() +
      labs(title = "Magnitude Distribution",
           x = "Magnitude",
           y = "Frequency")
  })

  # Render depth distribution plot
  output$depth_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = depth)) +
      geom_histogram(binwidth = 5, fill = "green", color = "black") +
      theme_minimal() +
      labs(title = "Depth Distribution",
           x = "Depth (km)",
           y = "Frequency")
  })
}
