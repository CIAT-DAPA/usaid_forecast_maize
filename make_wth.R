## Make .WTH

# Function to write .WTH, needs dataset path, out dir, lat, long and name of WTH
# the climate data example is:
# data frame that contain 
# day month  year     tmax  tmin precip     srad   (name columns data frame)


make_wth <- function(data, out_dir, lat, long, name_xfile_climate){
  
  
  ## data <- z[[1]]
  ## it's necessary to add name of wth (year + identify escenario)
  
  Srad <- data$srad
  Tmax <- data$tmax
  Tmin <- data$tmin
  Prec <- data$precip
  date <- data$date_dssat 
  
  sink(paste0(out_dir, name_xfile_climate, '.WTH'), append = F)
  ## Agregar las siguientes Lineas
  
  ##cat(paste("*WEATHER DATA :"),paste(coordenadas[1,1]),paste(coordenadas[1,2]))
  cat(paste("*WEATHER DATA :"), paste("USAID"))
  cat("\n")
  cat("\n")
  cat(c("@ INSI      LAT     LONG  ELEV   TAV   AMP REFHT WNDHT"))
  cat("\n")
  cat(sprintf("%6s %8.3f %8.3f %5.0f %5.1f %5.1f %5.2f %5.2f", "CCCR", lat, long, -99,-99, -99.0, 0, 0))
  cat("\n")
  cat(c('@DATE  SRAD  TMAX  TMIN  RAIN'))
  cat("\n")
  cat(cbind(sprintf("%5s %5.1f %5.1f %5.1f %5.1f", date, Srad, Tmax, Tmin, Prec)), sep = "\n")
  sink()
}



### Funcion para generar tantos .WTH como escenarios climaticos de pronosticos
### Generar esta funcion a modo que el nombre del .WTH sea facil de cambiar

# Example of climate scenarios

# path <- '//dapadfs/Workspace_cluster_9/USAID_Project/Product_3_agro-climatic_forecast/climate/data_forecast/output_resampling/Pronosticos_LaUnion/Escenarios/'

path <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/stations/Forecasts/Escenarios/'
  
climate_list <- list.files(path, pattern = 'escenario', full.names = T)

## function to extract some files that you need

# "escenario_max.csv|escenario_min.csv|escenario_prom.csv"

filter_text <- function(data, matches, different = F){ 
  
  if(different == F){
    
    return(data[grep(matches, data)])
    
  }
  
  if(different == T){
    
    return(data[-grep(matches, data)])
    
  }
  
}



omit_files <- "escenario_max.csv|escenario_min.csv|escenario_prom.csv"


# pattern escenario It's to always filter only the climate scenarios
# Is possible to do this into a function ?

climate_list <- list.files(path, pattern = 'escenario', full.names = T) %>%
                  filter_text(omit_files, different = T)


# you need to have always the column called year because this is the var to change to actual date 
# date is get to ask server for the local date, remeber this depend of the forecasts year to simulate
# the data frame always needs to be
# day month  year     tmax  tmin precip     srad   (name columns data frame)


make_date <- function(data){
  
  # suppress warnings
  options(warn = -1)
  
  require(tidyverse)
  require(lubridate)
  
  # data <- read_csv(climate_list[[1]])
  current_year <- Sys.Date() %>%
                    year()
  
  init_frcast <- ydm(paste(current_year, data$day[1], data$month[1], sep = "-"))
  end_frcast <- ymd(init_frcast) + ddays(dim(data)[1] - 1)
  
  
  frcast_date <- seq(init_frcast,
                  end_frcast, by = '1 day')
  
  # is possible to eliminate some variables?
  
  data <-  tbl_df(data.frame(data, frcast_date)) %>%
              mutate(julian_day = yday(frcast_date),
                     year_2 = as.numeric(substr(year(frcast_date), 3, 4))) %>%
              mutate(date_dssat = mapply(date_for_dssat, year_2, julian_day))
  
  return(data)
}


climate_list_df <- lapply(climate_list, read_csv) %>%
                      lapply(make_date)


##  generate all .WTH files to run DSSAT 
## Proof
data <- climate_list_df[[1]]
out_dir <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Proof_run/'
lat <- -99
long <- -99

# climate_df <- read_csv(paste0(path, station, '.csv'))%>%
#   mutate(date = dmy(paste(day, month, year, sep = '/'))) %>%
#   mutate(julian_day = yday(date), year_2 = substr(year, 3, 4))  


# date_dssat <- 0      
# 
# for(i in 1:dim(climate_df)[1]){
#   
#   date_dssat[i] <- date_for_dssat(climate_df$year_2[i], climate_df$julian_day[i])
#   
# }
# 
# climate_df$date_dssat <- date_dssat


## Es necesario tener en cuenta que siempre las variables deben tener el mismo id
##  ejemplo
## Srad = srad
## Tmax = tmax
## Tmin = tmin
## Prec = precip
## Date = day_dssat   # fecha para la construccion del Julian day necesario para que DSSAT entienda la informacion climatica


# climate_list_df[[1]] %>%
  # mutate(day_dssat = frcast_date)

# climate_list_df <- lapply(climate_list_df, mutate, date_dssat = frcast_date)

## make a function to do this


### quitar del make_wth la extension de .WTH (la idea es que luego se pueda utilizar con .WTG o lo que sea)
make_wth(data, out_dir, -99, -99, name_xfile_climate = 'USAID001')













### Codes to generate .WTH for historical climate data set and scenarios data set 


# library(tidyverse)
# library(lubridate)



# soure(main_functions)


## proof


# climate_df <- read_csv(paste0(path, station, '.csv'))[10, ]
# date_for_dssat(substr(climate_df$year, 3, 4), yday(dmy(paste(climate_df$day, climate_df$month, year, sep = '/'))))
# date_for_dssat(80, 10)

## Codigo quiza cambiar a tidyverse 
# library(dplyr)
# library(readr)




# library(tidyverse)
# library(lubridate)


# path <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/stations/'
# station <- 'LaUnion'

# name_xfile_climate <- 'CCCR8000'  ## se debe indicar tal cual como en el WSTA dentro del archivo x-file

## Luego preguntar cuales son las benditas coordenadas
# substr(date, 9, 10)
# lat <- -99  
# long <- -99

## Las fechas relatan desde 1 Enero 1980 hasta 31 Dicimebre 2014 


# 
# climate_df <- read_csv(paste0(path, station, '.csv'))%>%
#                 mutate(date = dmy(paste(day, month, year, sep = '/'))) %>%
#                 mutate(julian_day = yday(date), year_2 = substr(year, 3, 4))  
# date_dssat <- 0             
# for(i in 1:dim(climate_df)[1]){
#   
#   date_dssat[i] <- date_for_dssat(climate_df$year_2[i], climate_df$julian_day[i])
#   
# }
# 
# climate_df$date_dssat <- date_dssat


# mutate(date_dssat = date_for_dssat(substr(year, 3, 4), yday(dmy(paste(day, month, year, sep = '/')))))


# out_dir <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Runs/'

## Es necesario tener en cuenta que siempre las variables deben tener el mismo id
##  ejemplo
## Srad = srad
## Tmax = tmax
## Tmin = tmin
## Prec = precip
## Date = day_dssat   # fecha para la construccion del Julian day necesario para que DSSAT entienda la informacion climatica


## El codigo esta construido para que funciones para las variables anteriormente mencionadas


## Proof
# data <- climate_df  
# out_dir <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Runs/'
# lat <- -99
# long <- -99






