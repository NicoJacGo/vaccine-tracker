# counties for Texas 
library(leaflet)
library(tigris)
library(sf)
library(raster)
library(rgeos)
library(mapview)
library(maptools)
library(sp)
library(maps)


# highlighting Texas

tx <- tigris::counties(state = "TX", cb=T)

leaflet(tx) %>%
  addTiles() %>%
  addPolygons(color = "grey", fillOpacity = 0.1, smoothFactor = 0.5, weight = 2)



# testing 

USA <- getData(name = "GADM", country = "USA", state = "TX", level = 2)

texas <- subset(USA, NAME_1=="Texas")

wld <- rasterToPolygons(raster(ncol = 1, nrow = 1, crs = proj4string(texas)))
msk <- gDifference(wld, texas)

m <- mapview(msk, color = "grey", alpha = 1, alpha.regions = 1) + texas
m
