library(data.table)
library(dplyr)
library(shiny)
library(rgdal)  
library(leaflet)

select <- dplyr::select

proveedor <- "Esri.WorldTopoMap"
guate <- readOGR("Cesar_test/mapa/shapes/gt.shp",  encoding = "UTF-8")

gdp = fread("Cesar_test/mapa/munis2017.csv", sep = ',', na.strings = "",header = T, stringsAsFactors = T)
gdp = gdp[rowSums(is.na(gdp)) != ncol(gdp),] %>% as.data.frame()

categorias <- levels(gdp$Clase)

colnames(gdp)[2] <- "Codigo"



# Define UI 


ui <- shinyUI(  fluidPage(
  fluidRow(
    column(7, offset = 1,
           HTML("<div height='100%' width='100%'>"),leafletOutput("map", width = "100%"),HTML("</div>"),
           br(),
           actionButton("reset_button", "Resetear")),
    column(3,
           uiOutput("categoryOut", align = "left")))
))



# Define server 



server <- (function(input, output, session) {
  
  output$categoryOut <- renderUI({
    selectInput("category", "Clase de Ingreso:",
                categorias, selected = "INGRESOS DE OPERACION")
  })  
  
  selected <- reactive({
    if( is.null( input$category) ){
      data <- gdp %>%
        select(Codigo,Clase, Percibido) %>%
        filter( Clase == "INGRESOS DE OPERACION" )%>%
        group_by( Codigo ) %>%
        summarise(Percibido = sum(as.numeric( gsub( ",", "", as.character(Percibido)), na.rm = F )  ))   
    }else{
    data <- gdp %>%
      select(Codigo,Clase, Percibido) %>%
      filter( Clase == input$category ) %>%
      group_by( Codigo ) %>%
      summarise(Percibido = sum(as.numeric( gsub( ",", "", as.character(Percibido)), na.rm = F )  ))   
    }
    data$Codigo <-  as.numeric( substring(as.character(data$Codigo),5,8) )

    return(data)
  })
  
  output$title <- renderText({
    req(input$category)
    paste0(input$category, "   Ingresos municipales")
  })
  
  output$period <- renderText({
    req(input$category)
    paste("...")
  })
  
  lat <- 16
  lng <- -89.5
  zoom <- 7
  
  output$map <- renderLeaflet({
    
    generico<- leaflet("map","Esri.WorldTopoMap") %>% 
      setView(lat = lat, lng = lng, zoom = zoom)
  })
  
  
  observe({

    guate1 <- sp::merge(guate, selected(), by.x='Codigo', duplicateGeoms = T)
  
    qpal <- colorQuantile("YlGn", guate1$Percibido, n = 5, na.color = "#bdbdbd")
   
    popup <- paste0("Mapa")
    
    leafletProxy("map", data = guate1) %>%
      addProviderTiles("Esri.WorldTopoMap" ) %>%
      addTiles() %>%
      clearShapes() %>%
      clearControls() %>%
      addPolygons(data = guate1, fillColor = ~qpal(Percibido), fillOpacity = 0.7,
                  color = "white", weight = 2, popup = popup,
                  highlight = highlightOptions(
                    weight = 5,
                    color = "#666",
                    dashArray = "",
                    fillOpacity = 0.7,
                    bringToFront = TRUE), label = paste(as.character( guate1$Municipio), formatC(guate1$Percibido, big.mark = ",", format = "d", digits = 2)  , sep = "\n") )%>%
      addLegend(pal = qpal, values = ~Percibido, opacity = 0.7,
                position = 'bottomright', na.label = "No aplica",
                labFormat = function(type, cuts, p) {
                  n = length(cuts)
                  paste0(formatC( cuts[-n], big.mark = ",", digits = 2, format = "d" ), " &ndash; ", formatC( cuts[-1], big.mark = ",", digits = 2 , format = "d" ))
                },
                title = paste0(input$category, "<br>"))

    tryCatch(
    mapita<-leafletProxy("map", data = guate1) %>%
      addProviderTiles("Esri.WorldTopoMap" ) %>%
      clearShapes() %>%
      clearControls() %>%
      addPolygons(data = guate1, fillColor = ~qpal(Percibido), fillOpacity = 0.7,
                  color = "white", weight = 2, popup = popup,
      highlight = highlightOptions(
        weight = 5,
        color = "#666",
        dashArray = "",
        fillOpacity = 0.7,
        bringToFront = TRUE), label = paste(as.character( guate1$Municipio), formatC(guate1$Percibido, big.mark = ",", format = "d", digits = 2)  , sep = "\n") )%>%
      addLegend(pal = qpal, values = ~Percibido, opacity = 0.7,
                position = 'bottomright', na.label = "No aplica",
                labFormat = function(type, cuts, p) {
                  n = length(cuts)
                  paste0(formatC( cuts[-n], big.mark = ",", digits = 2, format = "d" ), " &ndash; ", formatC( cuts[-1], big.mark = ",", digits = 2 , format = "d" ))
                },
                title = paste0(input$category, "<br>"))
    , error =  function(c) {leafletProxy("map", data = guate1) %>%
      addProviderTiles("Esri.WorldTopoMap") %>%
      clearShapes() %>%
      clearControls() %>%
      addPolygons()} )
  })
  
  observe({
    input$reset_button
    leafletProxy("map") %>% addProviderTiles("Esri.WorldTopoMap" ) %>% setView(lat = lat, lng = lng, zoom = zoom)
  })    
  

})


# Run the application 
shinyApp(ui = ui, server = server)

