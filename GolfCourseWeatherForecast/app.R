
library(shiny)
library(leaflet)
library(bs4Dash)
library(shinyWidgets)
library(tidyverse)
library(jsonlite)
library(httr)

source("mod-map.R")
source("mod-weather.R")
courses <- readRDS("course_df")

ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(),
  dashboardBody(

    fluidRow(
      box(
        pickerInput("course", label = NULL, choices = courses$course_name, 
                    options = list(title = "Select a course", `live-search`=TRUE)),
        map_ui("my_course")
      )
    )
  )
)

server <- function(input, output) {
  
  selected_course <- eventReactive(input$course, {
    courses %>% filter(course_name == input$course)
  })
  
  map_server("my_course", reactive({selected_course()}))

}

shinyApp(ui, server)
