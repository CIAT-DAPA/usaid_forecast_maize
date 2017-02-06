## script to proof all functions generated



dir_dssat <- 'C:/DSSAT46/'  ## its necessary to have the parameters .CUL, .ECO, .SPE Updated for running (calibrated the crop (MAize))
dir_run <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Proof_run/'
dir_soil <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Runs/CC.SOL'  # for now
dir_climate <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/stations/Forecasts/Escenarios/'
Region <- "LaUnion" 
WSTA <-"USAID001"


## add source functions
# source()


## is possible to generate a parameters in a list? maybe is better
run_dssat <- function(dir_dssat, dir_soil, dir_run, dir_climate, Region, WSTA){
  
  ## make dir to run based on a folder input by climate scenario (folder_001, ..... , folder_100) 
  
  
  
  
  ## in this point its necessary to add all functions that can to wirte files (x-file, weather, soil, batch)
  
  make_xfile_region(Region, WSTA, paste0(dir_run, 'proof.MZX')) ## Remember them can to change the filename to different regions
  
  ## add function to load climate datasets 
  
  
  
  make_wth(data, out_dir, -99, -99, name_xfile_climate = 'USAID001')
  
  CSMbatch(crop, name, paste0(dir_run, filename))
  
  ### here add function to execute DSSAT
  
  
  
  ## here add function to load de output necessary
  
  
  ## make a Descriptive Statistics
  
  
  
}































