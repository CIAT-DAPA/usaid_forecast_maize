
run_dssat <- function(dir_dssat, dir_soil, dir_run, region, name_files, input_dates, select_day, cultivar, climate){
  
  ## make dir to run based on a folder input by climate scenario (folder_001, ..... , folder_100) 
  
  options(encoding = "UTF-8")
  
  dir_base <- paste0(dir_run, 'temporal/')
  
  dir_run_id <- make_id_run(dir_base, region, cultivar, select_day) ## make folder by PDATE? is it confusing them?
  
  ## in this point its necessary to add all functions that can to wirte files (x-file, weather, soil, batch)
  
  # paste0(dir_base, region, '/', cultivar,  '/', select_day)
  
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
  
  PDATE <- input_dates$PDATE[select_day]  ## for now when proof change, delete [1]
  SDATE <- input_dates$SDATE[select_day]
  
  
  make_xfile_region(region, paste0(name_files, sprintf("%.3d", 1:99)), paste0(dir_run_id, name_files, '.MZX'), PDATE, SDATE, cultivar, ID_SOIL) ## Remember them can to change the filename to different regions
  
  
  invisible(make_mult_wth(climate, dir_run_id, name_files))
  
  # Make Batch
  
  CSMbatch("MAIZE", paste0(name_files, '.MZX'), paste0(dir_run_id, "DSSBatch.v46"))
  
  # add files necessay to run DSSAT
  
  
  files_dssat(dir_dssat, dir_run_id, dir_soil)
  
  ### here add function to execute DSSAT
  execute_dssat(dir_run_id)
  # setwd()
  
  # setwd(dir_run)
  ## here add function to load de output necessary
  
  summary_out <- read_summary(dir_run_id) %>%
                  mutate(yield_0 = HWAH, d_dry = MDAT-PDAT)   ## rename some variables for the server
  weather_out <- read_mult_weather(dir_run_id)
  
  ## make a Descriptive Statistics
  
  calc_desc(summary_out, "yield_0")
  calc_desc(summary_out, "d_dry")
  
  calc_desc(summary_out, "HWAH")
  
  ## Write files in a particular folder
  
  
  
  setwd(dir_run)
  # unlink(paste0(strsplit(dir_run_id, "/")[[1]], collapse = "/"), recursive = TRUE)
}
