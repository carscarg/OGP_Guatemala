### Server General

shinyServer(function(input, output, session) {
  
  source("server/server_d3Tree.R", local=TRUE)$value
  source("server/server_Presupuesto_Dashboard.R", local=TRUE)$value
  source("server/server_pivot.R", local=TRUE)$value
  source("server/server_poblacion.R", local=TRUE)$value
  source("server/server_educacion.R", local=TRUE)$value
  
 
  
  # Mapa
  
  lat <- 15.7
  lng <- -89.97
  zoom <- 7
  #map = leaflet() %>% addTiles() %>% setView(lat = lat,lng = lng, zoom = zoom) %>% addProviderTiles("Esri.WorldTopoMap") 
  #output$map <- renderLeaflet(map)
  
  
  #####   carga de archivo de mapas
  
  mapaeducacion <- leaflet("map", data = guate) %>%
    setView(lat = lat,lng = lng, zoom = zoom) %>% addProviderTiles("Esri.WorldTopoMap" ) %>%
    addTiles() %>%
    clearShapes() %>%
    clearControls()
  
  output$mapaeducacion <- renderLeaflet(mapaeducacion)

    #guate <- sp::merge(guate, INEpob, by.x='Codigo', by.y='Cod_mun',duplicateGeoms = T)

    qpal <- colorQuantile("Blues", guate$pobx, n = 5, na.color = "#BDBDAE")

    map <- leaflet("map", data = guate) %>%
      setView(lat = lat,lng = lng, zoom = zoom) %>% addProviderTiles("Esri.WorldTopoMap" ) %>%
      addTiles() %>%
      clearShapes() %>%
      clearControls() %>%
      
      addPolygons(data = guate, fillColor = ~qpal(pobx), fillOpacity = 0.5, smoothFactor = 0.2,
                  color = "white", weight = 1, 
                  highlight = highlightOptions(
                    weight = 5,
                    color = "#FF7F00",
                    dashArray = "",
                    fillOpacity = 0.7,
                    bringToFront = TRUE), label = paste(as.character( guate$Municipio), formatC(guate$pobx, big.mark = ",", format = "d", digits = 8)  , sep = "\n")
                  ) %>%
      addLegend(pal = qpal, values = ~guate$pobx, opacity = 0.7,
                position = 'bottomright', na.label = "No aplica",
                #labFormat = function(type, cuts, p) {
                 # n = length(cuts)
                #  paste0(as.integer(cuts[-n])," &ndash; ", as.integer(cuts[-1]))
                  #paste0(formatC( cuts[-n], big.mark = ",", digits = 2, format = "d" ), " &ndash; ", formatC( cuts[-1], big.mark = ",", digits = 2 , format = "d" ))
              #  print(cuts)
               #   },
                title = paste0("<center>Población</center><br />"))
    
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