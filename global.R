## CARGA LIBRERIAS, INICIALIZA VARIABLES, CARGA DATOS, FUNCIONES, ETC.

# Cargo librerias --------------------------------
#library(markdown)
library(reshape2)
library(shiny)
library(stringr)
library(DT)
#library(plyr)
library(dplyr)
library(tidyverse)
library(d3Tree)
library(slickR)
library(highcharter)
library(treemap)
library(networkD3)
library(knitr)
library(rpivotTable)
library(data.table)
library(leaflet)
library(rgdal)
library(shinythemes)
library (ggplot2)
library(tidyr)
library(ggthemes)
library (openxlsx)
library(googleVis)

options(scipen = 999)
theme_set(theme_classic())
#options(encoding = 'UTF-8')


# fuerzo summarise de dplyr
summarise <- dplyr::summarise
#setCPLConfigOption("SHAPE_ENCODING", "")
guate <- readOGR("shapes/gt_INE.shp")
guate$Municipio <- iconv(guate$Municipio, "UTF-8", "UTF-8")

# Declaro funciones ------------------------------
source("funciones.R", local = TRUE)

# Carga y preparado de datos ----------------------------

# Todos los datos
tabla_cruda <- readRDS("datos/formulacion2018.rds")
formulacion2018 <- prepararInput_d3Tree(tabla_cruda) %>% 
  mutate_if(is.factor, as.character) %>%
  as.data.frame()

# Subconjunto para probar visualizaciones
datos_dashboard <- read.csv("datos/datos_prueba_shanky.csv")
datos_sankey <- prepararInput_Sankey(datos_dashboard)
datos_treemap <- prepararInput_Treemap(datos_dashboard)

# listas de elementos para selectores
lista_niveles <- names(select_if(datos_dashboard, is.factor))

# agrupa la tabla cruda en algunas variables principales, para uso en pivot
df <- group_by(tabla_cruda,Entidad,Programa,Unidad.Ejecutora,Grupo.Gasto,Tipo.de.Gasto,Fuente.Financiamiento) %>% 
  dplyr::summarise(monto = sum(Recomendado.2018, na.rm=TRUE))


# Cargando el archivo

INEpob <- readRDS("datos/poblacion.rds")

print(head(INEpob))

anios <- sort(unique(INEpob$anio))

Guatemala <- readRDS("datos/guatemala.rds")
# Guatemala <- read.csv("datos/guatemala.csv")
# Guatemala <- enc2native(Guatemala)

depto <- sort(unique(Guatemala$departamento))
