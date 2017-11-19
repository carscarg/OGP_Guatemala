### Server General

shinyServer(function(input, output, session) {
  
  source("server/server_d3Tree.R", local=TRUE)$value
  source("server/server_Presupuesto_Dashboard.R", local=TRUE)$value
  source("server/server_pivot.R", local=TRUE)$value
  
  # Crea objeto carrusel de imagenes para la Home
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
  
})