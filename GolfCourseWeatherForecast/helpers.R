
#' Get weather data from OpenWeather
#'
#' @param lat latitude of the location
#' @param lon longitude of the location
#' @return 
get_weather_info <- function(lat, lon){
  
  API_Key <- Sys.getenv("OWM_API_Key")
  url <- paste0("https://api.openweathermap.org/data/2.5/onecall?lat=",lat,"&lon=",lon,
                "&appid=",API_Key, "&exclude=minutely&units=imperial")
  
  jsonlite::fromJSON(url)
}



tbl_current <- results$current %>% 
  as_tibble() %>% 
  unnest(cols = weather)

tbl_hourly <- results$hourly %>% 
  as_tibble() 

tbl_daily <- results$daily %>% 
  as_tibble()



# local time zone
timezone <- results$timezone

library(lubridate)

UTC_to_Local <- function(utc, my_tz){
  lubridate::as_datetime(utc) %>% 
    lubridate::with_tz(my_tz)
}

UTC_to_Local(tbl_daily$dt, timezone)

UTC_to_Local(tbl_hourly$dt, timezone)


