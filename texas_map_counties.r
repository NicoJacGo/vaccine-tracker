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
library(ggmap)


# highlighting Texas

tx <- tigris::counties(state = "TX", cb=T)

leaflet(tx) %>%
  addTiles() %>%
  addPolygons(color = "grey", fillOpacity = 0.1, smoothFactor = 0.5, weight = 2)



# testing 

USA <- getData(name = "GADM", country = "USA", level = 2)

texas <- subset(USA, NAME_1=="Texas")

wld <- rasterToPolygons(raster(ncol = 1, nrow = 1, crs = proj4string(texas)))
msk <- gDifference(wld, texas)

m <- mapview(msk, color = "white", alpha = 1, alpha.regions = 1) + texas
m


# more masking testing 
zoomLevel <- 5.3
register_google(key="AIzaSyCypbYJVA5Yeht5FI92lq2UUGZHxfdZu84")


texas.center <- geocode("texas")


texas.map <- map(texas, fill = TRUE, col = 1, plot = F)

texas.map.ids <- sapply(strsplit(texas.map$names, ':'), function(x) x[1])

texas.sp <- map2SpatialPolygons(texas.map, ID= texas.map.ids, proj4string=CRS("+proj=longlat +datum=WGS84"))

tmp.id.df <- data.frame(ID = names(texas.sp))

rownames(tmp.id.df) <- names(texas.sp)
texas.spdf <- SpatialPolygonsDataFrame(texas.sp, tmp.id.df)

l.texas.map <- leaflet( texas.spdf ) %>% 
  addTiles() %>%
  addPolygons( data = ita.spdf, weight = 1, fillColor = "blue", fillOpacity = 0.5 )

l.texas.map

wld.sp <- rasterToPolygons(raster(ncol = 1, nrow = 1, crs = proj4string(texas.sp)))
texas.sp.mask <- gDifference(wld.sp, texas.sp)
tmp.id.df <- data.frame(ID = "1")
rownames(tmp.id.df) <- names(texas.sp.mask)
texas.mask.spdf <- SpatialPolygonsDataFrame(texas.sp.mask, tmp.id.df)

l.texas.mask.map <- leaflet(texas.mask.spdf) %>%
  setView(lng = texas.center$lon, lat = texas.center$lat, zoom = zoomLevel) %>%
  addTiles() %>%
  addProviderTiles("Esri.WorldGrayCanvas",
                   options = providerTileOptions(minZoom=10, maxZoom=18)) %>%
  addPolygons(data = texas.mask.spdf, fillColor = "grey", fillOpacity = 1.0, color = "black", weight = 1)

l.texas.mask.map

