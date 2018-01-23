 
output$combo2 <- renderUI({
  contenidos<-sort(as.character(Guatemala[Guatemala$departamento==input$departamento,][,1]))
  contenidos<-c(contenidos,"Todos")
  selectInput("municipio","Municipio",choices=contenidos)
})



  
  
  
tabla <- reactive({ 
  # se filtra el Departamento, el Municipio y el Año
  a <- input$departamento
  b <- input$municipio
  c <- input$anio
  # Se estructura la tabla según las variables geográfico, nombre del depto/municipio y año
  if(b == "Todos"){
    tabla <- filter(INEpob, departamento == a & anio == c)
  } else {
    tabla <- filter(INEpob, departamento == a & municipio == b & anio == c)
  }
  
  
  tabla$intervalo <- cut(tabla$edad, 
                         breaks = c(-Inf, 5, 10, 15, 20, 25,30,35,40,45,50,55,60,65, Inf), 
                         labels = c("0-4", "5-9", "10-14", "15-19", "20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59","60-64","65+" ), 
                         right = FALSE)
  
  
  # Se agregan intervalos que servirán para la creación del gráfico
  
  
  
  # Tabla final totalizada por edad ,  genero y el total de población solicitada
  
  tablafinal <- group_by((spread(tabla,sexo,poblacion)),intervalo)  %>% dplyr::summarise(M=sum(Masculino), F= sum(Femenino))
  
  
})
  

output$descargar <- downloadHandler(
  filename = "poblacion.csv",
  content = function(file) {
    write.csv(tabla(), file, row.names = FALSE)
  }
)

  
  output$poblacion_tabla <- renderDataTable({
 
    datatable(tabla(), extensions="Scroller", style="bootstrap", class="compact", width="100%",
              options=list(dom="ft",deferRender=TRUE, scroller=FALSE, pageLength = 25)) %>%
     
      formatStyle(c(0), target='row', fontSize = '80%')
    
  })
 

  output$poblacion <- renderHighchart ({ 
    
    
    # Proceso para la tabla por edad y genero por porcentajes
    
    tabla2 <- tabla()
    tabla2$Masculino <- 100*(tabla2$M/(sum(tabla2$M)+sum(tabla2$F))) 
    tabla2$Femenino <- 100*(tabla2$F/(sum(tabla2$M)+sum(tabla2$F)))
    
    # Tabla final 2 totalizada por edad y genero en porcentaje de la población solicitada
    
    tablafinal2 <- select(tabla2, c(intervalo,Masculino,Femenino))
    
    # Se agregan intervalos que servirán para la creación de la gráfica por pocentaje
    
    tabla2_Porcentaje <- gather(tablafinal2, sexo, porcentaje, -intervalo)
    
    # Grafico 1 ( Total de población)
    
    w <- max(tabla()$M)+max(tabla()$F)
    factor <- 10000
    t <- (w/factor)
    if (t < 1){
      t <- w/1000
      factor <- 1000
    }
    
    if (round(t)==0){
      t <- 1
    }
    q <- t*1.2
    z <- round(q)*factor
    y <- (round(z/factor)/8)*factor
    brks2 <- seq(-z, z, y)
    lbls2 = paste0(as.character(c(seq(z, 0, -y), seq(y, z, y))), "")
    
    
    highchart () %>%
      # Se agregan las dos series de datos a graficar y se define el tipo de gr?fico
      
      hc_add_series(data = -round(tabla()$M), name = "Masculino",  type = "bar",
                    color = "#8bbc21", showInLegend = TRUE, stacking = "normal")%>%
      hc_add_series(data = round(tabla()$F), name = "Femenino",  type = "bar",
                    color = "#77a1e5", showInLegend = TRUE, stacking="normal")%>%
      
      # Se agrega t?tulo de eje Y
      
      hc_yAxis(title = list(text = "Población")) %>%
      
      # Se definen valores para eje X
      
      hc_xAxis(categories = tabla()$intervalo, opposite = TRUE, reversed = FALSE)%>%
      
      # Se configura la herramienta de cuadro de informaci?n
      
      hc_tooltip(valueDecimals = 0, headerFormat = "",
                 pointFormat = "{point.category} Años <br> Población:<b>{point.y}") %>%
      
      # Se agregan cr?ditos
      
      hc_credits(enabled = TRUE,
                 text = "Fuente: Instituto Nacional de Estadística",
                 style = list(fontSize = "10px"))%>%
      
      # Se agrega el t?tulo del gr?fico
      
      hc_title(text = "Proyección de población",
               style = list(fontWeight = "bold")) 
    
  })
  
  # # Grafico 2( Porcentaje )
  # 
  # brks2 <- seq(-14, 14, 2)
  # lbls2 = paste0(as.character(c(seq(14, 0, -2), seq(2, 14, 2))), "%")
  # 
  # output$porcentaje <- renderPlot ({ 
  # ggplot(data = tabla2_Porcentaje, 
  #        mapping = aes(x = intervalo, fill = sexo, 
  #                      y = ifelse(test = sexo == "Masculino", yes = -porcentaje, no = porcentaje ))) +
  #   geom_bar(stat = "identity",  width = .6) + labs(title="Proyección de Población en Porcentaje", subtitle = paste(b,a,c, sep = "-"))+
  #   scale_y_continuous(breaks = brks2, labels = lbls2) +
  #   labs(y = "Porcentaje") + labs(x ="Años")+
  #   coord_flip()+   
  #   theme(plot.title = element_text(hjust = .5), plot.subtitle =element_text(hjust = .5 ), 
  #         axis.ticks = element_blank()) +   
  #   scale_fill_brewer(palette = "Dark2") 
  # 
  # })
  
  
  
  
  
  
  
  
  

