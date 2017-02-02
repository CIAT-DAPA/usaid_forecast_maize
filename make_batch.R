##############################################################################################################
#  Create batch file for CSM (.v46 file) 
##############################################################################################################

# crop <- "MAIZE"
# name <- "proof.MZX"  # for linux ./proof.MZX, for windows proof.MZX
# filename <- "DSSBatch.v46"  # filename

# to test
# its necessary to add dir_run into a funtion than is goint to run DSSAT with all specification and run into a particular folder
# dir_run <- 'D:/CIAT/USAID/DSSAT/multiple_runs/R-DSSATv4.6/Proof_run/'
# CSMbatch(crop, name, paste0(dir_run, bname))


CSMbatch <- function(crop, name, filename) {
  
  outbatch <- rbind(
    rbind(
      # Batchfile headers            
      paste0("$BATCH(", crop, ")"),            
      "!",            
      cbind(sprintf("%6s %92s %6s %6s %6s %6s", "@FILEX", "TRTNO", "RP", "SQ", "OP", 
                    "CO"))),            
    cbind(sprintf("%6s %88s %6i %6i %6i %6i",            
                  paste0(name),
                  1,  # Variable for treatment number            
                  1,  # Default value for RP element            
                  0,  # Default value for SQ element            
                  1,  # Default value for OP element            
                  0)))  # Default value for CO element 
  
  # Write the batch file to the selected folder  
  write(outbatch, file = filename, append = F)
  
}





