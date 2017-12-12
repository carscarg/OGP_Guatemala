#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

lista <- read.csv("test.csv")
names(lista)[1]<-"depto"

a <- unique(lista$depto)






# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput("departamento", "Departamento", choices = a),
         uiOutput("combo2")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      print(input$departamento)
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
   
   output$combo2 <-renderUI({
     contenidos<-as.character(lista[lista$depto==input$departamento,][,2])
     selectInput("municipio","Municipio",choices=contenidos)
     
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

