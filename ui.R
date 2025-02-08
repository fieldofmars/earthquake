#' Load necessary libraries
#' @importFrom shiny fluidPage sidebarLayout sidebarPanel mainPanel selectInput sliderInput tabsetPanel tabPanel plotOutput

library(shiny)

#' Define UI for application
#'
#' This function defines the user interface for the Shiny app.
ui <- fluidPage(
  titlePanel("Earthquake Data Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "year",
                  label = "Select Year:",
                  choices = unique(earthquake_data$year)),
      sliderInput(inputId = "mag_range",
                  label = "Magnitude Range:",
                  min = min(earthquake_data$mag),
                  max = max(earthquake_data$mag),
                  value = c(min(earthquake_data$mag), max(earthquake_data$mag)))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Map", plotOutput(outputId = "map_plot")),
        tabPanel("Magnitude Distribution", plotOutput(outputId = "mag_plot")),
        tabPanel("Depth Distribution", plotOutput(outputId = "depth_plot"))
      )
    )
  )
)
