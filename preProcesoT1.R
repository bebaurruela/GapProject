

df2 <- readRDS("df1.rds")
df2

  
df4 <- data.frame(df2, header=TRUE, row.names="V1")
colnames(df4) <- df4[1,]


row_by_name <- function(df4, row){
    df4 <- df4[row, ]
    
    valid_cols = c("1990", "1991", "1992", "1993", "1994", "1995", "1996",
                   "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004")
    valid_cols_mask <- colnames(df4) %in% valid_cols
    
    df_correct_years <- colnames(df4)[valid_cols_mask]
    df5 <- df4[df_correct_years]
    return(df5)
  }
  
  
vect1 <- row_by_name(df4, c("Australia", "Canada", "Estonia", "France", "Japan",
                            "New Zealand", "Norway", "South Korea", "Sweden", 
                            "Turkey", "United States"))
vect1



#df1 <- readRDS("df1.rds")

#saveRDS(datos_csv1, file="df1.rds")
