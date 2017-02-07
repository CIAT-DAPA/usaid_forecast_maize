# diferents functions to necessary to run DSSAT 
# the correct way to suppress warnings is suppressWarnings() instead of options(warn = -1) alone; similarly,
# you should use suppressMessages() to suppress messages


# Functions Necessary to make WTH

# function to load climate data

filter_text <- function(data, matches, different = F){ 
  
  if(different == F){
    
    return(data[grep(matches, data)])
    
  }
  
  if(different == T){
    
    return(data[-grep(matches, data)])
    
  }
  
}



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


# dir_climate <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/stations/Forecasts/Escenarios/'
# x <- load_climate(dir_climate)
 

load_climate <- function(dir_climate){
  
  climate_list <- list.files(dir_climate, pattern = 'escenario', full.names = T)
  
  ## function to extract some files that you need
  
  omit_files <- "escenario_max.csv|escenario_min.csv|escenario_prom.csv"
  
  
  # pattern escenario It's to always filter only the climate scenarios
  # Is possible to do this into a function ?
  
  climate_list <- list.files(dir_climate, pattern = 'escenario', full.names = T) %>%
    filter_text(omit_files, different = T)
  
  
  climate_list_df <- lapply(climate_list, read_csv) %>%
    lapply(make_date)
  
  return(climate_list_df)
  
}








dir_dssat <- 'C:/DSSAT46/'  ## its necessary to have the parameters .CUL, .ECO, .SPE Updated for running (calibrated the crop (MAize))
dir_run <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Proof_run/'
dir_soil <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Runs/CC.SOL'  # for now

# Copy and paste files necessary to run DSSAT in a particular folder


files_dssat(dir_dssat, dir_run, dir_soil)

files_dssat <- function(dir_dssat, dir_run, dir_soil){
  
  
  require(tidyverse)
  
  files <- "MZCER046.CUL|MZCER046.ECO|MZCER046.SPE"  ## special files
  
  exe_dssat <- paste0(dir_dssat, 'DSCSM046.EXE')    ## Executable DSSAT v 4.6
  
  parameters <- paste0(dir_dssat, 'Genotype/') %>%
    list.files(full.names= T) %>%
    filter_text(files, different = F)
  
  file.copy(exe_dssat, dir_run)
  file.copy(parameters, dir_run)
  file.copy(dir_soil, dir_run)
  
  
}
