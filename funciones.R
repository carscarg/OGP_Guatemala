# Declaracion de funciones -----------

prepararInput_d3Tree <- function(datos){
  
  # Reemplazo caracteres que suelen dar problemas en nombres de columnas"
  names(datos) <- gsub(".","_",names(datos),fixed = TRUE)
  names(datos) <- gsub("Í","I",names(datos),fixed = TRUE)
  names(datos) <- gsub("É","E",names(datos),fixed = TRUE)
  names(datos) <- gsub("Ó","O",names(datos),fixed = TRUE)
  names(datos) <- gsub("Á","A",names(datos),fixed = TRUE)
  names(datos) <- gsub("-","_",names(datos),fixed = TRUE)
  names(datos) <- gsub(" ","_",names(datos),fixed = TRUE)
  
  datos <- group_by(datos, Entidad, Programa, Unidad_Ejecutora) %>%
    summarise(monto = sum(Recomendado_2018, na.rm = TRUE)) %>%
    distinct(.keep_all=TRUE) %>%
    as.data.frame()
  
  datos <- mutate_all(datos, as.character) %>%
    mutate_all(function(x) ifelse(nchar(x)==0,"_",x)) %>% # there are empty categories that will crash d3Tree
    mutate_if(is.character, as.factor) %>%
    mutate(monto = as.numeric(monto)) %>%
    mutate(NEWCOL=NA)
  
  return(datos)
  
}

prepararInput_Sankey <- function(datos){
  
  datos_origen <- group_by(datos, Grupo.Gasto,Fuente.Financiamiento) %>%
    dplyr::summarise(monto = sum(Recomendado.2018, na.rm=TRUE)) %>%
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
  
  datos <- list(datos = datos,nodes = nodes)
  
  return(datos)
  
}

prepararInput_Treemap <- function(datos){
  
  datos_treemap <- dplyr::group_by(datos, Grupo.Gasto, Fuente.Financiamiento) %>%
    dplyr::summarise(Monto = sum(Recomendado.2018, na.rm=TRUE)) %>%
    ungroup() %>%
    filter(Monto > 0) %>% 
    as.data.frame()
  
  datos_treemap <- mutate_if(datos_treemap, is.factor,as.character) %>%
    arrange(desc(Monto)) %>%
    as.data.frame()
  
  return(datos_treemap)
}

