### Server General

shinyServer(function(input, output, session) {
  
  source("server/server_Presupuesto.R", local=TRUE)$value
  source("server/server_Presupuesto_Dashboard.R", local=TRUE)$value
  
  output$imginicio <- renderSlickR({
    slickR(
      obj = c("www/educacion.jpg","www/infraestructura.jpg","www/salud.jpg","www/seguridad.jpg"),
      slideId = c('ex2'),
      slickOpts = list(
        initialSlide = 0,
        slidesToShow = 1,
        slidesToScroll = 1,
        focusOnSelect = T,
        autoplay = T,
        autoplaySpeed = 800,
        dots = T
      ),
      height = 100,width='100%'
    )
    
  })
  
  # Crear y descargar PDF
  observeEvent(input$generarPDF,{
    
    #shinyjs::show(id="loadingPDF")
    do.call(generarReportePDF, args = list(nivel = input$nivel))
    #shinyjs::hide(id="loadingPDF")
    #toggleModal(session, "modalPDF", "close")  
  })
  
  
})