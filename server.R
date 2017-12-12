### Server General

shinyServer(function(input, output, session) {
  
  source("server/server_d3Tree.R", local=TRUE)$value
  source("server/server_Presupuesto_Dashboard.R", local=TRUE)$value
  source("server/server_pivot.R", local=TRUE)$value
  source("server/server_poblacion.R", local=TRUE)$value
  
  # Mapa
  
  lat <- 15.7
  lng <- -89.97
  zoom <- 7
  #map = leaflet() %>% addTiles() %>% setView(lat = lat,lng = lng, zoom = zoom) %>% addProviderTiles("Esri.WorldTopoMap") 
  #output$map <- renderLeaflet(map)
  
  
  #####   carga de archivo de mapas
  
 

    #guate <- sp::merge(guate, INEpob, by.x='Codigo', by.y='Cod_mun',duplicateGeoms = T)

    qpal <- colorQuantile("Blues", guate$AreaKm2, n = 5, na.color = "#FF7F00")

    map <- leaflet("map", data = guate) %>%
      setView(lat = lat,lng = lng, zoom = zoom) %>% addProviderTiles("Esri.WorldTopoMap" ) %>%
      addTiles() %>%
      clearShapes() %>%
      clearControls() %>%
      addPolygons(data = guate, fillColor = ~qpal(AreaKm2), fillOpacity = 0.5,
                  color = "white", weight = 1, 
                  highlight = highlightOptions(
                    weight = 5,
                    color = "#FF7F00",
                    dashArray = "",
                    fillOpacity = 0.7,
                    bringToFront = TRUE), label = paste(as.character( guate$Municipio), formatC(guate$Codigo, big.mark = ",", format = "d", digits = 2)  , sep = "\n") ) 
    output$map <- renderLeaflet(map)
  
  #####
  
  
  
  
 
  source("server/server_poblacion.R", local=TRUE)$value
   
  # Crea objeto carrusel de imagenes para la Home
  output$imginicio <- renderSlickR({
    slickR(
      obj = c("www/educacion.jpg","www/infraestructura.jpg","www/salud.jpg","www/seguridad.jpg"),
      slideId = c('ex2'),
      slickOpts = list(
        initialSlide = 0,
        slidesToShow = 1,
        slidesToScroll = 1,
        focusOnSelect = T,
        autoplay = T,
        autoplaySpeed = 800,
        dots = T
      ),
      height = 100,width='100%'
    )
    
  })
  
})