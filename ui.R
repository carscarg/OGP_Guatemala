### UI General
tagList(
shinythemes::themeSelector(), # Para ver tipos de CSS on the fly
HTML("<link rel='stylesheet' href='css/style.css' media='screen'>"),
HTML("<title>Observatorio del Gasto Público</title>"),
tags$style(type="text/css", ".navbar, .navbar-static-top, navbar-default {height: 110px;} ."),
HTML("<header id='header' class='container clearfix'>"),

navbarPage("",title = img(src = "logo.png", width = "425px", height = "79px"),
           navbarMenu("Inicio", icon=icon("home", lib = "glyphicon"),

                  tabPanel("¿Que es el OGP?",
                           
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
           navbarMenu("Ejes", icon=icon("stats", lib = "glyphicon"),
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
           navbarMenu("Infórmate", icon=icon("info-sign", lib = "glyphicon"),
                      tabPanel("Noticias",
                               plotOutput("Noticias")
                      ),
                      tabPanel("Presupuesto nacional",
                               source("ui/ui_Presupuesto_Dashboard.R", local = TRUE)$value
                      ),
                      tabPanel("Videoteca",
                               h3("Videoteca")
                      ),
                      tabPanel("Centro de documentación",
                               h3("Centro de Documentación")
                      )),
           tabPanel("Enlaces", icon=icon("link", lib = "glyphicon"),
                                h3("Enlaces")
                       )
                      
           

    ),
HTML("</header>")
  )

#source("ui/ui_ejes.R")