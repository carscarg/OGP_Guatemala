
  output$tabla <- renderDataTable({
    #cadena <- paste0(input$myPivotData$rows[[1]],input$myPivotData$cols[[1]],sep =",")
    
    datos <- group_by_(df,input$myPivotData$rows[[1]],input$myPivotData$cols[[1]]) %>% summarise(monto = sum(monto))
    
    if (is.null(input$myPivotData$cols[[1]])==FALSE){
      datos <-spread_(data = datos,key = input$myPivotData$cols[[1]],value = "monto")
    }
    datatable(datos, extensions="Scroller", style="bootstrap", class="compact", width="100%",
              options=list(dom="ft",deferRender=TRUE, scroller=FALSE)) %>%
      formatCurrency(c(2)) %>% 
      formatStyle(c(0), target='row', fontSize = '80%')
    
  })
  output$barras <- renderHighchart({
    datos <- group_by_(df,input$myPivotData$rows[[1]]) %>% summarise(monto = sum(monto))
    
    highchart() %>% 
      hc_chart(type = "column") %>% 
      hc_title(text = "bla") %>% 
      hc_xAxis(categories = datos$Entidad) %>% 
      hc_add_series(data = datos$monto,
                    colorByPoint = TRUE,
                    name = "Monto")
    
  })
  
  output$mypivot = renderRpivotTable({
    rpivotTable(data=df, rows="Entidad",col ="Tipo.de.Gasto",onRefresh=htmlwidgets::JS("function(config) { Shiny.onInputChange('myPivotData', config); }"))
    
  })
  output$quehay <- renderTable(as.tibble(str(input$myPivotData$cols)))
