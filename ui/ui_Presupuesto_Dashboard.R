## UI presupuesto Dashboard

tabsetPanel(selected = "Viz1",
            tabPanel("Viz1",
                     fluidPage(
                       div(
                         fluidRow(
                           column(6,
                                highchartOutput('presupuesto_barras')
                                ),
                           column(6,
                                dataTableOutput('presupuesto_tabla')
                                )
                           ), height = '80%'),
                       div(
                         fluidRow(
                           column(6,
                                highchartOutput('presupuesto_treemap')
                                ),
                           column(6,
                                sankeyNetworkOutput('presupuesto_mapa')
                                )
                           ), height = '80%')
                       )
                     ),
            tabPanel("Viz2"
                     
            ),
            tabPanel("Viz3"
                     ),
            tabPanel("Avanzado"
                     ),
            tabPanel("Navegador"
            
                     )
)

# h4("IFC ASA", style="color:#3399ff"),
# h4("Active",style="color:#3399ff"),
# h6("Download:",downloadLink("dataASA_IFCActive","data",class = "plot-download")),
# dataTableOutput('ifcActive'),
# br(),
# h4("Pipeline",style="color:#3399ff"),
# h6("Download:",downloadLink("dataASA_IFCPipeline","data",class = "plot-download")),
# dataTableOutput('ifcPipeline'),
# br(),
# h4("Closed",style="color:#3399ff"),
# h6("Download:",downloadLink("dataASA_IFCClosed","data",class = "plot-download")),
# dataTableOutput('ifcClosed'),
# br()



