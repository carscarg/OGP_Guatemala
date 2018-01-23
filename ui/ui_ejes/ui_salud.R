fluidPage(
  fluidRow(
    column(10, offset = 1, HTML("<center>"),HTML("<h3>SALUD</h3>"),HTML("</center>"))
  ),
  
  fluidRow(
    column(10, offset = 1,
           
           
           tabsetPanel(
             tabPanel("Mapa" ),
             tabPanel("Gráfica"),
             tabPanel("Base de Datos"),
             tabPanel("Ficha técnica")
           )
           
           
    )),
  fluidRow(
    column(6,""),
    column(6,""))
)