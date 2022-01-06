
library(shiny)
library(leaflet)
library(bs4Dash)
ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(
        title = "Controls",
        sliderInput("slider", "Number of observations:", 1, 100, 50)
      )
    ),
    fluidRow(
      box(
        leafletOutput("my_club")
      )
    )
  )
)

server <- function(input, output) {
  output$my_club <- renderLeaflet({
    leaflet() %>% 
      addTiles() %>% 
      setView(lng = -122.145550,
              lat = 47.539950,
              zoom = 14)
  })
  
}

shinyApp(ui, server)
