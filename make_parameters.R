
make_parameters <- function(){
  
  
}



make_xfile <- function(in_data, out_file, overwrite = F) {
  
  #open file in write mode
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
    pf <- file(out_file,open="w")
  }
  
  #write header and stuff
  #pf <- file(out_file,open="w")
  cat(paste0(information$exp_details, "\n"), file = pf)
  cat("\n",file = pf)
  
  #general stuff
  cat("*GENERAL\n@PEOPLE\n", file = pf)
  cat(paste(sprintf("%-12s", as.character(in_data$general$PEOPLE)), "\n", sep = ""), file = pf)
  cat("@ADDRESS\n", file = pf)
  cat(paste(sprintf("%-12s", as.character(in_data$general$ADDRESS)), "\n", sep = ""), file = pf)
  cat("@SITE\n", file = pf)
  cat(paste(sprintf("%-12s", as.character(in_data$general$SITE)), "\n", sep = ""), file = pf)
  
  #treatments
  cat("*TREATMENTS                        -------------FACTOR LEVELS------------\n", file = pf)
  cat("@N R O C TNAME.................... CU FL SA IC MP MI MF MR MC MT ME MH SM\n", file = pf)
  for (i in 1:nrow(in_data$treatments)) {
    
    cat(paste(sprintf("%1$2d%2$2d%3$2d%4$2d",as.integer(in_data$treatments$N[i]),as.integer(in_data$treatments$R[i]),
                      as.integer(in_data$treatments$O[i]),as.integer(in_data$treatments$C[i])),
              " ",sprintf("%1$-25s%2$3d%3$3d%4$3d%5$3d%6$3d%7$3d%8$3d%9$3d%10$3d%11$3d%12$3d%13$3d%14$3d",in_data$treatments$TNAME[i],
                          as.integer(in_data$treatments$CU[i]),as.integer(in_data$treatments$FL[i]),as.integer(in_data$treatments$SA[i]),
                          as.integer(in_data$treatments$IC[i]),as.integer(in_data$treatments$MP[i]),as.integer(in_data$treatments$MI[i]),
                          as.integer(in_data$treatments$MF[i]),as.integer(in_data$treatments$MR[i]),as.integer(in_data$treatments$MC[i]),
                          as.integer(in_data$treatments$MT[i]),as.integer(in_data$treatments$ME[i]),as.integer(in_data$treatments$MH[i]),
                          as.integer(in_data$treatments$SM[i])),
              "\n", sep = ""), file = pf)
    
  }
  cat("\n", file = pf)
  
  #cultivars
  cat("*CULTIVARS\n", file = pf)
  cat("@C CR INGENO CNAME\n", file = pf)
  for (i in 1:nrow(in_data$cultivars)) {
    cat(paste(sprintf("%2d",as.integer(in_data$cultivars$C[i]))," ",sprintf("%2s", in_data$cultivars$CR[i]),
              " ", sprintf("%6s",in_data$cultivars$INGENO[i])," ",sprintf("%-12s",in_data$cultivars$CNAME[i]),
              "\n", sep = ""), file = pf)
  }
  cat("\n", file = pf)
  
  #fields
  cat("*FIELDS\n", file = pf)
  cat("@L ID_FIELD WSTA....  FLSA  FLOB  FLDT  FLDD  FLDS  FLST SLTX  SLDP  ID_SOIL    FLNAME\n", file = pf)
  for (i in 1:nrow(in_data$treatments)) { 
    
    cat(paste(sprintf("%2d",as.integer(in_data$fields$L[i]))," ",sprintf("%-8s",in_data$fields$ID_FIELD[i]),
              " ",sprintf("%-8s",in_data$fields$WSTA[i]),sprintf("%6d",as.integer(in_data$fields$FLSA[i])),
              sprintf("%6d",as.integer(in_data$fields$FLOB[i])),sprintf("%6s",in_data$fields$FLDT[i]),
              sprintf("%6d",as.integer(in_data$fields$FLDD[i])),sprintf("%6s",as.integer(in_data$fields$FLDS[i])),
              sprintf("%6d",as.integer(in_data$fields$FLST[i]))," ",sprintf("%-4d",as.integer(in_data$fields$SLTX[i])),
              sprintf("%6d",as.integer(in_data$fields$SLDP[i])),"  ",sprintf("%-10s",in_data$fields$ID_SOIL[i])," ",
              sprintf("%-12s",in_data$fields$FLNAME[i]),"\n", sep=""),file=pf)
    
  }
  
  cat("\n", file = pf)
  
  cat("@L ..........XCRD ...........YCRD .....ELEV .............AREA .SLEN .FLWR .SLAS FLHST FHDUR\n",file=pf)
  
  for (i in 1:nrow(in_data$treatments)) { 
    
    
    cat(paste(sprintf("%2d",as.integer(in_data$fields$L[i]))," ",sprintf("%15.3f",in_data$fields$XCRD[i])," ",
              sprintf("%15.3f",in_data$fields$YCRD[i])," ",sprintf("%9d",as.integer(in_data$fields$ELEV[i]))," ",
              sprintf("%17d",as.integer(in_data$fields$AREA[i]))," ",sprintf("%5d",as.integer(in_data$fields$SLEN[i]))," ",
              sprintf("%5d",as.integer(in_data$fields$FLWR[i]))," ",sprintf("%5d",as.integer(in_data$fields$SLAS[i]))," ",
              sprintf("%5d",as.integer(in_data$fields$FLHST[i]))," ",sprintf("%5d",as.integer(in_data$fields$FHDUR[i])),
              "\n",sep=""),file=pf)
    
    
  }
  
  
  cat("\n",file=pf)
  
  #initial conditions
  cat("*INITIAL CONDITIONS\n",file=pf)
  cat("@C   PCR ICDAT  ICRT  ICND  ICRN  ICRE  ICWD ICRES ICREN ICREP ICRIP ICRID ICNAME\n",file=pf)
  cat(paste(sprintf("%2d",as.integer(in_data$ini_cond_properties$C))," ",sprintf("%5s",in_data$ini_cond_properties$PCR),
            " ",sprintf("%5s",in_data$ini_cond_properties$ICDAT)," ",sprintf("%5d",as.integer(in_data$ini_cond_properties$ICRT)),
            " ",sprintf("%5d",as.integer(in_data$ini_cond_properties$ICND))," ",sprintf("%5d",as.integer(in_data$ini_cond_properties$ICRN)),
            " ",sprintf("%5d",as.integer(in_data$ini_cond_properties$ICRE))," ",sprintf("%5d",as.integer(in_data$ini_cond_properties$ICWD)),
            " ",sprintf("%5d",as.integer(in_data$ini_cond_properties$ICRES))," ",sprintf("%5d",as.integer(in_data$ini_cond_properties$ICREN)),
            " ",sprintf("%5d",as.integer(in_data$ini_cond_properties$ICREP))," ",sprintf("%5d",as.integer(in_data$ini_cond_properties$ICRIP)),
            " ",sprintf("%5d",as.integer(in_data$ini_cond_properties$ICRID))," ",sprintf("%-12s",in_data$ini_cond_properties$ICNAME),
            "\n",sep=""),file=pf)
  cat("@C  ICBL  SH2O  SNH4  SNO3\n",file=pf)
  
  for (i in 1:nrow(in_data$ini_cond_values)) {
    cat(paste(sprintf("%2d",as.integer(in_data$ini_cond_values$C))," ",sprintf("%5.0f",as.integer(in_data$ini_cond_values$ICBL[i])),
              " ",sprintf("%5.0f",as.integer(in_data$ini_cond_values$SH2O[i]))," ",sprintf("%5.0f",as.integer(in_data$ini_cond_values$SNH4[i])),
              " ",sprintf("%5.0f",as.integer(in_data$ini_cond_values$SNO3[i])),"\n",sep=""),file=pf)
  }
  cat("\n",file=pf)
  
  # Initial Conditions
  # if(exists("ini_cond")) {
  # 
  #   cat("*INITIAL CONDITIONS\n", file = pf)
  #   cat("@C   PCR ICDAT  ICRT  ICND  ICRN  ICRE  ICWD ICRES ICREN ICREP ICRIP ICRID ICNAME\n", file = pf)
  #   cat(sprintf("%2d %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %5s %2s", 1, "MZ", -99, 1, -99, 1, 1, -99,  -99, -99, -99, -99, -99, -99), "\n", file = pf)
  # 
  #   cat("@C  ICBL  SH2O  SNH4  SNO3\n", file = pf)
  #   for(i in 1:dim(ini_cond)[1]){
  # 
  #     if(information$system  == "rainfed"){
  #       ## CAmbio en las Condiciones iniciales de Nitrogeno 5 Octubre 2015
  #       #cat(paste(sprintf("%2d %5d %5.2f %5.2f %5.2f", 1, in_conditions[i, 1], in_conditions[i, 2], SNH4[i], SNO3[i])), "\n", file = pf)
  #       cat(paste(sprintf("%2d %5d %5d %5.2f %5.2f", 1, ini_cond[i, 'SLB'], ini_cond[i, 'SDUL'], ini_cond[i, 'SLOC'], ini_cond[i , 'SLOC'])), "\n", file = pf)
  #       
  #     }
  # 
  #     if(information$system  == "irrigation"){
  #       #cat(paste(sprintf("%2d %5d %5.0f %5.2f %5.2f", 1, in_conditions[i, 1], in_conditions[i, 2], SNH4[i], SNO3[i])), "\n", file = pf)
  #       cat(paste(sprintf("%2d %5d %5.2f %5.2f %5.2f", 1, ini_cond[i, 'SLB'], ini_cond[i, 'SDUL'], ini_cond[i, 'SLOC'], ini_cond[i , 'SLOC'])), "\n", file = pf)
  #     }
  # 
  # 
  #   }
  
  
  # }
  
  
  
  cat("\n", file = pf)
  #planting details
  cat("*PLANTING DETAILS\n",file = pf)
  cat("@P PDATE EDATE  PPOP  PPOE  PLME  PLDS  PLRS  PLRD  PLDP  PLWT  PAGE  PENV  PLPH  SPRL                        PLNAME\n",file=pf)
  cat(paste(sprintf("%2d",as.integer(in_data$planting$P))," ",sprintf("%5s",in_data$planting$PDATE),
            " ",sprintf("%5s",in_data$planting$EDATE)," ",sprintf("%5d",as.integer(in_data$planting$PPOP)),
            " ",sprintf("%5d",as.integer(in_data$planting$PPOE))," ",sprintf("%5s",in_data$planting$PLME),
            " ",sprintf("%5s",in_data$planting$PLDS)," ",sprintf("%5d",as.integer(in_data$planting$PLRS)),
            " ",sprintf("%5d",as.integer(in_data$planting$PLRD))," ",sprintf("%5d",as.integer(in_data$planting$PLDP)),
            " ",sprintf("%5d",as.integer(in_data$planting$PLWT))," ",sprintf("%5d",as.integer(in_data$planting$PAGE)),
            " ",sprintf("%5d",as.integer(in_data$planting$PENV))," ",sprintf("%5d",as.integer(in_data$planting$PLPH)),
            " ",sprintf("%5d",as.integer(in_data$planting$SPRL))," ",sprintf("%29s",in_data$planting$PLNAME),
            "\n", sep = ""), file = pf)
  cat("\n", file = pf)
  
  
  cat("*FERTILIZERS (INORGANIC)\n", file = pf)
  cat("@F FDATE  FMCD  FACD  FDEP  FAMN  FAMP  FAMK  FAMC  FAMO  FOCD FERNAME                       \n", file = pf)
  
  for(i in 1:dim(in_data$fertilizer)[1]){
    
    cat(paste(sprintf("%2d %5i %5s %5i %5i %5.2f %5.2f %5.2f %5i %5i %5i %5-i", 1, in_data$fertilizer$FDATE[i], in_data$fertilizer$FMCD[i],
                      in_data$fertilizer$FACD[i], in_data$fertilizer$FDEP[i], in_data$fertilizer$FAMN[i], in_data$fertilizer$FAMP[i], 
                      in_data$fertilizer$FAMK[i], in_data$fertilizer$FAMC[i], in_data$fertilizer$FAMO[i], 
                      in_data$fertilizer$FOCD[i], in_data$fertilizer$FERNAME[i]), '\n'), file = pf)
    
  }
  
  
  cat("\n", file = pf)
  
  # ## Details Fertilization
  # cat("*FERTILIZERS (INORGANIC)\n", file = pf)
  # cat("@F FDATE  FMCD  FACD  FDEP  FAMN  FAMP  FAMK  FAMC  FAMO  FOCD FERNAME                       \n", file = pf)
  # for(i in 1:dim(information$nitrogen_aplication$amount)[2]){
  #   if(!is.na(information$nitrogen_aplication$amount[, i])) {
  #     
  #     
  #     if(i == 1){
  #       
  #       cat(sprintf("%2s %5s %4s %5s %5i %5.1f %5i %5i %5i %5i %5i %1i", 1, information$nitrogen_aplication$day_app[, i], "FE005", "AP002", 
  #                   4, information$nitrogen_aplication$amount[, i], 0, -99, -99, -99, -99, -99), "\n", file = pf)
  #       
  #     } else{
  #       cat(sprintf("%2s %5s %4s %5s %5i %5.1f %5i %5i %5i %5i %5i %1i", 1, information$nitrogen_aplication$day_app[, i], "FE005", "AP002", 
  #                   0, information$nitrogen_aplication$amount[, i], 0, -99, -99, -99, -99, -99), "\n", file = pf)
  #     }
  #     
  #   }
  #   
  # }
  # cat("\n", file = pf)
  
  #simulation controls
  cat("*SIMULATION CONTROLS\n", file = pf)
  cat("@N GENERAL     NYERS NREPS START SDATE RSEED SNAME.................... SMODEL\n", file = pf)
  cat(paste(sprintf("%2d",as.integer(in_data$sim_ctrl$N))," ",sprintf("%-11s",in_data$sim_ctrl$GENERAL),
            " ",sprintf("%5d",as.integer(in_data$sim_ctrl$NYERS))," ",sprintf("%5d",as.integer(in_data$sim_ctrl$NREPS)),
            " ",sprintf("%5s",in_data$sim_ctrl$START)," ",sprintf("%5s",in_data$sim_ctrl$SDATE),
            " ",sprintf("%5d",as.integer(in_data$sim_ctrl$RSEED))," ",sprintf("%-25s",in_data$sim_ctrl$SNAME),
            " ",sprintf("%-6s",in_data$sim_ctrl$SMODEL),"\n",sep=""),file=pf)
  cat("@N OPTIONS     WATER NITRO SYMBI PHOSP POTAS DISES  CHEM  TILL   CO2\n",file=pf)
  cat(paste(sprintf("%2d",as.integer(in_data$sim_ctrl$N))," ",sprintf("%-11s",in_data$sim_ctrl$OPTIONS),
            " ",sprintf("%5s",in_data$sim_ctrl$WATER)," ",sprintf("%5s",in_data$sim_ctrl$NITRO),
            " ",sprintf("%5s",in_data$sim_ctrl$SYMBI)," ",sprintf("%5s",in_data$sim_ctrl$PHOSP),
            " ",sprintf("%5s",in_data$sim_ctrl$POTAS)," ",sprintf("%5s",in_data$sim_ctrl$DISES),
            " ",sprintf("%5s",in_data$sim_ctrl$CHEM)," ",sprintf("%5s",in_data$sim_ctrl$TILL),
            " ",sprintf("%5s",in_data$sim_ctrl$CO2),"\n",sep=""),file=pf)
  cat("@N METHODS     WTHER INCON LIGHT EVAPO INFIL PHOTO HYDRO NSWIT MESOM MESEV MESOL\n",file=pf)
  cat(paste(sprintf("%2d",as.integer(in_data$sim_ctrl$N))," ",sprintf("%-11s",in_data$sim_ctrl$METHODS),
            " ",sprintf("%5s",in_data$sim_ctrl$WTHER)," ",sprintf("%5s",in_data$sim_ctrl$INCON),
            " ",sprintf("%5s",in_data$sim_ctrl$LIGHT)," ",sprintf("%5s",in_data$sim_ctrl$EVAPO),
            " ",sprintf("%5s",in_data$sim_ctrl$INFIL)," ",sprintf("%5s",in_data$sim_ctrl$PHOTO),
            " ",sprintf("%5s",in_data$sim_ctrl$HYDRO)," ",sprintf("%5d",as.integer(in_data$sim_ctrl$NSWIT)),
            " ",sprintf("%5s",in_data$sim_ctrl$MESOM)," ",sprintf("%5s",in_data$sim_ctrl$MESEV),
            " ",sprintf("%5d",as.integer(in_data$sim_ctrl$MESOL)),"\n",sep=""),file=pf)
  cat("@N MANAGEMENT  PLANT IRRIG FERTI RESID HARVS\n",file=pf)
  cat(paste(sprintf("%2d",as.integer(in_data$sim_ctrl$N))," ",sprintf("%-11s",in_data$sim_ctrl$MANAGEMENT),
            " ",sprintf("%5s",in_data$sim_ctrl$PLANT)," ",sprintf("%5s",in_data$sim_ctrl$IRRIG),
            " ",sprintf("%5s",in_data$sim_ctrl$FERTI)," ",sprintf("%5s",in_data$sim_ctrl$RESID),
            " ",sprintf("%5s",in_data$sim_ctrl$HARVS),"\n",sep=""),file=pf)
  cat("@N OUTPUTS     FNAME OVVEW SUMRY FROPT GROUT CAOUT WAOUT NIOUT MIOUT DIOUT VBOSE CHOUT OPOUT\n",file=pf)
  cat(paste(sprintf("%2d",as.integer(in_data$sim_ctrl$N))," ",sprintf("%-11s",in_data$sim_ctrl$OUTPUTS),
            " ",sprintf("%5s",in_data$sim_ctrl$FNAME)," ",sprintf("%5s",in_data$sim_ctrl$OVVEW),
            " ",sprintf("%5s",in_data$sim_ctrl$SUMRY)," ",sprintf("%5s",in_data$sim_ctrl$FROPT),
            " ",sprintf("%5s",in_data$sim_ctrl$GROUT)," ",sprintf("%5s",in_data$sim_ctrl$CAOUT),
            " ",sprintf("%5s",in_data$sim_ctrl$WAOUT)," ",sprintf("%5s",in_data$sim_ctrl$NIOUT),
            " ",sprintf("%5s",in_data$sim_ctrl$MIOUT)," ",sprintf("%5s",in_data$sim_ctrl$DIOUT),
            " ",sprintf("%5s",in_data$sim_ctrl$VBOSE)," ",sprintf("%5s",in_data$sim_ctrl$CHOUT),
            " ",sprintf("%5s",in_data$sim_ctrl$OPOUT),"\n",sep=""),file=pf)
  cat("\n", file = pf)
  
  #automatic management
  cat("@  AUTOMATIC MANAGEMENT\n", file = pf)
  cat("@N PLANTING    PFRST PLAST PH2OL PH2OU PH2OD PSTMX PSTMN\n", file = pf)
  cat(paste(sprintf("%2d",as.integer(in_data$auto_mgmt$N))," ",sprintf("%-11s",in_data$auto_mgmt$PLANTING),
            " ",sprintf("%5s",in_data$auto_mgmt$PFRST)," ",sprintf("%5s",in_data$auto_mgmt$PLAST),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$PH2OL))," ",sprintf("%5d",as.integer(in_data$auto_mgmt$PH2OU)),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$PH2OD))," ",sprintf("%5d",as.integer(in_data$auto_mgmt$PSTMX)),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$PSTMN)),"\n",sep=""),file=pf)
  cat("@N IRRIGATION  IMDEP ITHRL ITHRU IROFF IMETH IRAMT IREFF\n",file=pf)
  cat(paste(sprintf("%2d",as.integer(in_data$auto_mgmt$N))," ",sprintf("%-11s",in_data$auto_mgmt$IRRIGATION),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$IMDEP))," ",sprintf("%5d",as.integer(in_data$auto_mgmt$ITHRL)),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$ITHRU))," ",sprintf("%5s",in_data$auto_mgmt$IROFF),
            " ",sprintf("%5s",in_data$auto_mgmt$IMETH)," ",sprintf("%5d",as.integer(in_data$auto_mgmt$IRAMT)),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$IREFF)),"\n",sep=""),file=pf)
  cat("@N NITROGEN    NMDEP NMTHR NAMNT NCODE NAOFF\n",file=pf)
  cat(paste(sprintf("%2d",as.integer(in_data$auto_mgmt$N))," ",sprintf("%-11s",in_data$auto_mgmt$NITROGEN),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$NMDEP))," ",sprintf("%5d",as.integer(in_data$auto_mgmt$NMTHR)),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$NAMNT))," ",sprintf("%5s",in_data$auto_mgmt$NCODE),
            " ",sprintf("%5s",in_data$auto_mgmt$NAOFF),"\n",sep=""),file=pf)
  cat("@N RESIDUES    RIPCN RTIME RIDEP\n",file=pf)
  cat(paste(sprintf("%2d",as.integer(in_data$auto_mgmt$N))," ",sprintf("%-11s",in_data$auto_mgmt$RESIDUES),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$RIPCN))," ",sprintf("%5d",as.integer(in_data$auto_mgmt$RTIME)),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$RIDEP)),"\n",sep=""),file=pf)
  cat("@N HARVEST     HFRST HLAST HPCNP HPCNR\n",file=pf)
  cat(paste(sprintf("%2d",as.integer(in_data$auto_mgmt$N))," ",sprintf("%-11s",in_data$auto_mgmt$HARVEST),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$HFRST))," ",sprintf("%5d",as.integer(in_data$auto_mgmt$HLAST)),
            " ",sprintf("%5d",as.integer(in_data$auto_mgmt$HPCNP))," ",sprintf("%5d",as.integer(in_data$auto_mgmt$HPCNR)),
            "\n",sep=""),file=pf)
  
  #close file
  close(pf)
  
  #output
  return(out_file)
}





