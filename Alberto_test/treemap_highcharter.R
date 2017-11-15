library("treemap")
library("viridis")
library(highcharter)

# Declaro funciones
source("funciones.R", local = TRUE)

# Carga y preparado de datos
formulacion2018 <- readRDS("datos/formulacion2018.rds")
formulacion2018 <- prepararInput_d3Tree(formulacion2018) %>%
  mutate(monto = as.numeric(as.character(monto))) %>%
  select(-NEWCOL) %>%
  filter(grepl("FINANZAS|DEFENSA",Entidad)) %>%
  #select(-NEWCOL,-Unidad_Ejecutora) %>%
  group_by(Entidad,Programa,Unidad_Ejecutora) %>%
  #group_by(Entidad,Programa) %>%
  summarize(monto = sum(monto,na.rm=TRUE)) %>%
  mutate_if(is.factor, as.character)

#formulacion2018 <- head(formulacion2018,100)

tm <- treemap(formulacion2018, index = c("Entidad","Programa","Unidad_Ejecutora"),
#tm <- treemap(formulacion2018, index = c("Entidad", "Programa"),              
              vSize = "monto", vColor = "Entidad",
              type = "index", palette = rev(viridis(6)),
              draw = TRUE)

highchart() %>% 
  hc_add_series_treemap(tm, allowDrillToNode = TRUE,
                        layoutAlgorithm = "squarified",
                        name = "Presupuestos") %>% 
  hc_title(text = "Presupuestos") %>% 
  hc_tooltip(pointFormat = "<b>{point.name}</b>:<br>
             Programa: {point.:,.0f}<br>
             Monto: {point.value:,.0f}")

############# Nueva function hctreemap2
#devtools::install_github("jbkunst/highcharter")
#source("https://install-github.me/jbkunst/highcharter")

