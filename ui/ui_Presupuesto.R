# UI Presupuesto

fluidPage(
  fluidRow(
    column(6,
           uiOutput("Hierarchy"),
           #verbatimTextOutput("results"),
           #tableOutput("clickView"),
           d3treeOutput(outputId="d3",width = '100%',height = '600px')
    ),
  fluidRow(  
    column(6,
           dataTableOutput('table')
      )
    )
  )
)