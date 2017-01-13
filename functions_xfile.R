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

# write_details(proof,  make_treatments(IC, MI, MF, MH))
# close(proof)

write_cultivars <- function(name_exp, information){
  
  cat("*CULTIVARS\n", file = name_exp)
  cat("@C CR INGENO CNAME\n", file = name_exp)
  for (i in 1:nrow(information)) {
    cat(paste(sprintf("%2d",as.integer(information$C[i]))," ",sprintf("%2s", information$CR[i]),
              " ", sprintf("%6s",information$INGENO[i])," ",sprintf("%-12s",information$CNAME[i]),
              "\n", sep = ""), file = name_exp)
  }
  cat("\n", file = name_exp)
  
}


# write_cultivars(proof, make_cultivars(CR, INGENO, CNAME))
# close(proof)


write_fields <- function(name_exp, information){
  
  # fields
  cat("*FIELDS\n", file = name_exp)
  cat("@L ID_FIELD WSTA....  FLSA  FLOB  FLDT  FLDD  FLDS  FLST SLTX  SLDP  ID_SOIL    FLNAME\n", file = name_exp)
  for (i in 1:nrow(information)) {

    cat(paste(sprintf("%2d",as.integer(information$L[i]))," ",sprintf("%-8s",information$ID_FIELD[i]),
              " ",sprintf("%-8s",information$WSTA[i]),sprintf("%6d",as.integer(information$FLSA[i])),
              sprintf("%6d",as.integer(information$FLOB[i])),sprintf("%6s",information$FLDT[i]),
              sprintf("%6d",as.integer(information$FLDD[i])),sprintf("%6s",as.integer(information$FLDS[i])),
              sprintf("%6d",as.integer(information$FLST[i]))," ",sprintf("%-4d",as.integer(information$SLTX[i])),
              sprintf("%6d",as.integer(information$SLDP[i])),"  ",sprintf("%-10s",information$ID_SOIL[i])," ",
              sprintf("%-12s",information$FLNAME[i]),"\n", sep=""),file=name_exp)

  }

  cat("\n", file = name_exp)
  
  
  cat("@L ..........XCRD ...........YCRD .....ELEV .............AREA .SLEN .FLWR .SLAS FLHST FHDUR\n",file=name_exp)
  # 
  # for (i in 1:nrow(information)) { 
  #   
  #   
  #   cat(paste(sprintf("%2d",as.integer(information$L[i]))," ",sprintf("%15.3f",information$XCRD[i])," ",
  #             sprintf("%15.3f",information$YCRD[i])," ",sprintf("%9d",as.integer(information$ELEV[i]))," ",
  #             sprintf("%17d",as.integer(information$AREA[i]))," ",sprintf("%5d",as.integer(information$SLEN[i]))," ",
  #             sprintf("%5d",as.integer(information$FLWR[i]))," ",sprintf("%5d",as.integer(information$SLAS[i]))," ",
  #             sprintf("%5d",as.integer(information$FLHST[i]))," ",sprintf("%5d",as.integer(information$FHDUR[i])),
  #             "\n",sep=""),file=name_exp)
  #   
  #   
  # }
  
  for (i in 1:nrow(information)) { 
    
    
    cat(paste(sprintf("%2d",as.integer(information$L[i]))," ",sprintf("%14.d",information$XCRD[i])," ",
              sprintf("%15.d",information$YCRD[i])," ",sprintf("%9d",as.integer(information$ELEV[i]))," ",
              sprintf("%17d",as.integer(information$AREA[i]))," ",sprintf("%5d",as.integer(information$SLEN[i]))," ",
              sprintf("%5d",as.integer(information$FLWR[i]))," ",sprintf("%5d",as.integer(information$SLAS[i]))," ",
              sprintf("%5d",as.integer(information$FLHST[i]))," ",sprintf("%5d",as.integer(information$FHDUR[i])),
              "\n",sep=""), file=name_exp)
    
    
  }
  
  
  cat("\n",file=name_exp)
  
}

# write_fields(proof, make_fields(WSTA, ID_SOIL))
# close(proof)


write_IC <- function(name_exp, information){
  
  #initial conditions
  cat("*INITIAL CONDITIONS\n",file=name_exp)
  cat("@C   PCR ICDAT  ICRT  ICND  ICRN  ICRE  ICWD ICRES ICREN ICREP ICRIP ICRID ICNAME\n",file=name_exp)
  
  cat(paste(sprintf("%2d",as.integer(information$field$C))," ",sprintf("%5s",information$field$PCR),
            " ",sprintf("%5s",information$field$ICDAT)," ",sprintf("%5d",as.integer(information$field$ICRT)),
            " ",sprintf("%5d",as.integer(information$field$ICND))," ",sprintf("%5d",as.integer(information$field$ICRN)),
            " ",sprintf("%5d",as.integer(information$field$ICRE))," ",sprintf("%5d",as.integer(information$field$ICWD)),
            " ",sprintf("%5d",as.integer(information$field$ICRES))," ",sprintf("%5d",as.integer(information$field$ICREN)),
            " ",sprintf("%5d",as.integer(information$field$ICREP))," ",sprintf("%5d",as.integer(information$field$ICRIP)),
            " ",sprintf("%5d",as.integer(information$field$ICRID))," ",sprintf("%-12s",information$field$ICNAME),
            "\n",sep=""),file=name_exp)
  cat("@C  ICBL  SH2O  SNH4  SNO3\n",file=name_exp)


  for (i in 1:nrow(information$values)) {
    cat(paste(sprintf("%2d %5d %5d %5.2f %5.2f", 1, information$values[i, 'ICBL'], information$values[i, 'SH20'],
                      information$values[i, 'SNH4'], information$values[i , 'SNO3'])), "\n", file = name_exp)
  }
  cat("\n",file=name_exp)
}

# write_IC(proof, make_IC(ICBL, SH20, SNH4, SNO3))
