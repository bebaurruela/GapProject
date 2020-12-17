

#' Title
#'
#' @param datos 
#' @param config 
#'
#' @return
#' @import logging
#'
#' @examples
preProcesarDatos <- function(datos, config){
  
  columnasUtilizadas <- c(config$columnas$ID, config$columnas$predictorasNumericas, 
                          config$columnas$target)
  
  
  checkColumnas <- columnasUtilizadas %in% colnames(datos)
  
  check <- all(checkColumnas)
  
  if(!check){
    
    columnasMalos <- columnasUtilizadas[!checkColumnas]
    
    logerror(paste0("Les columnes: ", paste(columnasMalos, collapse = ", "),
                    " no se encuentran en el dataframe!"), logger = 'log')
    stop()
    
  }
  
  
  datos <- datos[, columnasUtilizadas]
  
  datos[is.na(datos[, config$columnas$predictorasNumericas]), config$columnas$predictorasNumericas] <- 0
  
 
  return(datos)
  
}


#' @title media
#'
#' @param datos 
#' @param config 
#'
#' @return
#' @export
#'
#' @examples
  
arithmetic.mean <- function(datos,config) {
  
  dato_media <- sum(datos)/length(datos)
  return(dato_media)
  
  
}


