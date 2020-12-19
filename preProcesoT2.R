# Función saca la poblacion para los años y paises que queremos del csv Population

df2 <- readRDS("mi_df2.rds")
df2
df_foo <- df2$csv2

df4 <- data.frame(df2$csv2, header=TRUE, row.names="V1")

colnames(df4) <- df4[1,]


row_by_name <- function(df4, row){
  
  df4 <- df4[row, ]
  
  valid_cols = c("1990", "1991", "1992", "1993", "1994", "1995", "1996",
                 "1997", "1998", "1999", "2000", "2001", "2002", 
                 "2003", "2004")
  
  valid_cols_mask <- colnames(df4) %in% valid_cols
  
  df_correct_years <- colnames(df4)[valid_cols_mask]
  
  df5 <- df4[df_correct_years]
  
  return(df5)
}


vect1 <- row_by_name(df4, c("Australia", "Canada", "Estonia", "France",
                            "Japan","New Zealand", "Norway", "South Korea", 
                            "Sweden", "Turkey", "United States"))


coln <- colnames(vect1)
vect1 <- data.frame(rownames(vect1), vect1, stringsAsFactors = F)
colnames(vect1) <- c("pais", coln)

library(tidyverse)
vect2 <- gather(vect1, key= "Pais-Año", value = "Poblacion", c("1990":"2004"))

vect2 <- vect2[order(vect2$pais),]

vect2 <- vect2 %>% unite(Pais_y_Año, pais:`Pais-Año`, sep = "_")

poblacion2 <- vect2$Poblacion
vect3 <- vect2
vect3 <- cbind(vect3, poblacion2)
