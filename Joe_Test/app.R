library(rpivotTable)
library(shiny)
library(dplyr)


tabla_cruda <- readRDS("formulacion2018.rds")
df <- group_by(tabla_cruda,Entidad,Programa,Unidad.Ejecutora,Grupo.Gasto,Tipo.de.Gasto,Fuente.Financiamiento) %>% summarise(monto = sum(Recomendado.2018, na.rm=TRUE))

server <- function(input, output) {


  
  output$mypivot = renderRpivotTable({
    rpivotTable(data=df, onRefresh=htmlwidgets::JS("function(config) { Shiny.onInputChange('myPivotData', config); }"))
  
    })
  output$quehay <- renderTable(as.tibble(str(input$myPivotData$cols)))
}

ui <- shinyUI(fluidPage(
  fluidRow(
   
    column(12, rpivotTableOutput("mypivot"))
  ),
  fluidRow(
  column(12,tableOutput("quehay"))
  
)
))

shinyApp(ui = ui, server = server) 