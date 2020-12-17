directorio <- "~/ProyectosR/GapProject/"

setwd(directorio)

lapply(paste0("R/", list.files(path = "R/", recursive = TRUE)), source)


debug(clasificarContactosApp)
clasificarContactosApp(directorio)
undebug(clasificarContactosApp)

# BUENAS DIOS A TODOS