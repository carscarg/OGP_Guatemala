fluidPage(
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
)