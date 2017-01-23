## 
## It's necessary to has the functions with pipeline and without it


# library(dplyr)


## Conexion to write experimental file, maybe is better to write a function to write all parameters



proof <- make_archive(out_file, overwrite = F,  encoding = "UTF-8") 

write_details(proof, make_details())
write_treatments(proof, make_treatments(IC, MI, MF, MH))
write_cultivars(proof, make_cultivars(CR, INGENO, CNAME))
write_fields(proof, make_fields(WSTA, ID_SOIL))
# Las corridas serán entonces de acuerdo al potencial en rendimiento que puedan alcanzar las plantas
# write_IC(proof, make_IC(ICBL, SH20, SNH4, SNO3)) # posiblemente este campo no se necesite durante la corrida de los pronosticos
# write_MF(proof, make_MF(input_fertilizer))         # sin requerimientos por fertilizantes dejarlo con potencial
write_pDetails(proof, make_pDetails(input_pDetails))     
write__sControls(proof, make_sControls(input_sControls))
write_Amgmt(proof, make_Amgmt(PFRST, PLAST))


##  add function to close write


close(proof)


make_archive(out_file, overwrite = F,  encoding = "UTF-8") %>%
  write_details(make_details()) %>%
  close()





























## Run make X-file
# Is necessary to write the  x-file automatically then the next lines make a routine to call the function make_xfile





