## Make .WTH
# year <- climate_df$year_2[i]
# day_year <- climate_df$julian_day[i]




date_for_dssat <- function(year, day_year) {
  
  
  if(nchar(day_year) == 1){
    
    data <- paste0(year, '00', day_year)
  }
  
  if(nchar(day_year) == 2){
    
    data <- paste0(year, '0', day_year)
  }
  
  if(nchar(day_year) == 3){
    
    data <- paste0(year, day_year)
  }
 
  return(data)
  
}


## proof


# climate_df <- read_csv(paste0(path, station, '.csv'))[10, ]
# date_for_dssat(substr(climate_df$year, 3, 4), yday(dmy(paste(climate_df$day, climate_df$month, year, sep = '/'))))
# date_for_dssat(80, 10)

## Codigo 
library(dplyr)
library(readr)
library(lubridate)


path <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/stations/'
station <- 'LaUnion'
name_xfile_climate <- 'CCCR8000'  ## se debe indicar tal cual como en el WSTA dentro del archivo x-file

## Luego preguntar cuales son las benditas coordenadas
# substr(date, 9, 10)
lat <- -99  
long <- -99

## Las fechas relatan desde 1 Enero 1980 hasta 31 Dicimebre 2014 

# climate_df <- read_csv(paste0(path, station, '.csv')) %>%
  # mutate(date = dmy(paste(day, month, year, sep = '/'))) %>%
  # mutate(day_year = yday(date)) %>%
  # mutate(date_dssat = date_for_dssat(paste0(substr(year, 3, 4)), paste0(day_year)))
  
climate_df <- read_csv(paste0(path, station, '.csv'))%>%
                mutate(date = dmy(paste(day, month, year, sep = '/'))) %>%
                mutate(julian_day = yday(date), year_2 = substr(year, 3, 4))  
date_dssat <- 0             
for(i in 1:dim(climate_df)[1]){
  
  date_dssat[i] <- date_for_dssat(climate_df$year_2[i], climate_df$julian_day[i])
  
}

climate_df$date_dssat <- date_dssat

  
  # mutate(date_dssat = date_for_dssat(substr(year, 3, 4), yday(dmy(paste(day, month, year, sep = '/')))))


out_dir <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Runs/'

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


make_wth <- function(data, out_dir, lat, long){
  
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