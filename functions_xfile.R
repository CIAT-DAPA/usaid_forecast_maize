### All functions for X-file (modules)


## make the archive
## if the file exist this funcion make a diferent copy


make_archive <- function(out_file, overwrite = F, encoding){
  
  options(encoding = encoding) 
  
  if (file.exists(out_file)) {
    if (overwrite) {
      pf <- file(out_file, open = "w")
    } else {
      rnum <- round(runif(1, 10000, 20000), 0)
      tmpvar <- unlist(strsplit(out_file, "/", fixed = T))
      pth_ref <- paste(tmpvar[1:(length(tmpvar) - 1)], collapse = "/")
      out_file <- paste(pth_ref, "/copy-", rnum, "_", tmpvar[length(tmpvar)], sep = "")
      pf <- file(out_file, open = "w")
    }
  } else {
    pf <- file(out_file, open ="w")
  }
  
  
  
  # close(pf)
  return(pf)
}

## test
# out_file <- "./JBID.RIX"
# overwrite <- F

# proof generate the conexcion between R and the file pf into de function make_archive
# proof <- make_archive(out_file, overwrite = F,  encoding = "UTF-8")

# cat('Whatever', file = proof)
# close(proof)

## this function needs a name of experiment, is a header for de x-file
## make general stuff

write_details <- function(name_exp, information){
  
  
  # General stuff
  
  cat(paste0(information$DETAILS, "\n"), file = name_exp)
  cat("\n",file = name_exp)
  cat("*GENERAL\n@PEOPLE\n", file = name_exp)
  cat(paste(sprintf("%-12s", as.character(information$PEOPLE)), "\n", sep = ""), file = name_exp)
  cat("@ADDRESS\n", file = name_exp)
  cat(paste(sprintf("%-12s", as.character(information$ADDRESS)), "\n", sep = ""), file = name_exp)
  cat("@SITE\n", file = name_exp)
  cat(paste(sprintf("%-12s", as.character(information$SITE)), "\n", sep = ""), file = name_exp)
  
}

# information <- make_details()
# write_details(proof, information)
# close(proof)

