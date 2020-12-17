#' Title
#'
#' @param path 
#'
#' @return
#' 
#' @import XML
#' @import logging
#'
#' @examples
leerConfig <- function(path){
  
  library(XML)
  
  
  configPath <- paste0(path, "config/config.xml")
  
  
  tryCatch(expr = {
    
    #Leer el xml y convertirlo a lista
    config <- XML::xmlToList(xmlParse(configPath))
    
    
  }, error = function(e){
    
    logerror("Config no encontrado en su ruta. Verifica que se llame config.xml",
             logger = 'log')
    stop()
  })
  
  loginfo("Config leido.", logger = 'log')
  
  validateConfigNodes(config)
  
  config$columnas$predictorasNumericas <- trimws(strsplit(config$columnas$predictorasNumericas, ",")[[1]])
  
  separadoresAceptados <- config$datos$sep %in% c(",", ";")
  
  if(!separadoresAceptados){
    
    logerror("Sep solo puede valer ',' o ';' ", logger = 'log')
    stop()
    
  }
  
  return(config)
  
} 

#' @title validateConfigNodes
#'
#' @param config 
#'
#' @import logging
#' 
validateConfigNodes <- function(config){
  
  nodoPrincipal <- identical(names(config), c("datos", "output", "testRate"))
  nodoInput <- identical(names(config$datos), c("train", "target", "sep"))
  nodoColumnas <- identical(names(config$columnas), c("ID", "predictorasNumericas",
                                                      "target"))
  nodoFilas <- identical(names(config$filas), c("paises"))
  
  
  nodos <- c("nodoPrincipal" = nodoPrincipal, "nodoInput" = nodoInput, 
             "nodoColumnas" = nodoColumnas)
  
  check <- all(nodos)
  
  if(!check){
    
    nodosMalos <- names(nodos)[!nodos]
    
    logerror(paste0("Los nodos: ", paste(nodosMalos, collapse = ", "),
                    " estan mal estructurados!"), logger = 'log')
    stop()
    
  }
  
}

