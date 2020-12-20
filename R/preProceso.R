

#' Title
#'
#' @param datos 
#' @param config 
#'
#' @return
#' @import logging
#'
#' @examples
#' 

datos <- readRDS('df_ready.rds')
preProcesarDatos <- function(datos, config){
  library(tidyverse)
  df_col1 <- preProcesarCSV(datos$csv1)
  col2 <- preProcesarCSV(datos$csv2, column_format=TRUE)
  col3 <- preProcesarCSV(datos$csv3, column_format=TRUE)
  
  # Cols dont have a significative name
  df <- cbind(df_col1, col2, col3)
  print('Finished executing preprocessing')
  return(df)
}


