fluidPage(
  fluidRow(
    column(10, offset = 1, HTML("<center>"),HTML("<h3>POBLACI&Oacute;N INE</h3>"),HTML("</center>"))
    ),
  # fluidRow(
  #   column(10, offset = 1, HTML("<center>"),div(selectInput("municipio", "Seleccione Municipio", choices = lista_municipios, selected = lista_municipios[1]), style = "padding-left: 5px;"),HTML("</center>"))
  # ),
  fluidRow(
    column(10, offset = 1,
          
         
             tabsetPanel(
               tabPanel("Mapa", leafletOutput("map", width = "100%", height = 600)),
               tabPanel(HTML("Gr&aacute;fica"), 
                        column(3, HTML("<br />"),
                        selectInput("departamento", "Departamento", choices = depto),
                        uiOutput("combo2"),
                        selectInput("anio", "Año", choices = anios)),
                        column(7,offset = 1,
                        
                       highchartOutput("poblacion")
                        )
               ),
               tabPanel("Base de Datos", 
                        
                        dataTableOutput('poblacion_tabla'),
               downloadButton("descargar",label="Descargar")),
               tabPanel(HTML("Ficha t&eacute;cnica"), tags$iframe(style="height:1200px; width:100%; scrolling=yes", 
                                                     src="http://observatorio.minfin.gob.gt/document/proyeccion_poblacion.pdf"))
             )
           
           
  )),
  fluidRow(
    column(6,""),
    column(6,""))
)






# fluidRow(column(3,
#                 tags$div()
#                 ),
#         
#           column(4, offset = 1,
#             tags$div(plotOutput("poblacion")) )
# )