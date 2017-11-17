## CARGA LIBRERIAS, INICIALIZA VARIABLES, CARGA DATOS, FUNCIONES, ETC.

# Cargo librerias --------------------------------
library(markdown)
library(shiny)
library(reshape2)
library(stringr)
library(DT)
library(plyr)
library(dplyr)
#library(tidyverse)
library(d3Tree)
library(slickR)
library(highcharter)
library(treemap)
library(networkD3)
library(knitr)
library(rpivotTable)
library(reshape2)

# fuerzo summarise de dplyr
summarise <- dplyr::summarise

# Declaro funciones ------------------------------
source("funciones.R", local = TRUE)

# Carga y preparado de datos ----------------------------

# Todos los datos
tabla_cruda <- readRDS("datos/formulacion2018.rds")
formulacion2018 <- prepararInput_d3Tree(tabla_cruda)

# Subconjunto para probar visualizaciones
datos_prueba <- read.csv("datos/datos_prueba_shanky.csv")
datos_sankey <- prepararInput_Sankey(datos_prueba)
datos_treemap <- prepararInput_Treemap(datos_prueba)

# listas de elementos para selectores
lista_niveles <- names(select_if(datos_prueba, is.factor))


# agrupa la tabla cruda en algunas variables principales, para uso en pivot
df <- group_by(tabla_cruda,Entidad,Programa,Unidad.Ejecutora,Grupo.Gasto,Tipo.de.Gasto,Fuente.Financiamiento) %>% 
  dplyr::summarise(monto = sum(Recomendado.2018, na.rm=TRUE))



