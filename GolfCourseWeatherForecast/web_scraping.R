
library(rvest)
library(xml2)
library(dplyr)
library(purrr)

# Scrape WAGolf website to get course names and addresses

wagolf <- read_html("https://wagolf.org/courses/?city=all&state=Washington")

# extract the course name
course_name <- wagolf %>% 
  html_nodes('.course__name') %>%
  html_text()

# extract the city name
course_city <- wagolf %>% 
  html_nodes('.course__city') %>% 
  html_text() %>% 
  stringr::str_remove_all("[\n\t]")

# extract the url
url <- wagolf %>% 
  html_nodes('.course__name a') %>% 
  html_attr('href')

course_df <- tibble::tibble(course_name = course_name[-1],
                            city = course_city[-1],
                            url = url)

addr <- c()

for (i in 1:234){
  addr[i] <- read_html(url[i]) %>% 
    html_nodes('.course__details-address') %>% 
    html_text()
}

course_df$addr <- addr


# Get geocode for each of the address
register_google(Sys.getenv("Google_API"))

course_location <- geocode(course_df$addr)


# Bind data and save
course_df <- bind_cols(course_df, course_location)

saveRDS(course_df, "course_df")
