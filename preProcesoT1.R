

df2 <- readRDS("df1.rds")
df2

preProcesoT1 <- function(df2)
  
{
  # Create a df with country as index and year as column
  
  df <- data.frame(df2, row.names = 'V1')
  #colnames(df) <- as.numeric(df[1,])
  colnames(df) <- df[1,]
  
  valid_cols = c("1990", "1991", "1992", "1993", "1994", "1995", "1996",
                 "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004")
  valid_cols_mask <- colnames(df) %in% valid_cols
  
  df_correct_years <- colnames(df)[valid_cols_mask]
  
  
}
  
df3 <- preProcesoT1(df2)
df3

preProcesoT1_2 <- function(df2)
  
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
  
  
vect1 <- row_by_name(df4, c("Australia", "Belgium"))
vect1



#df1 <- readRDS("df1.rds")

#saveRDS(datos_csv1, file="df1.rds")
