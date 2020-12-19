
df2 <- readRDS("mi_df2.rds")
preProcesoT2 <- function(df2, config)
  
{
  # Create a df with country as index and year as column
  df <- df2$csv2
  dff <- data.frame(df, row.names = 'V1')
  #colnames(dff) <- as.numeric(dff[1,])
  colnames(dff) <- dff[1,]
  
  valid_cols = c("1990", "1991")
  valid_cols_mask <- colnames(dff) %in% valid_cols
  
  dff_correct_years <- colnames(dff)[valid_cols_mask]
  
  #ncol(df2$csv2) 29
  #nrow(df2$csv2) 122
  #df2$csv2[1,] devuelve country y todos los paises
  
  #primera columna contiene paises
  # busco en ella los paises que figuran en config$filas$paises, que ojo van con espacios
  
  #desde 2..length de las columnas, el primer elemento es el anio, cojo el anio
  # si figura en config$columnas$predictorasNumericas
  
  
}
  
  
  #indice col1 pais_anio GUATEMALA_2020 %in% config$...
  #tasa_de_paro col2 valor 0.6565