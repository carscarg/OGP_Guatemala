library(rpivotTable)
library(shiny)
library(dplyr)
library(highcharter)
library(reshape2)

tabla_cruda <- readRDS("formulacion2018.rds")
df <- group_by(tabla_cruda,Entidad,Programa,Unidad.Ejecutora,Grupo.Gasto,Tipo.de.Gasto,Fuente.Financiamiento) %>% summarise(monto = sum(Recomendado.2018, na.rm=TRUE))
#datos <- group_by(df,Entidad) %>% summarise(monto = sum(monto))

server <- function(input, output) {
  
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
  output$quehay <- renderTable(as.tibble(str(input$myPivotData$rows)))
}

ui <- shinyUI(fluidPage(
  fluidRow(
   
    column(12, rpivotTableOutput("mypivot"))
  ),
  fluidRow(
  column(12,tableOutput("quehay"))
  ),
  fluidRow(
    column(12,highchartOutput("barras"))
    ),
  fluidRow(
    column(12,dataTableOutput("tabla"))
  )
))

shinyApp(ui = ui, server = server) 