### UI General
tagList(
HTML("<link rel='stylesheet' href='css/style.css' media='screen'>"),
HTML("<body style>"),
HTML("<header id='header' class='container clearfix'>"),
img(src = "logo.png", width = "425px", height = "79px"), 
navbarPage("",
           navbarMenu("Inicio",
                  tabPanel("¿Que es el OGP?",
                           h3("¿Que es el OGP?"),
                           HTML("<center>"),slickROutput("imginicio", width = "940px", height = "380px"),HTML("</center>"),
                           br(), br(),
                           includeHTML("html/slider.html")
                          ## shiny::includeMarkdown("rmd/test.Rmd")

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
                    tabPanel("Educación",
                      h3("Educación")
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
                      
           

    ),
HTML("</header>"),
HTML("</body>")
  )

#source("ui/ui_ejes.R")