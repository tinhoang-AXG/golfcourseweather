

map_ui <- function(id){
  tagList(
    leafletOutput(NS(id, "course"))
  )
}

map_server <- function(id, data){
  moduleServer(
    id, 
    function(input, output, session){
      
      API_Key <- Sys.getenv("OWM_API_Key")
      
      observeEvent(data(), {
        
        output$course <- renderLeaflet({
          leaflet() %>%
            addTiles() %>%
            setView(lng = data()$lon,
                    lat = data()$lat,
                    zoom = 14) %>% 
            addWMSTiles(
              paste0("https://tile.openweathermap.org/map/precipitation_new/14/",
                     data()$lon,"/", data()$lat,".png?appid=",API_Key),
              layerId = "precipitation_new",
              layers = "precipitation_new",
              options = WMSTileOptions(format = "image/png", transparent = TRUE),
              attribution = "Weather data © 2012 IEM Nexrad"
            )
        })
      })
    }
  )
}