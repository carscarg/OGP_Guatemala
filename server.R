### Server General

shinyServer(function(input, output, session) {
  
  source("server/server_Presupuesto.R", local=TRUE)$value
  
  output$Noticias <- renderPlot({
    
    plot(mtcars$mpg,mtcars$cyl)
    
  })
  
})