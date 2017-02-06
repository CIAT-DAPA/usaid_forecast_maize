# diferents functions to necessary to run DSSAT 

dir_dssat <- 'C:/DSSAT46/'  ## its necessary to have the parameters .CUL, .ECO, .SPE Updated for running (calibrated the crop (MAize))
dir_run <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Proof_run/'
dir_soil <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Runs/CC.SOL'  # for now

# Copy and paste files necessary to run DSSAT in a particular folder

# add the next function to the actual environment

# filter_text <- function(data, matches, different = F){ 
#   
#   if(different == F){
#     
#     return(data[grep(matches, data)])
#     
#   }
#   
#   if(different == T){
#     
#     return(data[-grep(matches, data)])
#     
#   }
#   
# }

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
