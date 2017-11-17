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
  # observeEvent(input$generarPDF,{
  #   
  #   #shinyjs::show(id="loadingPDF")
  #   do.call(generarReportePDF, args = list(nivel = input$nivel))
  #   #shinyjs::hide(id="loadingPDF")
  #   #toggleModal(session, "modalPDF", "close")  
  # })
  
  
  output$descargaReporte <- downloadHandler(
    filename = function() {
      paste('my-report', sep = '.', switch(
        input$formato, PDF = 'pdf', HTML = 'html', Word = 'docx'
      ))
    },
    
    content = function(file) {
      src <- normalizePath('www/presupuestos_Dashboard_PDF.Rmd')
      
      # temporarily switch to the temp dir, in case you do not have write
      # permission to the current working directory
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'presupuestos_Dashboard_PDF.Rmd', overwrite = TRUE)
      
      library(rmarkdown)
      out <- render('presupuestos_Dashboard_PDF.Rmd', switch(
        input$formato,
        PDF = pdf_document(), HTML = html_document(), Word = word_document()
      ))
      file.rename(out, file)
    }
  )
  
  
})