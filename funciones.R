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
    mutate(NEWCOL=NA)
  
  return(datos)
  
}
