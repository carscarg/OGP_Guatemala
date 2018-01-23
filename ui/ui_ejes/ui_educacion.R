fluidPage(
  fluidRow(
    column(10, offset = 1, HTML("<center>"),HTML("<h3>EDUCACION</h3>"),HTML("</center>"))
  ),
  
  fluidRow(
    column(10, offset = 1,
           
           
           tabsetPanel(
             tabPanel("Mapa", leafletOutput("mapaeducacion", width = "100%", height = 600) ),
             tabPanel("Cobertura", 
                      fluidRow(
                          column(6, 
                                htmlOutput("coberturapreprimaria")
                                ),
                          column(6,
                                htmlOutput("coberturaprimaria")
                                )
                      
                               ),
                      fluidRow(
                              column(6, 
                                    htmlOutput("preprimpor")
                              ),
                              column(6,
                               htmlOutput("primpor")
                              )
                        
                              ),
                      fluidRow(
                        column(6, 
                               htmlOutput("presupprepri")
                        ),
                        column(6,
                               htmlOutput("presupprim")
                        )
                        
                      ),
                      fluidRow(
                        column(12, 
                               htmlOutput("combo")
                        )
                        
                      ),
                      fluidRow(
                        column(12, 
                               htmlOutput("docentesvsgtototal")
                        )
                        
                      )
                      
                      ),
             tabPanel("Gasto", 
                      fluidRow(
                        column(12, 
                               htmlOutput("Bubble")
                        ),
                        column(12, 
                               htmlOutput("primvsgral")
                        ),
                        column(12,
                               htmlOutput("educaciongraph")
                        )
                      
                      )),
             tabPanel("Base de Datos"),
             tabPanel("Ficha técnica")
           )
           
           
    )),
  fluidRow(
    column(6,""),
    column(6,""))
)