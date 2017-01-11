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

# proof generate the conexion between R and the file pf into de function make_archive
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

write_treatments <- function(name_exp, information){
  
  cat("*TREATMENTS                        -------------FACTOR LEVELS------------\n", file = name_exp)
  cat("@N R O C TNAME.................... CU FL SA IC MP MI MF MR MC MT ME MH SM\n", file = name_exp)
  for (i in 1:nrow(information)) {

    cat(paste(sprintf("%1$2d%2$2d%3$2d%4$2d",as.integer(information$N[i]),as.integer(information$R[i]),
                      as.integer(information$O[i]),as.integer(information$C[i])),
              " ",sprintf("%1$-25s%2$3d%3$3d%4$3d%5$3d%6$3d%7$3d%8$3d%9$3d%10$3d%11$3d%12$3d%13$3d%14$3d",information$TNAME[i],
                          as.integer(information$CU[i]),as.integer(information$FL[i]),as.integer(information$SA[i]),
                          as.integer(information$IC[i]),as.integer(information$MP[i]),as.integer(information$MI[i]),
                          as.integer(information$MF[i]),as.integer(information$MR[i]),as.integer(information$MC[i]),
                          as.integer(information$MT[i]),as.integer(information$ME[i]),as.integer(information$MH[i]),
                          as.integer(information$SM[i])),
              "\n", sep = ""), file = name_exp)

  }
  cat("\n", file = name_exp)
  
}

# information <- make_treatments(IC, MI, MF, MH)
# write_details(proof,  make_treatments(IC, MI, MF, MH))
# close(proof)


