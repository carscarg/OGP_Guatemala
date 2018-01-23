cobpreprim <-read.xlsx("datos/preprimaria.xlsx", sheet = 8)

# Se filtra por Departamento/Todos y Sexo/Ambos
a <- "San Marcos"
b <- "Ambos"

if (a == "Todos" & b == "Ambos"){
  tabla <- cobpreprim
}else if (a != "Todos" & b =="Ambos"){
  tabla <- filter(cobpreprim, Departamento == a)
}else if (a == "Todos" & b !="Ambos"){
  tabla <- filter(cobpreprim, sexo == b )
} else if (a != "Todos" & b != "Ambos"){
  tabla <- filter(cobpreprim, Departamento == a & sexo == b)
}
# Se agrupa la tabla por año, Inscritos y Población

tabla_preprim <- data.frame(group_by(tabla, anio) %>% summarize( Inscritos=sum(Inscritos), poblacion=sum(poblacion)))


# Gráfico preprimaria 


output$texto <- renderText({
  print(str(tabla))
})

output$coberturapreprimaria <- renderGvis({ 
                gvisLineChart(tabla_preprim, "anio", c("Inscritos","poblacion"),
                       options=list(title = "Alumnos de pre primaria Inscritos vs Proyección de población", legend = "bottom", pointSize = 10,
                                    series="[{targetAxisIndex: 0},
                                    {targetAxisIndex:1}]",
                                    vAxes="[{title:'Inscritos'}, {title:'Población'}]",
                                    width= "100%", height = 400
                       ), chartid = "twoaxeslinechart"
)
})



cobprim <-read.xlsx("datos/primaria.xlsx", sheet = 9)

a <- "San Marcos"
b <- "Ambos"

if (a == "Todos" & b == "Ambos"){
  tabla <- cobprim
}else if (a != "Todos" & b =="Ambos"){
  tabla <- filter(cobprim, Departamento == a)
}else if (a == "Todos" & b !="Ambos"){
  tabla <- filter(cobprim, Sexo == b )
} else if (a != "Todos" & b != "Ambos"){
  tabla <- filter(cobprim, Departamento == a & Sexo == b)
  
}
tabla_cobprim <- group_by(tabla, anio) %>% summarize( Inscritos=sum(Inscritos), poblacion=sum(poblacion))

output$coberturaprimaria <- renderGvis ({
  
  gvisLineChart(tabla_cobprim, "anio", c("Inscritos","poblacion"),
                       options=list(title = "Alumnos de primaria Inscritos vs Proyección de población", legend = "bottom", pointSize = 10,
                                    series="[{targetAxisIndex: 0},
                         {targetAxisIndex:1}]",
                                    vAxes="[{title:'Inscritos'}, {title:'Población'}]",
                                    width = "100%", height = 400
                       ))
})



# se filtra por Año

a <- "2016"

# Ordenamiento para la tabla final

tabla_preprimpor <- filter(cobpreprim, anio == a)
tabla_preprimpor$Porcentaje <- round((tabla_preprimpor$Inscritos/tabla_preprimpor$poblacion),2)
tablafinal <- dcast(tabla_preprimpor, Departamento~sexo, fun.aggregate = sum, value.var = "Porcentaje")
tablafinal_preprimpor <- arrange(tablafinal,desc(M),F)

# Gráfico
output$preprimpor <- renderGvis ({
 gvisBarChart(tablafinal_preprimpor, "Departamento", c("M","F"),
                    options=list(title="Cobertura de pre-primaria en porcentaje  por sexo y Departamento",
                                 titleTextStyle="{color:'purple',
                                 fontName:'Courier',
                                 fontSize:16}",
                                 series="[{targetAxisIndex: 0},
                                 {targetAxisIndex:1}]",
                                 vAxes="[{title:'Departamento'}, {title:'F'}]",
                                 hAxes="[{title:'Porcentaje', format: '##%'}]",
                                 width = "100%", height = 800
                    ), chartid = "cobpreprim")
})


a <- "2016"

# Ordenamiento para la tabla final

tablaprimpor <- filter(cobprim, anio == a)
tablaprimpor$Porcentaje <- round((tablaprimpor$Inscritos/tablaprimpor$poblacion),2)
tablafinal <- dcast(tablaprimpor, Departamento~Sexo, fun.aggregate = sum, value.var = "Porcentaje")
tablafinalprimpor <- arrange(tablafinal,desc(M),F)

# Gráfico

output$primpor <- renderGvis({ gvisBarChart(tablafinalprimpor, "Departamento", c("M","F"),
                    options=list(title="Cobertura de primaria en porcentaje  por sexo y Departamento",
                                 titleTextStyle="{color:'purple',
                         fontName:'Courier',
                         fontSize:16}",
                                 series="[{targetAxisIndex: 0},
                         {targetAxisIndex:1}]",
                                 vAxes="[{title:'Departamento'}, {title:'F'}]",
                                 hAxes="[{title:'Porcentaje', format: '##%'}]",
                                 width = "100%", height = 800
                    ), chartid = "cobprim")

})


