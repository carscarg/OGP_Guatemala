### UI General
tagList(
#shinythemes::themeSelector(), # Para ver tipos de CSS on the fly

  fluidPage(
    fluidRow(
      column(12, style = "background-color:#00698A; text-color:white; height:15px;"),
      column(1, ''),
      column(3, tags$img(src = "logominfin_ajustado.png")),
      column(6, offset = 2, tags$img(src = "header.png" )),
      column(12, style = "background-color:#00698A; text-color:white; height:15px;"),
      column(10, offset = 1 , 
  
HTML("<link rel='stylesheet' href='css/style.css' media='screen'>"),
HTML("<title>Observatorio del Gasto Público</title>"),
HTML(" <meta charset='UTF-8'>"),
tags$style(type="text/css", ".navbar, .navbar-static-top, navbar-default {height: 60px;} ."),
tags$style(type="text/css", "poblacion {height: 50%; width: 50%;} ."),

#HTML("<header id='header' class='container clearfix'>"),

tags$style(type="text/css", "body {width: 100%; padding-top: 5px;}"),

navbarPage(theme = shinytheme("spacelab"),"", position = "static-top",
           navbarMenu("Inicio", icon=icon("home", lib = "glyphicon"),

                  tabPanel("Inicio",
                           
                          #leafletOutput("map", width = "100%", height = 600),
                           fluidRow(
                           #column(12,style = "background-color:#00698A; text-color:white; height:15px;"),  
                             
                           column(7,
                           HTML("<center>"),slickROutput("imginicio", width = "940px", height = "380px"),HTML("</center>"),
                           br()),
                           column(3, offset = 2, 
                                  includeHTML("html/scroll.html")
                                  ),
                           column(10, offset = 1,
                           includeHTML("html/slider.html")
                          ## shiny::includeMarkdown("rmd/test.Rmd")
                           ))

                    ),
                  tabPanel("¿Qué es el OGP?",
                           h3("¿Qué es el OGP?"),
                           tags$iframe(style="height:1000px; width:100%; scrolling=yes", 
                                       src="http://observatorio.minfin.gob.gt/document/queeselogp.pdf")
                           
                           
                  ),
                  tabPanel("Marco Jurídico",
                           h3("Marco Jurídico"),
                           tags$iframe(style="height:1000px; width:100%; scrolling=yes", 
                                       src="http://observatorio.minfin.gob.gt/document/marcolegal.pdf")
                           
                  ),
                  tabPanel("¿Cómo funciona?",
                           h3("¿Cómo funciona?"),
                           tags$iframe(style="height:1000px; width:100%; scrolling=yes", 
                                       src="http://observatorio.minfin.gob.gt/document/comofunciona.pdf")
                           
                  )),
           navbarMenu("Ejes", 
                    tabPanel("Salud", icon=icon("heart", lib = "glyphicon"),
                             source("ui/ui_ejes/ui_salud.R", local = TRUE)$value
                    ),
                    tabPanel("Educación", icon=icon("education", lib = "glyphicon"),
                             source("ui/ui_ejes/ui_educacion.R", local = TRUE)$value
                    ),
                    tabPanel("Seguridad", icon=icon("user", lib = "glyphicon"),
                             source("ui/ui_ejes/ui_seguridad.R", local = TRUE)$value
                    ),
                    tabPanel("Infraestructura", icon=icon("road", lib = "glyphicon"),
                             source("ui/ui_ejes/ui_infraestructura.R", local = TRUE)$value
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
column(12, style = "background-color:#00698A; text-color:white;",HTML("<br />"), "Ministerio de Finanzas Públicas - Copyright 2018", HTML("<br />"),HTML("&nbsp;"))

) ))
#source("ui/ui_ejes.R")