# Shankey Diagram

library(networkD3)
library(tidyverse)

datos_origen <- read.csv("datos/datos_prueba_shanky.csv")
datos_origen <- group_by(datos_origen, Grupo.Gasto,Fuente.Financiamiento) %>%
  summarise(monto = sum(Recomendado.2018, na.rm=TRUE)) %>%
  ungroup() %>%
  filter(monto > 0) %>% 
  as.data.frame()

filtered_nodes <- c(unique(as.character(datos_origen$Grupo.Gasto)),unique(as.character(datos_origen$Fuente.Financiamiento)))

nodes <- data.frame(name = c(levels(datos_origen$Grupo.Gasto),levels(datos_origen$Fuente.Financiamiento))) %>%
  mutate_all(as.character) %>%
  filter(name %in% filtered_nodes) %>%
  as.data.frame()

datos_origen <- mutate_if(datos_origen, is.factor,as.character) %>%
  as.data.frame()

datos_origen$Grupo.Gasto <- as.factor(datos_origen$Grupo.Gasto)
levels(datos_origen$Grupo.Gasto) <- c(0:(length(levels(datos_origen$Grupo.Gasto))-1))
datos_origen$Fuente.Financiamiento <- as.factor(as.character(datos_origen$Fuente.Financiamiento))
levels(datos_origen$Fuente.Financiamiento) <- c(length(levels(datos_origen$Grupo.Gasto)):(length(levels(datos_origen$Fuente.Financiamiento))+length(levels(datos_origen$Grupo.Gasto))))

datos <- select(datos_origen, source = Fuente.Financiamiento, target = Grupo.Gasto, value = monto) %>%
  mutate_all(as.character) %>%
  mutate_all(as.numeric) %>%
  as.data.frame()

sankeyNetwork(Links = datos, Nodes = nodes, Source = "source",
              Target = "target", Value = "value", NodeID = "name",
              units = "", fontSize = 12, nodeWidth = 30)

# 
# # # Load energy projection data
# URL <- paste0(
#   "https://cdn.rawgit.com/christophergandrud/networkD3/",
#   "master/JSONdata/energy.json")
# Energy <- jsonlite::fromJSON(URL)
# # Plot
# sankeyNetwork(Links = Energy$links, Nodes = Energy$nodes, Source = "source",
#               Target = "target", Value = "value", NodeID = "name",
#               units = "TWh", fontSize = 12, nodeWidth = 30)