presup <- read.xlsx("datos/preprimaria.xlsx", sheet = 5, startRow = 5)

# se filtra por Departamento/Todos



a <- "Todos"


if (a == "Todos" ){
  tabla <- cobpreprim
  tabla2 <- presup
}else {if (a != "Todos")
  tabla <- filter(cobpreprim, Departamento == a)
tabla2 <- filter(presup, Depto == a)
}

transpresu <- gather(tabla2, anio, Devengado,-Depto)
transpresu$anio <- as.numeric(transpresu$anio)
tabla <- group_by(tabla, anio) %>% summarize( Inscritos=sum(Inscritos), poblacion=sum(poblacion))
tablaunif <-left_join(tabla, transpresu) %>% select(-Depto)
tablaunif$Cobertura = round((tabla$Inscritos/tabla$poblacion),2)

# Gráfico presupuesto alumnos

output$presupprepri <- renderGvis({
  gvisComboChart(tablaunif, xvar="anio", yvar=c("Cobertura", "Devengado"),
                 options=list(title="Cobertura de pre-primaria en porcentaje vs Devengado anual",
                              titleTextStyle="{color:'purple',
                              fontName:'Courier',
                              fontSize:16}",
                              legend = "bottom",
                              curveType="function", 
                              pointSize=9,
                              seriesType="bars",
                              series="[{type:'line', 
                              targetAxisIndex:0,
                              color:'black'}, 
                              {type:'bars', 
                              targetAxisIndex:1,
                              color:'blue'}]",
                              vAxes="[{title:'Cobertura',
                             format:'##%',
                             titleTextStyle: {color: 'black'},
                             textStyle:{color: 'black'},
                             textPosition: 'out'}, 
                             {title:'Devengado',
                             format:'Q#,###',
                             titleTextStyle: {color: 'grey'},
                             textStyle:{color: 'grey'},
                             textPosition: 'out',
                             minValue:0}]",
                              hAxes="[{title:'Año',
                             textPosition: 'out'}]",
                              width="100%", height=500
                 ), 
                 chartid="Combochart"
  )
})

presupprim <- read.xlsx("datos/primaria.xlsx", sheet = 4, startRow = 7, rows = c(7:29))

a <- "San Marcos"



tabla <- cobprim
tabla2 <- presupprim

transpresu <- gather(tabla2, anio, Devengado,-Depto)
transpresu$anio <- as.numeric(transpresu$anio)
tabla <- group_by(tabla, anio) %>% summarize( Inscritos=sum(Inscritos), poblacion=sum(poblacion))
transpresu <- group_by(transpresu,anio) %>% summarize(Devengado=sum(Devengado))
tablaunif <-left_join(tabla, transpresu)
tablaunif$Cobertura = round((tabla$Inscritos/tabla$poblacion),2)

output$presupprim <- renderGvis({
  gvisComboChart(tablaunif, xvar="anio", yvar=c("Cobertura", "Devengado"),
                 options=list(title="Cobertura de primaria en porcentaje vs Gasto Anual en primaria",
                              titleTextStyle="{color:'purple',
                              fontName:'Courier',
                              fontSize:16}",
                              legend = "bottom",
                              curveType="function", 
                              pointSize=9,
                              seriesType="bars",
                              series="[{type:'line', 
                              targetAxisIndex:0,
                              color:'black'}, 
                              {type:'bars', 
                              targetAxisIndex:1,
                              color:'blue'}]",
                              vAxes="[{title:'Cobertura',
                              format:'##%',
                              titleTextStyle: {color: 'black'},
                              textStyle:{color: 'black'},
                              textPosition: 'out'}, 
                              {title:'Devengado',
                              format:'Q#,###',
                              titleTextStyle: {color: 'grey'},
                              textStyle:{color: 'grey'},
                              textPosition: 'out',
                              minValue:0}]",
                              hAxes="[{title:'Año',
                              textPosition: 'out'}]",
                              width="100%", height=500
                 ), 
                 chartid="CobprimvsDev"
  )

})



MetaEdu1 <- read.xlsx("datos/gastodeptos.xlsx", sheet = 5, startRow = 3, rows = c(3:163), cols = c(3:7))
MetaEdu1 <- subset(MetaEdu1, Departamento != "MULTIREGIONAL" & anio != "2010" & anio !="2011")
names(MetaEdu1) <- c("Departamento","Anio","Gasto.Publico.en.Educacion","Gasto.Publico.en.Educacion.Primaria","Grupo.0.primaria")

a <- "San Marcos"

