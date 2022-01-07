
weather_ui <- function(id){
  tagList(
    textOutput(NS("weather"))
  )
}

weather_server <- function(id, data){
  moduleServer(
    id, 
    function(input, output, session){
      observeEvent(data(), {
        
      })
      
    }
  
  )
  
}