library(reshape2)
library(shiny)
library(stringr)
library(DT)
library(plyr)
library(dplyr)
library(d3Tree)

#m=Titanic%>%data.frame%>%mutate(NEWCOL=NA)%>%distinct
#setwd("C:/Users/wb493327/R_Projects/OGP_Guatemala/Alberto_test")
m <- readRDS("/Users/asanchez3/Desktop/Work/OGP_Guatemala/datos/formulacion2018.rds")
# names(m) <- gsub(".","_",names(m),fixed = TRUE)
# names(m) <- gsub("Í","I",names(m),fixed = TRUE)
# names(m) <- gsub("É","E",names(m),fixed = TRUE)
# names(m) <- gsub("Ó","O",names(m),fixed = TRUE)
# names(m) <- gsub("Á","A",names(m),fixed = TRUE)
# names(m) <- gsub("-","_",names(m),fixed = TRUE)
# names(m) <- gsub(" ","_",names(m),fixed = TRUE)

#write.csv(m,"C:/Users/wb493327/Desktop/OGP_Guatemala_test.csv", row.names = FALSE)

m <- group_by(m, Entidad, Programa, Unidad.Ejecutora) %>%
  dplyr::summarise(monto = sum(Recomendado.2018, na.rm = TRUE)) %>%
  distinct(.keep_all=TRUE) %>%
  as.data.frame()
#m <- head(m,65)
m <- #mutate_all(m, function(x) gsub(" |Í|É|Ó|Á|-","_",x)) %>%
  mutate_all(m, as.character) %>%
  #mutate_all(function(x) ifelse(nchar(x)==0,"_",x)) %>% # there are empty categories that will crash d3Tree
  #mutate(monto = round(as.numeric(monto)/10000)) %>%
  mutate_if(is.character, as.factor) %>%
  mutate(NEWCOL=NA)