## Change the next lines for new initial conditions
## make parameter for condiciones iniciales upper limit or lower limit (since looks wilt point)
## add C function tu use multiple opciones is required during to run DSSAT
## add read soil information from (file SOIL) to determine de upper limit for initial conditions
## test
## out_file <- "./JBID.RIX"
# overwrite <- F

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
  pf <- file(out_file,open="w")
}

# close(pf)


for (i in 1:nrow(in_data$ini_cond_values)) {
  
  # cat(paste(sprintf("%2d",as.integer(in_data$ini_cond_values$C)), " ",sprintf("%5.0f",as.integer(in_data$ini_cond_values$ICBL[i])),
  #           " ",sprintf("%5.0f",as.integer(in_data$ini_cond_values$SH2O[i]))," ",sprintf("%5.0f",as.integer(in_data$ini_cond_values$SNH4[i])),
  #           " ",sprintf("%5.0f",as.integer(in_data$ini_cond_values$SNO3[i])),"\n",sep=""),file=pf)
  # 
  # 
  if(information$wilting_point  == "lower_limit"){
    
    cat(paste(sprintf("%2d %5d %5d %5.2f %5.2f", 1, in_data$ini_cond_values[i, 'ICBL'], in_data$ini_cond_values[i, 'SH20'],
                      in_data$ini_cond_values[i, 'SNH4'], in_data$ini_cond_values[i , 'SNo3'])), "\n", file = pf)
    
  }
  
  if(information$wilting_point  == "upper_limit"){
    
    ## is necessary to read the information about SOIL file to identify upper limit so it is SDUL var in SOIL 
    
  }
  
  
}



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

# proof generate the connection between R and the file pf into de function make_archive
# proof <- make_archive(out_file, overwrite = F,  encoding = "UTF-8")

# cat('Whatever', file = proof)
# close(proof)

## this function needs a name of experiment, is a header for de x-file
## make general stuff

make_details <- function(name_exp, information){
  
  
  # General stuff
  
  cat(paste0(information$exp_details, "\n"), file = name_exp)
  cat("\n",file = name_exp)
  cat("*GENERAL\n@PEOPLE\n", file = name_exp)
  cat(paste(sprintf("%-12s", as.character(in_data$general$PEOPLE)), "\n", sep = ""), file = name_exp)
  cat("@ADDRESS\n", file = name_exp)
  cat(paste(sprintf("%-12s", as.character(in_data$general$ADDRESS)), "\n", sep = ""), file = name_exp)
  cat("@SITE\n", file = name_exp)
  cat(paste(sprintf("%-12s", as.character(in_data$general$SITE)), "\n", sep = ""), file = name_exp)
  
}

# make_details(proof, information)
# close(proof)