if (a == "Todos"){ 
  tablo <- MetaEdu1
  tablo <- group_by(tablo,Anio)%>% summarize(Gasto.Publico.en.Educacion.Primaria=sum(Gasto.Publico.en.Educacion.Primaria), Grupo.0.primaria=sum(Grupo.0.primaria)) 
  tablo$porcentaje <- round(100*(tablo$Grupo.0.primaria/tablo$Gasto.Publico.en.Educacion.Primaria),2)
  tablo$Departamento <- "Todos"
  tablafinal <- data.frame(tablo[,1:4])
  
}else {
  tablo <- filter(MetaEdu1, Departamento == a)
  tablo$porcentaje <- round(100*(tablo$Grupo.0.primaria/tablo$Gasto.Publico.en.Educacion.Primaria),2)
  tablafinal2 <- data.frame(tablo[,2:6])
}

#Gráfico



output$educaciongraph <- renderGvis({ 
  gvisBubbleChart(tablo, idvar="Departamento", 
                  xvar="Gasto.Publico.en.Educacion.Primaria", yvar="Grupo.0.primaria",
                  colorvar="Anio", sizevar="porcentaje", 
                  options=list(title = "Gasto docente sobre gasto total de primaria, por departamento",
                               titleTextStyle="{color:'gray',fontName:'Courier', fontSize:18}",
                               vAxis = "{title:'Gasto docente en primaria'}", 
                               hAxis="{title: 'Gasto total de primaria'},{minValue:75, maxValue:125}", 
                               bubble="{textStyle:{color: 'none'}}",
                               width = "100%", height = 600), 
                  chartid = "BurbujaGtoEdua")
})


MetaEdu <- read.xlsx("datos/gastodeptos.xlsx", sheet = 5, startRow = 3, rows = c(3:163), cols = c(3:6))

# Filtrando los datos a utilizar

MetaEdu <- subset(MetaEdu, Departamento != "MULTIREGIONAL" & anio != "2010" & anio !="2011")
names(MetaEdu) <- c("Departamento","Anio","Gasto.Publico.en.Educacion","Gasto.Publico.en.Educacion.Primaria")

a <- "San Marcos"

if (a == "Todos"){
  tabl <- MetaEdu
  tabl <- group_by(tabla,Anio)%>% summarize(Gasto.Publico.en.Educacion=sum(Gasto.Publico.en.Educacion), Gasto.Publico.en.Educacion.Primaria=sum(Gasto.Publico.en.Educacion.Primaria)) 
  tabl$porcentaje <- round(100*(tabl$Gasto.Publico.en.Educacion.Primaria/tabl$Gasto.Publico.en.Educacion),2)
  tabl$Departamento <- "Todos"
  tablafinal <- data.frame(tabl[,1:4])
  
}else {
  tabl <- filter(MetaEdu, Departamento == a)
  tabl$porcentaje <- round(100*(tabl$Gasto.Publico.en.Educacion.Primaria/tabl$Gasto.Publico.en.Educacion),2)
  tablafinal <- data.frame(tabl[,2:5])
}

#Gráfico

output$primvsgral <- renderGvis({ 
  gvisBubbleChart(tabl, idvar="Departamento", 
                  xvar="Gasto.Publico.en.Educacion", yvar="Gasto.Publico.en.Educacion.Primaria",
                  colorvar="Anio", sizevar="porcentaje", 
                  options=list(title = "Gasto en educacion primaria como porcentaje del gasto publico en educacion, por departamento",
                               titleTextStyle="{color:'gray', fontName:'Courier', fontSize:18}",
                               vAxis = "{title:'Gasto publico en educacion primaria'}", 
                               hAxis="{title: 'Gasto publico en educacion'},{minValue:75, maxValue:125}", 
                               bubble="{textStyle:{color: 'none'}}",
                               width = "100%", height = 600), 
                  chartid = "BurbujaGtoEdub")
})





MetaEdub <- read.xlsx("datos/gastodeptos.xlsx", sheet = 3, startRow = 3, rows = c(3:220), cols = c(3:6))

a <- "San Marcos"

if (a == "Todos"){
  tablaa <- MetaEdub
  tablaa <- group_by(tablaa,Anio)%>% summarize(Gasto.Total.de.Gobierno=sum(Gasto.Total.de.Gobierno), Gasto.Publico.en.Educacion=sum(Gasto.Publico.en.Educacion)) 
  tablaa$porcentaje <- round(100*(tablaa$Gasto.Publico.en.Educacion/tablaa$Gasto.Total.de.Gobierno),2)
  tablaa$Departamento <- "Todos"
  tablafinal3 <- data.frame(tablaa[,1:4])
  
}else {
  tablaa <- filter(MetaEdub, Departamento == a)
  tablaa$porcentaje <- round(100*(tablaa$Gasto.Publico.en.Educacion/tablaa$Gasto.Total.de.Gobierno),2)
  tablafinal3 <- data.frame(tablaa[,2:5])
}

