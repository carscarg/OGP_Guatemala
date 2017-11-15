## Server Presupuesto_Dashboard

output$presupuesto_barras <- renderHighchart({
      
  datos_origen <- read.csv("datos/datos_prueba_shanky.csv")
  
  datos_origen <- dplyr::group_by(datos_origen, Grupo.Gasto) %>%
    dplyr::summarise(monto = sum(Recomendado.2018, na.rm=TRUE)) %>%
    ungroup() %>%
    filter(monto > 0) %>% 
    as.data.frame()
  
  datos_origen <- mutate_if(datos_origen, is.factor,as.character) %>%
    as.data.frame()
  
  hc <- highchart() %>% 
    hc_chart(type = "column") %>% 
    hc_title(text = "A highcharter chart") %>% 
    hc_xAxis(categories = datos_origen$Grupo.Gasto) %>% 
    hc_add_series(data = datos_origen$monto,
                  colorByPoint = TRUE,
                  name = "monto")
      
})

output$presupuesto_tabla <- renderDataTable({
  
  datos_origen <- read.csv("datos/datos_prueba_shanky.csv")
  
  datos_origen <- dplyr::group_by(datos_origen, Grupo.Gasto) %>%
    dplyr::summarise(monto = sum(Recomendado.2018, na.rm=TRUE)) %>%
    ungroup() %>%
    filter(monto > 0) %>% 
    as.data.frame()
  
  datos_origen <- mutate_if(datos_origen, is.factor,as.character) %>%
    arrange(desc(monto)) %>%
    as.data.frame()
  
  datatable(datos_origen, options = list(dom="ft"), rownames = FALSE) %>%
    formatCurrency(1) %>% 
    formatStyle(0, fontSize = '80%')
  
})
 
output$presupuesto_treemap <- renderHighchart({
  
  datos_origen <- read.csv("datos/datos_prueba_shanky.csv")
  
  datos_origen <- dplyr::group_by(datos_origen, Grupo.Gasto) %>%
    dplyr::summarise(monto = sum(Recomendado.2018, na.rm=TRUE)) %>%
    ungroup() %>%
    filter(monto > 0) %>% 
    as.data.frame()
  
  datos_origen <- mutate_if(datos_origen, is.factor,as.character) %>%
    arrange(desc(monto)) %>%
    as.data.frame()
  
  tm <- treemap(datos_origen, index = c("Grupo.Gasto"),
                vSize = "monto", vColor = "Grupo.Gasto",
                type = "index",
                draw = FALSE)
  
  highchart() %>% 
    hc_add_series_treemap(tm, allowDrillToNode = TRUE,
                          layoutAlgorithm = "squarified",
                          name = "Presupuestos") %>% 
    hc_title(text = "Presupuestos") %>% 
    hc_tooltip(pointFormat = "<b>{point.name}</b>:<br>
               Programa: {point.:,.0f}<br>
               Monto: {point.value:,.0f}")
  
})

output$presupuesto_mapa <- renderSankeyNetwork({
  
  datos_origen <- read.csv("datos/datos_prueba_shanky.csv")
  datos <- prepararInput_Sankey(datos_origen)
  
  sankeyNetwork(Links = datos$datos, Nodes = datos$nodes, Source = "source",
                Target = "target", Value = "value", NodeID = "name",
                units = "", fontSize = 12, nodeWidth = 30)
  
})

