preProcesarCSV <- function(datos, column_format=FALSE){
  
  countries_to_keep <- c("Australia", "Canada", "Estonia", "France",
                         "Japan","New Zealand", "Norway", "South Korea", 
                         "Sweden", "Turkey", "United States")
  
  # df with country as index
  df <- data.frame(datos, header=TRUE, row.names="V1")
  
  # years added as colnames
  colnames(df) <- df[1,]
  
  # Only keeps the countries we asked for
  df <- df[countries_to_keep, ]
  
  # Keep the columns with the years we want
  valid_cols = c("1990", "1991", "1992", "1993", "1994", "1995", "1996",
                 "1997", "1998", "1999", "2000", "2001", "2002", 
                 "2003", "2004")
  
  valid_cols_mask <- colnames(df) %in% valid_cols
  
  df_correct_years <- colnames(df)[valid_cols_mask]
  
  df <- df[df_correct_years]
  
  # Time to change the format so index becomes Country_year
  df <- data.frame(rownames(df), df, stringsAsFactors = F)
  
  # Rename columns
  colnames(df) <- c("pais", valid_cols)
  
  df <- gather(df, key= "CountryYear", value = "Value", c("1990":"2004"))
  
  df <- df[order(df$pais),]
  
  df <- df %>% unite(`CountryYear`, pais:`CountryYear`, sep = "_")
  
  if(column_format==FALSE)
    return(df)
  else
    return(df$Value)
  
}
