## COVID-2019 interactive vaccine tracker tool
## Nicolas Jacobs-Goraya & Hanad Hassan

# https://rviews.rstudio.com/2019/10/09/building-interactive-world-maps-in-shiny/

# update data with automated script
source("texas_data_weekly_vaccinations.R") # run locally to update numbers, but not live on Rstudio server /Users/epp11/Dropbox (VERG)/GitHub/nCoV_tracker/app.R(to avoid possible errors on auto-updates)

# load required packages
if(!require(magrittr)) install.packages("magrittr", repos = "http://cran.us.r-project.org")
if(!require(rvest)) install.packages("rvest", repos = "http://cran.us.r-project.org")
if(!require(readxl)) install.packages("readxl", repos = "http://cran.us.r-project.org")
if(!require(dplyr)) install.packages("dplyr", repos = "http://cran.us.r-project.org")
if(!require(maps)) install.packages("maps", repos = "http://cran.us.r-project.org")
if(!require(ggplot2)) install.packages("ggplot2", repos = "http://cran.us.r-project.org")
if(!require(reshape2)) install.packages("reshape2", repos = "http://cran.us.r-project.org")
if(!require(ggiraph)) install.packages("ggiraph", repos = "http://cran.us.r-project.org")
if(!require(RColorBrewer)) install.packages("RColorBrewer", repos = "http://cran.us.r-project.org")
if(!require(leaflet)) install.packages("leaflet", repos = "http://cran.us.r-project.org")
if(!require(plotly)) install.packages("plotly", repos = "http://cran.us.r-project.org")
if(!require(geojsonio)) install.packages("geojsonio", repos = "http://cran.us.r-project.org")
if(!require(shiny)) install.packages("shiny", repos = "http://cran.us.r-project.org")
if(!require(shinyWidgets)) install.packages("shinyWidgets", repos = "http://cran.us.r-project.org")
if(!require(shinydashboard)) install.packages("shinydashboard", repos = "http://cran.us.r-project.org")
if(!require(shinythemes)) install.packages("shinythemes", repos = "http://cran.us.r-project.org")
if(!require(tidyverse)) install.packages("tidyverse", repos = "http://cran.us.r-project.org")
if(!require(ggmap)) install.packages("ggmap", repos = "http://cran.us.r-project.org")
if(!require(sf)) install.packages("sf", repos = "http://cran.us.r-project.org")
if(!require(mapview)) install.packages("mapview", repos = "http://cran.us.r-project.org")

# set mapping colour for each vaccine manufacturer
pfizer_col = "#cc4c02"
moderna_col = "#662506"
both_col = "#045a8d"

# imported data
# counties = 
# vaccine_data = 
# populations = 

### MAP FUNCTIONS ###















# testing  
register_google(key="AIzaSyCypbYJVA5Yeht5FI92lq2UUGZHxfdZu84")

Texas = get_map(location = c(lon = -100, lat = 31), zoom = 6, maptype = "terrain")
ggmapplot(Texas)

test <- read_csv("C:/Users/Hanad/Documents/vaccine-tracker/vaccine-tracker/input_data/test_data.csv")

sources <- distinct(test, Address, County)

df <- as.data.frame(sources)

locations_df <- mutate_geocode(df, Address)

locations <- as_tibble(locations_df)

locations_sf <- st_as_sf(locations, coords = c("lon", "lat"), crs = 4326)

mapview(locations_sf)

<<<<<<< HEAD
#get("https://og-production-open-data-dentontx-892364687672.s3.amazonaws.com/resources/be1b384f-3b2e-4238-88a8-4410cb36f7fc/c8efcc13-b5b4-48b5-9873-933844822d6ctexascounties.geojson?Signature=Gae8hChkUibDO5r1Erz2vN3EE%2BA%3D&Expires=1609901223&AWSAccessKeyId=AKIAJJIENTAPKHZMIPXQ")

=======
>>>>>>> 65d53a674381cb06ade6e8997a59c1b4bacdffd2

mapview(list(franconia, locations_sf),
        layer.name = c("Texas", "Locations"))

library(lattice)
library(sp)

data(meuse)


tx_data <- read_csv("C:/Users/Hanad/Documents/vaccine-tracker/vaccine-tracker/data_temp/data.csv")
#data.frame(test2)
tx_data <- data.frame(tx_data)
colnames(tx_data)
colnames(tx_data)[colnames(tx_data) == 'Latitude..generated.'] <- 'Latitude'
colnames(tx_data)[colnames(tx_data) == 'Longitude..generated.'] <- 'Longitude' 
colnames(tx_data)
tx_data$Latitude <- as.numeric(tx_data$Latitude)
tx_data$Longitude <- as.numeric(tx_data$Longitude)
pal <- colorFactor(pal = c("#1b9e77", "#d95f02", "#7570b3"), domain = c("Charity", "Government", "Private"))

library(leaflet)
bbmap <- renderLeaflet({
  leaflet(tx_data) %>% 
    addCircles(lng = ~Longitude, lat = ~Latitude) %>% 
    addTiles() %>%
    addCircleMarkers(data = bb_data, lat =  ~Latitude, lng =~Longitude, 
                     #radius = 3, popup = ~as.character(cntnt), 
                     color = ~pal(Category),
                     stroke = FALSE, fillOpacity = 0.8)%>%
    addLegend(pal=pal, values=tx_data$SumDosesRecd,opacity=1, na.label = "Not Available")%>%
    addEasyButton(easyButton(
      icon="fa-crosshairs", title="ME",
      onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
})

bbmap


tx_data %>%
  leaflet() %>%
  addTiles %>%
  addCircleMarkers()
  


  