Xfile <- function(information, pixel, initial) {
  
  
  
  # Cultivars
  
  INGENO <- information$INGENO 
  CR <- information$CR
  CNAME <- information$CNAME
  
  ## Fields
  
  WSTA <- information$WSTA
  ID_SOIL <- information$ID_SOIL
  SMODEL <- paste(information$smodel)
  
  ## Initial Conditions Must be a data frame
  
  
  ICBL <- information$ICBL
  SH20 <- information$SH20
  SNH4 <- information$SNH4
  SNo3 <- information$SNO3
  
  # Planting Details
  
  PDATE <- information$PDATE   
  PLANT <- information$plant
  ## Maybe to add a function recognice when SDATE = 0 so this function should a new clima datasets for repet the same year of 
  ## Simulation only for start simulation another year (the last of the first year)
  SDATE <- information$SDATE
  PPOP <- information$PPOP
  PPOE <- information$PPOE
  PLME <- paste(information$PLME)
  PLDS <- paste(information$PLDS)
  PLRD <- information$PLRD 
  PLDP <- information$PLDP 
  
  
  ## Date of application of irrigation
  
  IRRIG <- information$IRRIG
  IROP <- information$IROP
  IDATE <- information$IDATE
  IRVAL <- information$IRVAL
  
  
  
  ## Fertilizers
  
  
  FDATE <- information$FDATE
  FMCD <- information$FMCD
  FACD = information$FACD
  FDEP = information$FDEP
  FAMN = information$FAMN
  FAMP = information$FAMP
  FAMK = information$FAMK
  FAMC = information$FAMC
  FAMO = information$FAMO
  FOCD = information$FOCD
  FERNAME = information$FERNAME
  FERTI = information$FERTI
  
  ### AUTOMATIC MANAGEMENT
  
  PFRST <-  information$pfrst
  PLAST <- information$plast
  
  
  # C = 1  ## What is C??
  
  # PLANTING = A
  
  IC <- information$IC 
  NYERS <- information$NYERS
  NITRO <- information$NITRO 
  WATER <- information$WATER 
  
  
  
  ## Defining the Experiment
  in_data <- list()
  # IC <- IC
  
  ## General data of the Experiment
  
  in_data$general <- list(PEOPLE = "Leonardo Ordoñez and Jeison Mesa", ADDRESS = "CIAT", SITE = "CALI")
  
  
  ## Definition simulate treatment
  in_data$treatments <- data.frame(N = 1, R = 1, O = 0, C = 0, TNAME = "USAID", CU = 1, FL = 1, SA = 0, IC = IC, MP = 1,
                                   MI = 0, MF = 1, MR = 0, MC = 0, MT = 0, ME = 0, MH = 0, SM = 1)
  
  ## Definition simulate cultivar
  
  in_data$cultivars <- data.frame(C = 1 , CR, INGENO, CNAME)
  
  ## Field
  
  in_data$fields <- data.frame(L = 1, ID_FIELD = "USAID", WSTA, FLSA = -99, FLOB = -99, FLDT = "DR000",
                               FLDD = -99, FLDS = -99, FLST = -99, SLTX = -99, SLDP = -99, ID_SOIL,
                               FLNAME = "FIELD01", XCRD = -99, YCRD = -99, ELEV = -99, AREA = -99, SLEN=-99,
                               FLWR = -99, SLAS = -99, FLHST = -99, FHDUR=-99)
  
  ## initial conditions of the experiment
  ## Aqui investigar acerca de ICDAT
  ## Segun el manual Initial Conditions Measurement date, year + days
  # in_data$ini_cond_properties <- data.frame(C = 1, PCR = information$CR, ICDAT = "50001", ICRT = -99, ICND = -99, ICRN = -99, ICRE = -99,
  # ICWD = -99, ICRES = -99, ICREN = -99, ICREP = -99, ICRIP = -99, ICRID = -99,
  # ICNAME = "inicond1")
  
  #in_data$ini_cond_profile <- data.frame(C=rep(1,5),ICBL=rep(-99,5),SH2O=rep(-99,5),SNH4=rep(-99,5),
  #                                       SNO3=rep(-99,5))
  
  
  ## Initial Conditions
  
  in_data$ini_cond_field <- data.frame(C = 1, PCR = information$CR, ICDAT = PDATE, ICRT = -99, ICND = -99, ICRN = -99, ICRE = -99,
                                       ICWD = -99, ICRES = -99, ICREN = -99, ICREP = -99, ICRIP = -99, ICRID = -99,
                                       ICNAME = -99)
  
  in_data$ini_cond_values <- data.frame(C= rep(1,length(SNH4)),ICBL, SH20,SNH4,
                                        SNo3)
  
  ## Fetilizer Details
  # print('Here')
  in_data$fertilizer <- data.frame(F = 1, FDATE, FMCD, FACD, FDEP, FAMN, FAMP, FAMK,
                                   FAMC, FAMO, FOCD, FERNAME)
  
  ## Planting Details
  in_data$planting <- data.frame( P = 1, PDATE, EDATE = -99, PPOP, PPOE, PLME, 
                                  PLDS, PLRS = 80, PLRD, PLDP,
                                  PLWT = -99, PAGE = -99, PENV = -99, PLPH = -99, SPRL = -99)
  
  
  
  ## Simulation Control 
  in_data$sim_ctrl <- data.frame(N = 1, GENERAL = "GE", NYERS, NREPS = 1, START = "S", SDATE, 
                                 RSEED = 2150, SNAME = "simctr1", SMODEL, 
                                 OPTIONS = "OP", WATER, NITRO, SYMBI = "N",
                                 PHOSP = "N", POTAS = "N", DISES = "N", CHEM = "N", TILL = "N", 
                                 CO2 = "M", METHODS = "ME", WTHER = "M", INCON = "M", LIGHT = "E", 
                                 EVAPO = "R", INFIL = "S", PHOTO = "C", HYDRO = "R",
                                 NSWIT = 1, MESOM = "G", MESEV = "S", MESOL =2, MANAGEMENT = "MA", 
                                 PLANT, IRRIG,
                                 FERTI, RESID = "R", HARVS = "M", OUTPUTS = "OU", FNAME = "N", 
                                 OVVEW = "Y", SUMRY = "Y", FROPT = 1, GROUT = "Y", CAOUT = "Y", 
                                 WAOUT = "Y", NIOUT = "Y", MIOUT = "Y",
                                 DIOUT = "Y", VBOSE = "Y", CHOUT = "Y", OPOUT = "Y")
  
  ## AUTOMATIC MANAGEMENT 
  
  in_data$auto_mgmt <- data.frame(N = 1, PLANTING = 'PL', PFRST, PLAST, PH2OL = 50, PH2OU = 100,
                                  PH2OD = 30, PSTMX = 40, PSTMN = 10, IRRIGATION = "IR", IMDEP =30, ITHRL = 50, 
                                  ITHRU =100, IROFF = "GS000", IMETH = "IR001", IRAMT = 10, IREFF = 1,
                                  NITROGEN = "NI", NMDEP = 30, NMTHR = 50, NAMNT = 25, NCODE = "FE001",
                                  NAOFF = "GS000", RESIDUES = "RE", RIPCN = 100, RTIME = 1, RIDEP = 20, 
                                  HARVEST = "HA", HFRST = 0, HLAST = 00001, HPCNP = 100, HPCNR = 0)
  
  
  
  
  
}