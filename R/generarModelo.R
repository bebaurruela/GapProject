#' Title
#'
#' @param datos 
#' @param config 
#'
#' @import xgboost
#' @import logging
#'
#' @examples

#datos <- readRDS('df_ready.rds')
generarModelo <- function(datos, config){
  
  #datos <- seleccionColumnas(datos, config) #TODO
  colnames(datos) <- c('v1', 'v2', 'v3', 'v4', 'target')
  #Numero de contactos para entrenar
  numTrain <- round(nrow(datos) * 0.7)
  
  trainPos <- sample(1:nrow(datos), size = numTrain)
  #features <- names(datos)
  #features <- features[2:length(features)]
  train <- datos[trainPos, ]
  test <- datos[-trainPos, ]
  #features <- c('Poblacion', 'poblacion2')
  set.seed(42)
  #model <- lm(features, data=train)
  model <- lm(target ~ v2 + v3 + v4, data=train)
  #summary(model)
  predictions <- predict(model, test)
  
  library(Metrics)
  score <- rmse(predictions, test$target)
  
  v <- list(prediccion = predictions, modelo = model, score=score)
  return(v)
  
}
