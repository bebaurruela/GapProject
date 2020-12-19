#' Title
#'
#' @param datos 
#' @param config 
#'
#' @import xgboost
#' @import logging
#'
#' @examples

datos <- readRDS('df_ready.rds')
generarModelo <- function(datos, config){
  
  #datos <- seleccionColumnas(datos, config) #TODO
  
  #Numero de contactos para entrenar
  numTrain <- round(nrow(datos) * 0.7)
  
  trainPos <- sample(1:nrow(datos), size = numTrain)
  features <- names(datos)
  features <- features[2:length(features)]
  train <- datos[trainPos, features]
  test <- datos[-trainPos, features]
  
  set.seed(42)
  model <- lm(features, data=train)
  predictions <- predict(model, test)
  
  library(Metrics)
  score <- rmse(predictions, test$target)
  
  return(list(prediccion = predictions, modelo = model, score=score))
  
}




#' Title
#'
#' @param datosSplit 
#' @param config 
#'
#' @return
#' @export
#'
#' @examples
seleccionColumnas <- function(datos, config) {
  #Seleccionamos las columnas que vamos a necesitar para la prediccion
  
  
  #Columnas que va a usar el modelo
  columnasFeatures <- grep(config$columnas$predictorasNumericas, colnames(contactosEntrenados),
                           ignore.case = T, value = T)
  columnaTarget <- config$columnas$target
  # 
  # #Por un lado las columnas de las diferencias de fechas
  # columnasDiff <- grep("diff", colnames(contactosEntrenados), ignore.case = T,
  #                      value = T)
  # 
  # #Las columnas con los ratios de los mails
  # columnasRatioMail <- grep("mails_", colnames(contactosEntrenados), ignore.case = T,
  #                           value = T)
  # 
  # #Las columnas con las dummies de la fuente original
  # columnasOriginalSource <- grep(config$columnas$fuenteOriginal, colnames(contactosEntrenados),
  #                                ignore.case = T, value = T)
  # 
  # #Agrupamos todas esas columnas que van a entrar al modelo
  # variablesToModel <- c(config$columnas$predictorasNumericas, config$columnas$mails$mailsDl,
  #                       config$columnas$mails$mailsCl, config$columnas$mails$mailsOp,
  #                       columnasOriginalSource, columnasRatioMail, columnasDiff, "gmail")
  # 
  #Añadimos las columnas que son necesarias guardar
  # colNecesarias <- c(variablesToModel, config$columnas$ID, config$columnas$llamada)
  # 
  # #El dataframe entrenado tiene la columna target, pero el dataframe de predict no por lo que la añadimos
  # colNecesariasEnt <- c(colNecesarias, "target")
  colNecesariasEnt <- c(config$columnas$predictorasNumericas, config$columnas$target)
  
  if(!all(colNecesariasEnt %in% colnames(contactosEntrenados))){
    
    logerror("Alguna variable predictora no se ha encontrado", logger = 'log')
    stop()
  }
  
  #Nos quedamos con las columnas que queremos de cada dataset
  
  contactosEntrenados <- contactosEntrenados[, colNecesariasEnt]
  contactosPredict <- contactosPredict[, columnasFeatures]
  
  return(list(contactosEntrenados = contactosEntrenados, 
              contactosPredict = contactosPredict, 
              variablesToModel = colNecesariasEnt))
}