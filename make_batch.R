##############################################################################################################
#  Create batch file for CSM (.v46 file) 
##############################################################################################################

# crop <- "MAIZE"
# name <- "proof.MZX"  # for linux ./proof.MZX, for windows proof.MZX
# bname <- "DSSBatch.v46"


# to test
# CSMbatch(crop, name, bname) 
CSMbatch <- function(crop, name, bname) {
  
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
  write(outbatch, bname, append = F)
  
}


