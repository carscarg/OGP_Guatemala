## Server Presupuesto_Dashboard

## Creacion de objetos output --------------------------------

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
                units = "", fontSize = 9, nodeWidth = 30, sinksRight = FALSE)
  
})

## Descarga de datos y reportes --------------------------------

# Descarga de Datos
output$descarga_datos <- downloadHandler(
  filename = 'datos_prueba_descarga.csv',
  content = function(file) {
    write.csv(datos_prueba, file, row.names = FALSE)
  }
)

# Crear y descargar reporte en diferentes formatos. IMPORTANTE: Require paquete webshot! 
output$descargaReporte <- downloadHandler(
  filename = function() {
    paste('my-report', sep = '.', switch(
      input$formato, PDF = 'pdf', HTML = 'html', Word = 'docx'
    ))
  },
  
  content = function(file) {
    src <- normalizePath('www/presupuestos_Dashboard_PDF.Rmd')
    
    # temporarily switch to the temp dir, in case you do not have write
    # permission to the current working directory
    owd <- setwd(tempdir())
    on.exit(setwd(owd))
    file.copy(src, 'presupuestos_Dashboard_PDF.Rmd', overwrite = TRUE)
    
    library(rmarkdown)
    out <- render('presupuestos_Dashboard_PDF.Rmd', switch(
      input$formato,
      PDF = pdf_document(), HTML = html_document(), Word = word_document()
    )#, envir = .GlobalEnv)
    )
    file.rename(out, file)
  }
)

# Renderiza flexdashboard
output$presupuesto_flexdashboard <- renderUI({
  
  render("presupuestos_Dashboard.Rmd")
})
