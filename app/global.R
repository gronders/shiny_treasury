library(shinyjs)
library(shroomDK)
library(data.table)
library(plotly)
library(dplyr)
library(reactable)

example_data <- data.frame(
  x = 1:100, 
  y = abs(rnorm(100)),
  z = abs(ceiling(rnorm(100))),
  a = as.factor(sample(LETTERS[1:5], 100, replace = TRUE))
)
