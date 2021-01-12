library(plotly)

data <- read.csv("data.csv")

names(data) <- c("County", "Cutoffs", "Doses", "Product", "PHR", "Latitude", "Longitude")

fig <- data 
fig <- fig %>%
  plot_ly(
    type = 'densitymapbox',
    lat = ~Latitude,
    lon = ~Longitude,
    coloraxis = 'coloraxis',
    radius = 30) 
fig <- fig %>%
  layout(
    mapbox = list(
      style="stamen-terrain",
      center= list(lon=180)), coloraxis = list(colorscale = "Viridis"))
fig

