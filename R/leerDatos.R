#' @title leerDatos
#'
#' @param config 
#' @param path 
#'
#' @return
#' 
#' @import data.table
#' @import logging
#'
leerDatos <- function(config, path){
  
  pathCsv1 <- paste0(path, "miscellaneous/csv/", config$datos$train$t1)
  pathCsv2 <- paste0(path, "miscellaneous/csv/", config$datos$train$t2)
  pathCsv3 <- paste0(path, "miscellaneous/csv/", config$datos$train$t3)
  
  pathCsvTarget <- paste0(path, "miscellaneous/csv/", config$datos$target)
  
  
  
  
  tryCatch(expr = {
    
    datos_csv1 <- data.table::fread(pathCsv1, sep = config$datos$sep,
                               encoding = 'UTF-8', data.table = FALSE)
    datos_csv2 <- data.table::fread(pathCsv2, sep = config$datos$sep,
                                    encoding = 'UTF-8', data.table = FALSE)
    datos_csv3 <- data.table::fread(pathCsv3, sep = config$datos$sep,
                                    encoding = 'UTF-8', data.table = FALSE)
    
    datos_csv_target <- data.table::fread(pathCsvTarget, sep = config$datos$sep,
                                    encoding = 'UTF-8', data.table = FALSE)
    
    
  }, error = function(e){
    
    logerror("Datos no encontrado en su ruta. Verifica el directorio de data y el config",
             logger = 'log')
    stop()
  })
  
  if(nrow(datos_csv1) == 0 | ncol(datos_csv1) == 0){
    
    logerror("Datos 1 mal leido, verifica que tengan un buen formato. ",
             logger = 'log')
    stop()
    
  }
  
  
  if(nrow(datos_csv2) == 0 | ncol(datos_csv2) == 0){
    
    logerror("Datos 2 mal leido, verifica que tengan un buen formato. ",
             logger = 'log')
    stop()
    
  }
  
  
  if(nrow(datos_csv3) == 0 | ncol(datos_csv3) == 0){
    
    logerror("Datos 3 mal leido, verifica que tengan un buen formato. ",
             logger = 'log')
    stop()
    
  }
  
  if(nrow(datos_csv_target) == 0 | ncol(datos_csv_target) == 0){
    
    logerror("Datos target mal leido, verifica que tengan un buen formato. ",
             logger = 'log')
    stop()
    
  }
  df = list(csv1=datos_csv1, csv2=datos_csv2, csv3=datos_csv3, target=datos_csv_target)
  return(df)
  
}

