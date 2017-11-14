### UI General
tags$div(height="30%")
tags$div(height="70%")
navbarPage(tags$img(src = "logo.png", width = "100%", height = "90px"),
           navbarMenu("Inicio",
                  tabPanel("¿Que es el OGP?",
                           tags$h3("¿Que es el OGP?")  
                  
                    ),
                  tabPanel("Marco Jurídico",
                           tags$h3("Marco Jurídico")  
                           
                  ),
                  tabPanel("¿Cómo funciona?",
                           tags$h3("¿Cómo funciona?")  
                           
                  )),
           navbarMenu("Ejes",
                    tabPanel("Salud",
                      tags$h3("Salud")
                    ),
                    tabPanel("Educacion",
                      tags$h3("Educacion")
                    ),
                    tabPanel("Seguridad",
                      tags$h3("Seguridad")
                    ),
                    tabPanel("Infraestructura",
                      tags$h3("Infraestructura")
                  )),
           navbarMenu("Infórmate",
                      tabPanel("Noticias",
                               verbatimTextOutput("Noticias")
                      ),
                      tabPanel("Presupuesto nacional",
                               verbatimTextOutput("Noticias")
                      ),
                      tabPanel("Videoteca",
                               tags$h3("Videoteca")
                      ),
                      tabPanel("Centro de documentación",
                               tags$h3("Centro de Documentación")
                      )),
           tabPanel("Enlaces",
                                tags$h3("Enlaces")
                       )
                      
           )

#source("ui/ui_ejes.R")