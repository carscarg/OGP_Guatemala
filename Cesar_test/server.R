library(data.table)
library(dplyr)
library(shiny)
library(rgdal)  
library(leaflet)

lat <- 16
lng <- -89.5
zoom <- 7

gt <- readOGR("shapes/gt.shp", layer = "gt", encoding = "UTF-8")

output$map <- renderLeaflet({
  
  leaflet() %>% 
    setView(lat = lat, lng = lng, zoom = zoom)
})

