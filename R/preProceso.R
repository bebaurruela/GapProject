

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

#datos <- readRDS('df_ready.rds')
preProcesarDatos <- function(datos, config){
  library(tidyverse)

  df_col1 <- preProcesarCSV(datos$csv1, config)
  col2 <- preProcesarCSV(datos$csv2, config, column_format=TRUE)
  col3 <- preProcesarCSV(datos$csv3, config, column_format=TRUE)
  col_target <- preProcesarCSV(datos$target, config, column_format=TRUE)
  
  
  # Cols dont have a significative name
  df <- cbind(df_col1, col2, col3, col_target)
  colnames(df) <- c('CountryYear', 'csv1', 'csv2', 'csv3', 'target')
  
  # Look for NAs
  df[is.na(df[, 'csv1']), 'csv1'] <- 0
  df[is.na(df[, 'csv2']), 'csv2'] <- 0
  df[is.na(df[, 'csv3']), 'csv3'] <- 0
  
  df[is.na(df[, 'target']), 'target'] <- 0
  
  
  
  print('Finished executing preprocessing')
  return(df)
}


