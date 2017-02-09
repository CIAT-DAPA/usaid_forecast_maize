## script to proof all functions generated
library(tidyverse)
library(lubridate)
library(magrittr)

path_functions <- "D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/"  # path when is the functions necessary to run by region, scenario and multiple days to platform USAID forecast

dir_dssat <- 'C:/DSSAT46/'  ## its necessary to have the parameters .CUL, .ECO, .SPE Updated for running (calibrated the crop (Maize))
dir_run <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/'
dir_soil <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Runs/CC.SOL'  # it is not only the folder is all path when is the soil file
dir_climate <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/stations/Forecasts/Escenarios/'
region <- "LaUnion" 
name_files <-"USAID"   ## Weather station (generic), x-file name and for the indicate the run into the DSSBatch
# PDATE <- 17274
# SDATE <- 17274
select_day <- 1 ## 1 primer dia a simular 2 segundo dia etc....  select day to simulate from first date of climate forecast o then
number_days <- 45 ## Numero de dias a simular desde el primer dia del pronostico climatico (SDATE siempre seria el primer dia del pronostico)

## add source functions

source(paste0(path_functions, 'make_wth.R'))
source(paste0(path_functions, 'make_batch.R'))
source(paste0(path_functions, 'make_parameters.R'))
source(paste0(path_functions, 'main_functions.R'))
source(paste0(path_functions, 'settings_xfile.R'))
source(paste0(path_functions, 'functions_xfile.R'))



climate_scenarios <- load_climate(dir_climate)
input_dates <- make_PS(climate_scenarios, number_days)


## its possible to generate a parameters in a list? maybe is better
# run_dssat(dir_dssat, dir_soil, dir_run, region, name_files, input_dates)
run_dssat <- function(dir_dssat, dir_soil, dir_run, region, name_files, input_dates){
  
  ## make dir to run based on a folder input by climate scenario (folder_001, ..... , folder_100) 
  
  options(encoding = "UTF-8")
  
  dir_base <- paste0(dir_run, 'temporal/')

  dir_run_id <- make_id_run(dir_base, region, select_day) ## make folder by PDATE? is it confusing them?
  
  ## in this point its necessary to add all functions that can to wirte files (x-file, weather, soil, batch)
  

  
  ## add function to load climate datasets 
  
  # climate_scenarios <- load_climate(dir_climate)
  # select_day <- day
  
  
  ## Quizá lo siguiente agregarlo a una funcion para ser facil de modificar luego 
  
  # PDATE <- climate_scenarios[[1]] %>%
  #   filter( row_number() == select_day) %>%
  #   select(date_dssat) %>%
  #   extract2(1) 
  
  # SDATE <- climate_scenarios[[1]] %>%
  #   filter( row_number() == 1) %>%
  #   select(date_dssat) %>%
  #   extract2(1) 

  # PDATE + day 
  
  PDATE <- input_dates$PDATE[1]  ## for now when proof change, delete [1]
  SDATE <- input_dates$SDATE[1]
  
  
  make_xfile_region(region, paste0(name_files, sprintf("%.3d", 1:99)), paste0(dir_run_id, name_files, '.MZX'), PDATE, SDATE) ## Remember them can to change the filename to different regions
  
  ## add code that write multiple WTH as many as climate scenarios
  ## add ciclo for 
  

  invisible(make_mult_wth(climate_scenarios, dir_run_id, name_files))
  # name_xfile_climate <- paste0('USAID', sprintf("%.3d", day))
  
  # make_wth(climate_scenarios[[day]], dir_run_id, -99, -99, name_xfile_climate)
  
  # Make Batch
  
  CSMbatch("MAIZE", paste0(name_files, '.MZX'), paste0(dir_run_id, "DSSBatch.v46"))
  
  # add files necessay to run DSSAT
  
  
  files_dssat(dir_dssat, dir_run_id, dir_soil)
  
  ### here add function to execute DSSAT
  execute_dssat(dir_run_id)
  # setwd()
  
  
  
  # setwd(dir_run)
  ## here add function to load de output necessary
  
  
  ## make a Descriptive Statistics
  
  ##
  setwd(dir_run)
  # unlink(paste0(strsplit(dir_run_id, "/")[[1]], collapse = "/"), recursive = TRUE)
}































