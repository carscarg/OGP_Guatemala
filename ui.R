### UI General
tagList(
#shinythemes::themeSelector(), # Para ver tipos de CSS on the fly

  fluidPage(
    fluidRow(
      column(1,""),
      column(10,  
  
HTML("<link rel='stylesheet' href='css/style.css' media='screen'>"),
HTML("<title>Observatorio del Gasto Público</title>"),
tags$style(type="text/css", ".navbar, .navbar-static-top, navbar-default {height: 60px;} ."),
tags$style(type="text/css", "poblacion {height: 50%; width: 50%;} ."),
tags$img(src = "logotest.png", width = "100%", height = "100%"),
br(),
#HTML("<header id='header' class='container clearfix'>"),

tags$style(type="text/css", "body {width: 100%; padding-top: 5px;}"),

navbarPage(theme = shinytheme("spacelab"),"", position = "static-top",
           navbarMenu("Inicio", icon=icon("home", lib = "glyphicon"),

                  tabPanel("Inicio",
                           
                          #leafletOutput("map", width = "100%", height = 600),
                           
                           
                           HTML("<center>"),slickROutput("imginicio", width = "940px", height = "380px"),HTML("</center>"),
                           br(), br(),
                           includeHTML("html/slider.html")
                          ## shiny::includeMarkdown("rmd/test.Rmd")

                    ),
                  tabPanel("¿Qué es el OGP?",
                           h3("¿Qué es el OGP?"),
                           tags$iframe(style="height:800px; width:100%; scrolling=yes", 
                                       src="http://observatorio.minfin.gob.gt/document/queeselogp.pdf")
                           
                           
                  ),
                  tabPanel("Marco Jurídico",
                           h3("Marco Jurídico"),
                           tags$iframe(style="height:800px; width:100%; scrolling=yes", 
                                       src="http://observatorio.minfin.gob.gt/document/marcolegal.pdf")
                           
                  ),
                  tabPanel("¿Cómo funciona?",
                           h3("¿Cómo funciona?"),
                           tags$iframe(style="height:800px; width:100%; scrolling=yes", 
                                       src="http://observatorio.minfin.gob.gt/document/comofunciona.pdf")
                           
                  )),
           navbarMenu("Ejes", 
                    tabPanel("Salud", icon=icon("heart", lib = "glyphicon"),
                      h3("Salud")
                    ),
                    tabPanel("Educación", icon=icon("education", lib = "glyphicon"),
                      h3("Educación")
                    ),
                    tabPanel("Seguridad", icon=icon("user", lib = "glyphicon"),
                      h3("Seguridad")
                    ),
                    tabPanel("Infraestructura", icon=icon("road", lib = "glyphicon"),
                      h3("Infraestructura")
                  )),
           
           navbarMenu("Infórmate", icon=icon("info-sign", lib = "glyphicon"),
                      tabPanel("Noticias",
                               h3("Noticias")
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
                       ),
           navbarMenu("Información de País", icon=icon("info-sign", lib = "glyphicon"),
                    tabPanel("Proyecciones de población INE", icon=icon("user", lib = "glyphicon"),
                             source("ui/ui_poblacion.R", local = TRUE)$value
                            
                    )
                    
           )
                      
           

    ),
HTML("</header>")
  ),
column(10, offset = 1, style = "background-color:#001345; text-color:white;",HTML("<br />"), "Ministerio de Finanzas Públicas - Copyright 2018", HTML("<br />"),HTML("&nbsp;"))

) ))
#source("ui/ui_ejes.R")