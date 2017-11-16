# Shankey Diagram

library(networkD3)
library(tidyverse)

datos_origen <- read.csv("datos/datos_prueba_shanky.csv")
datos <- prepararInput_Sankey(datos_origen)

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

