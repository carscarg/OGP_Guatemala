# Shankey Diagram

library(networkD3)
library(tidyverse)

datos_origen <- read.csv("datos/datos_prueba_shanky.csv")
datos_origen <- group_by(datos_origen, Grupo.Gasto,Fuente.Financiamiento) %>%
  summarise(monto = sum(Recomendado.2018, na.rm=TRUE)) %>%
  ungroup() %>%
  filter(monto > 0) %>% 
  as.data.frame()

nodes <- data.frame(name = c(levels(datos_origen$Grupo.Gasto),levels(datos_origen$Fuente.Financiamiento))) %>%
  mutate_all(as.character) %>%
  as.data.frame()

levels(datos_origen$Grupo.Gasto) <- c(0:(length(levels(datos_origen$Grupo.Gasto))-1))
levels(datos_origen$Fuente.Financiamiento) <- c(length(levels(datos_origen$Grupo.Gasto)):(length(levels(datos_origen$Fuente.Financiamiento))+length(levels(datos$Grupo.Gasto))))

datos <- select(datos_origen, source = Fuente.Financiamiento, target = Grupo.Gasto, value = monto) %>%
  mutate_all(as.character) %>%
  mutate_all(as.numeric) %>%
  as.data.frame()

sankeyNetwork(Links = datos, Nodes = nodes, Source = "source",
              Target = "target", Value = "value", NodeID = "name",
              units = "", fontSize = 12, nodeWidth = 30)


# # Load energy projection data
URL <- paste0(
  "https://cdn.rawgit.com/christophergandrud/networkD3/",
  "master/JSONdata/energy.json")
Energy <- jsonlite::fromJSON(URL)
# Plot
sankeyNetwork(Links = Energy$links, Nodes = Energy$nodes, Source = "source",
              Target = "target", Value = "value", NodeID = "name",
              units = "TWh", fontSize = 12, nodeWidth = 30)

