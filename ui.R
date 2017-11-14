### UI General
tags$div(height="30%")
tags$div(height="70%")
navbarPage(tags$img(src = "logo.png", width = "100%", height = "90px"),
           navbarMenu("Inicio",
                  tabPanel("¿Que es el OGP?",
                           h3("¿Que es el OGP?")  
                  
                    ),
                  tabPanel("Marco Jurídico",
                           h3("Marco Jurídico")  
                           
                  ),
                  tabPanel("¿Cómo funciona?",
                           h3("¿Cómo funciona?")  
                           
                  )),
           navbarMenu("Ejes",
                    tabPanel("Salud",
                      h3("Salud")
                    ),
                    tabPanel("Educacion",
                      h3("Educacion")
                    ),
                    tabPanel("Seguridad",
                      h3("Seguridad")
                    ),
                    tabPanel("Infraestructura",
                      h3("Infraestructura")
                  )),
           navbarMenu("Infórmate",
                      tabPanel("Noticias",
                               plotOutput("Noticias")
                      ),
                      tabPanel("Presupuesto nacional",
                               source("ui/ui_Presupuesto.R", local = TRUE)$value
                      ),
                      tabPanel("Videoteca",
                               h3("Videoteca")
                      ),
                      tabPanel("Centro de documentación",
                               h3("Centro de Documentación")
                      )),
           tabPanel("Enlaces",
                                h3("Enlaces")
                       )
                      
           )

#source("ui/ui_ejes.R")