output$Bubble <- renderGvis({gvisBubbleChart(tablaa, idvar="Departamento", 
                          xvar="Gasto.Total.de.Gobierno", yvar="Gasto.Publico.en.Educacion",
                          colorvar="Anio", sizevar="porcentaje", 
                          options=list(title = "Gasto publico en educacion como porcentaje del gasto total de gobierno, por departamento",
                                       titleTextStyle="{color:'gray',
                              fontName:'Courier', fontSize:18}",
                                       vAxis = "{title:'Gasto publico en educacion'}", 
                                       hAxis="{title: 'Gasto total de Gobierno'},{minValue:75, maxValue:125}", 
                                       bubble="{textStyle:{color: 'none'}}",
                                       width = "100%", height = 500), 
                          chartid = "BurbujaGtoGob")
})





# Se carga la base de datos

maestros <-read.xlsx("datos/docentes.xlsx", sheet = 2, startRow = 4, cols = c(2,5:9),  rows = c(4:26))
gtototal <- read.xlsx("datos/gastodeptos.xlsx", sheet = 2, startRow = 110, rows = c(110:132), cols = c(2,4:8))

# Se estructura la base de datos

maestros <- gather(maestros, anio, Servicios_docentes, -Departamento)
gtototal <- gather(gtototal, anio, Porcentaje, - Departamento)

# Se estandarizan las variables

maestros$anio <- as.numeric(maestros$anio)
gtototal$anio <- as.numeric(gtototal$anio)
gtototal$Porcentaje <- round((gtototal$Porcentaje),2)

# Se selecciona el Departamento a evaluar

a <- "San Marcos"

# Se filtran las tablas 

tablaaa <- filter(maestros, Departamento == a)
tabla10 <- filter(gtototal, Departamento == a)

# se unifican las tablas

tablafinal99 <-left_join(tablaaa, tabla10) %>% select(-Departamento)

output$docentesvsgtototal <- renderGvis({ gvisLineChart(tablafinal99, "anio", c("Servicios_docentes","Porcentaje"),
                       options=list(title = "Servicios docentes vs Gasto docente sobre gasto total en primaria", legend = "bottom", pointSize = 10,
                                    series="[{targetAxisIndex: 0},
                                    {targetAxisIndex:1}]",
                                    vAxes="[{title:'Servicios docentes'}, {title:'Gasto docente', format: '##%'}]",
                                    hAxes ="[{title:'Años'}]",
                                    width = "100%", height = 500
                       ), 
                       chartid = "SDocvsgtoDocPrim"
)
})



maestrosa <-read.xlsx("datos/docentes.xlsx", sheet = 2, startRow = 4, cols = c(2,5:9),  rows = c(4:26))
presupt <- read.xlsx("datos/primaria.xlsx", sheet = 4, startRow = 7)
maestrosa <- gather(maestrosa, anio, Servicios_docentes, -Departamento)

# se filtra por Departamento

a <- "San Marcos"

# se filtran las bases de datos

tablacc <- filter(maestrosa, Departamento == a)
tabla2cc <- filter(presupt, Depto == a)

# se preparan las tablas

transpresu <- gather(tabla2cc, anio, Devengado,-Depto)
transpresu$anio <- as.numeric(transpresu$anio)
tablacc <- tablacc[,c(2,3)]
tablacc$anio <- as.numeric(tablacc$anio)
tablaunif <-left_join(tablacc, transpresu) %>% select(-Depto)

# Gr?fico

output$combo <- renderGvis({ 
  gvisComboChart(tablaunif, xvar="anio", yvar=c("Servicios_docentes", "Devengado"),
                 options=list(title="Cantidad de maestros de primaria vs Devengado anual",
                              titleTextStyle="{color:'purple',
                              fontName:'Courier',
                              fontSize:16}",
                              legend = "bottom",
                              curveType="function", 
                              pointSize=9,
                              seriesType="bars",
                              series="[{type:'line', 
                              targetAxisIndex:0,
                              color:'black'}, 
                              {type:'bars', 
                              targetAxisIndex:1,
                              color:'blue'}]",
                              vAxes="[{title:'Servicios docentes',
                             format:'#,###',
                             titleTextStyle: {color: 'black'},
                             textStyle:{color: 'black'},
                             textPosition: 'out'}, 
                             {title:'Devengado',
                             format:'Q#,###',
                             titleTextStyle: {color: 'grey'},
                             textStyle:{color: 'grey'},
                             textPosition: 'out',
                             minValue:0}]",
                              hAxes="[{title:'A?o',
                             textPosition: 'out'}]",
                              width="100%", height=500
                 ), 
                 chartid="Combochart"
  )

})

