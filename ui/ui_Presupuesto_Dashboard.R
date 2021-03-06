## UI presupuesto Dashboard

tabsetPanel(selected = "Dashboard",
            tabPanel("Dashboard",
                     fluidPage(
                       absolutePanel(id='parametros', class = "panel panel-default", fixed = TRUE, draggable = TRUE, top = 200,
                                     left = "auto", right = 50, bottom = "auto", width = 150, height = "100%",
                                     tags$style(type='text/css', ".selectize-input { font-size: 80%; line-height: 10px; width: 95%; min-height: 25px; max-height: 30px} .selectize-dropdown { font-size: 80%; line-height: 15px; }"), 
                                     div(selectInput("nivel", "Seleccione nivel", choices = lista_niveles, selected = lista_niveles[1]),style = "padding-left: 5px;"),
                                     br(),
                                     radioButtons('formato', 'Descarga un reporte en formato:', c('PDF', 'HTML', 'Word'),
                                                  inline = FALSE),
                                     downloadButton('descargaReporte',label = 'Descargar'),
                                     br(),
                                     br(),
                                     h5("Descarga los datos en formato .csv:"),
                                     downloadButton('descarga_datos', label = 'Descargar')
                                     
                       ),
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
            tabPanel("pivot",
                     source("ui/ui_pivot.R", local = TRUE)$value
            ),
            tabPanel("Flexdashboard",
                     h5("Una vez desplegado en el shiny-server, un fichero .Rmd se puede llamar en un navegador con este link:
                        http://server.host/OGP_Guatemala/presupuestos_Dashboard.Rmd
                        Reemplazar 'server.host' por el raiz real del host y el nombre del fichero .Rmd que se quiera ejecutar. En este caso tiene que ser un flexdashboard.")
                     #div(a("Abrir Flexdashboard",href = 'http://server.host/OGP_Guatemala/presupuestos_Dashboard.Rmd', class = "btn btn-default"))
                     #uiOutput('presupuesto_flexdashboard')
                     ),
            tabPanel("Navegador Arbol",
                     source("ui/ui_d3Tree.R", local = TRUE)$value
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



