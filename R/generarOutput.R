#' Title
#'
#' @param output 
#' @param config 
#' @param path 
#'
#' @import logging
#' @return
#'
generarOutput <- function(output, config, path){

  marcaTmp <- Sys.time()
  
  nombreArchivoPredicciones <- paste0(path, "output/Predicciones.csv")
  nombreArchivoScore <- paste0(path, "output/Score.txt")
  
  tryCatch(expr = {
    
    write.csv(output$prediccion, file = nombreArchivoPredicciones, sep = config$datos$sep,
              row.names = FALSE)
    
    write.csv(output$score, file = nombreArchivoScore)
    
  }, error = function(e){
    
    logerror("Ha fallado el guardado!!", logger = 'log')
    stop()
  })
  
  
  nombreArchivo <- paste0(path, "output/modelo.rds")
  
  tryCatch(expr = {
    
    saveRDS(output$modelo, file = nombreArchivo)
    
  }, error = function(e){
    
    logerror("Ha fallado el guardado del modelo!!", logger = 'log')
    stop()
  })
  
  
}