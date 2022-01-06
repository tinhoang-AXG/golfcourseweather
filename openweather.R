

library(tidyverse)
library(jsonlite)
library(httr)

API_Key <- Sys.getenv("API_Key")

url <- function(lat, lon){
  paste0("https://api.openweathermap.org/data/2.5/onecall?lat=",lat,"&lon=",lon,"&appid=",API_Key, "&exclude=minutely&units=imperial")
}

nc_lat <- 47.539950
nc_lon <- -122.145550

results <- jsonlite::fromJSON(url(nc_lat, nc_lon))

tbl_current <- results$current %>% 
  as_tibble() %>% 
  unnest(cols = weather)

tbl_hourly <- results$hourly %>% 
  as_tibble()

tbl_daily <- results$daily %>% 
  as_tibble()
