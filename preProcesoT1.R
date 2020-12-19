
# Función saca la poblacion para los años y paises que queremos del csv Population



df1 <- readRDS("df1.rds")
df1


df1 <- data.frame(df1, header=TRUE, row.names="V1")

colnames(df1) <- df1[1,]


row_by_name <- function(df1, row){
  
  df1 <- df1[row, ]
  
  valid_cols = c("1990", "1991", "1992", "1993", "1994", "1995", "1996",
                 "1997", "1998", "1999", "2000", "2001", "2002", 
                 "2003", "2004")
  
  valid_cols_mask <- colnames(df1) %in% valid_cols
  
  df_correct_years <- colnames(df1)[valid_cols_mask]
  
  df1 <- df1[df_correct_years]
  
  return(df1)
}


vect1 <- row_by_name(df1, c("Australia", "Canada", "Estonia", "France",
                            "Japan","New Zealand", "Norway", "South Korea", 
                            "Sweden", "Turkey", "United States"))


coln <- colnames(vect1)
vect1 <- data.frame(rownames(vect1), vect1, stringsAsFactors = F)
colnames(vect1) <- c("pais", coln)

vect2 <- gather(vect1, key= "Pais-Año", value = "Poblacion", c("1990":"2004"))

vect2 <- vect2[order(vect2$pais),]

vect2 <- vect2 %>% unite(Pais_y_Año, pais:`Pais-Año`, sep = "_")
