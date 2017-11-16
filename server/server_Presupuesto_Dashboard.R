## Server Presupuesto_Dashboard

output$presupuesto_barras <- renderHighchart({
  
  datos_treemap <- group_by_(datos_treemap, input$nivel) %>%
    dplyr::summarise(Monto = sum(Monto, na.rm=TRUE)) %>%
    arrange(desc(Monto)) %>%
    as.data.frame()
  
  hc <- highchart() %>% 
    hc_chart(type = "column") %>% 
    hc_title(text = "Presupuesto por Grupo de Gasto") %>% 
    hc_xAxis(categories = datos_treemap$Grupo.Gasto) %>% 
    hc_add_series(data = datos_treemap$Monto,
                  colorByPoint = TRUE,
                  name = "Monto")
      
})

output$presupuesto_tabla <- renderDataTable({
  
  datos_treemap <- group_by_(datos_treemap, input$nivel) %>%
    dplyr::summarise(Monto = sum(Monto, na.rm=TRUE)) %>%
    arrange(desc(Monto)) %>%
    as.data.frame()
  
  datatable(datos_treemap, extensions="Scroller", style="bootstrap", class="compact", width="100%",
            options=list(dom="ft",deferRender=TRUE, scroller=FALSE)) %>%
    formatCurrency(c(2)) %>% 
    formatStyle(c(0), target='row', fontSize = '80%')
  
})
 
output$presupuesto_treemap <- renderHighchart({
  
  datos_treemap <- group_by_(datos_treemap, input$nivel) %>%
    dplyr::summarise(Monto = sum(Monto, na.rm=TRUE)) %>%
    arrange(desc(Monto)) %>%
    as.data.frame()
  
  tm <- treemap(datos_treemap, index = c(input$nivel),
                vSize = "Monto", vColor = input$nivel,
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
  
  sankeyNetwork(Links = datos_sankey$datos, Nodes = datos_sankey$nodes, Source = "source",
                Target = "target", Value = "value", NodeID = "name",
                units = "", fontSize = 12, nodeWidth = 30)
  
})

