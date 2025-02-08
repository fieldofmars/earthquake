#' Load necessary libraries
#' @importFrom dplyr filter

library(dplyr)

#' Filter earthquake data by year and magnitude range
#'
#' This function filters the earthquake data based on the provided year and magnitude range.
#'
#' @param data The earthquake data frame.
#' @param year The selected year to filter by.
#' @param mag_range A numeric vector of length 2 representing the minimum and maximum magnitude values.
#' @return A filtered data frame containing earthquakes within the specified year and magnitude range.
filter_earthquake_data <- function(data, year, mag_range) {
  data %>%
    filter(year == !!year & mag >= mag_range[1] & mag <= mag_range[2])
}
