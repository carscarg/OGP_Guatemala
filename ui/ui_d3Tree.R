# UI Presupuesto

fluidPage(
  fluidRow(
    column(6,
           uiOutput("d3Tree_variables"),
           textOutput('outVariables'),
           verbatimTextOutput("d3Tree_resultado"),
           tableOutput("d3Tree_vista_click"),
           d3treeOutput("d3Tree_arbol",width = '100%',height = '600px')
    ),
    column(6,
           dataTableOutput('d3Tree_tabla')
      )
  )
)