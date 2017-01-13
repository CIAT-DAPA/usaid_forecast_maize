## Make a R-markdown for a summary that show how to write a x-file with some parameters (Most used parameters in another projects)
## Change the next lines for new initial conditions
## make parameter for condiciones iniciales upper limit or lower limit (since looks wilt point)
## add C function tu use multiple opciones is required during to run DSSAT
## add read soil information from (file SOIL) to determine de upper limit for initial conditions
## test
## out_file <- "./JBID.RIX"
# overwrite <- F


# Proof make_details

# Parameters
# details <- '*EXP.DETAILS: CALB1501MZ Calibracion Buga Valle 2015B'
# people <- "Leonardo Ordoñez and Jeison Mesa"
# The others parameters its not necessary to have outside the function

make_details <- function(DETAILS, PEOPLE){
  
  
  general <- list(DETAILS = details,
                  PEOPLE = people,
                  addres = "CIAT",
                  site = "CALI")
  
  return(general)
  
}


# make_details(details, people)



# Parameters
# For now make_treatments make a configuration for one combination to run into the experimental

# IC <- 1         # 1 if its necesarry run the experimental with initial conditions, 0 if its not necessary to run
#                   the experimental with initial conditions

# MI <- 0         # 1 turn on field for irrigation level, 0 turn off field for irrigation level
# MF <- 1         # 1 turn on field for fertilizier level, 0 turn off field for fertilizier level
# MH <- 0         # 1 turn on field for harvest level, 0 turn off field for harvest level


make_treatments <- function(IC, MI, MF, MH){

  # Treatments
  
  # *TREATMENTS                        -------------FACTOR LEVELS------------
  # @N R O C TNAME.................... CU FL SA IC MP MI MF MR MC MT ME MH SM
  #  1 1 0 0 P1                         1  1  0  1  1  0  1  0  0  0  0  1  1
  
  treatments <- data.frame(N = 1, R = 1, O = 0, C = 0, TNAME = "USAID",
                           CU = 1, FL = 1, SA = 0, IC, MP = 1,
                           MI, MF, MR = 0, MC = 0, MT = 0, ME = 0, MH, SM = 1)
  
  
  return(treatments)
  
}

# make_treatments(IC, MI, MF, MH)

# Parameters
# CR <- 'MZ'    # Crop Code, you need to search this parameter for de manual DSSAT (its different by crop)
# INGENO <- 'CI0027' # Cultivar indentifier, this is the code for cultivar to run depend of crop
# CNAME <- 'PIO 30F35HRB_'  # Whatever code to identify the cultivar ran, maybe no too long string

make_cultivars <- function(CR, INGENO, CNAME){
  
  
  cultivars <- data.frame(C = 1 , CR, INGENO, CNAME)
  
  return(cultivars)
  
}

# make_cultivars(CR, INGENO, CNAME)


# Parameters
# WSTA <- 'CCBR1502' # Weather Station Code, its the same code to using in WTH file
# ID_SOIL <- 'CCBuga0001' # Id soil to using in the SOIL.SOl



make_fields <- function(WSTA, ID_SOIL){
  
  
  # *FIELDS
  # @L ID_FIELD WSTA....  FLSA  FLOB  FLDT  FLDD  FLDS  FLST SLTX  SLDP  ID_SOIL    FLNAME
  #  1 -99      CCBR1502   -99   -99 DR000   -99   -99     0 SL      30  CCBuga0001 Calibracion
  # 
  fields <- data.frame(L = 1, ID_FIELD = "USAID", WSTA, FLSA = -99, FLOB = -99, FLDT = "DR000",
                               FLDD = -99, FLDS = -99, FLST = -99, SLTX = -99, SLDP = -99, ID_SOIL,
                               FLNAME = "FIELD01", XCRD = -99, YCRD = -99, ELEV = -99, AREA = -99, SLEN=-99,
                               FLWR = -99, SLAS = -99, FLHST = -99, FHDUR=-99)
  

  return(fields)
  
}

# make_fields(WSTA, ID_SOIL) 



# Parameters


# Initial Conditions
# 1 ) you are going to use initial conditions for default (soil characteristics) (see code for running DSSAT on BID project)
# 2 ) you need to use lower limit or upper limit (para la siembra, esto mas que todo se utiliza cuando se desea sembrar automaticamente)
# 3 ) you are goint to give the information to make Initial Conditions
# Por ahora se utilizará condiciones iniciales dadas por el usuario

## data frame to Initial Conditions
# ICDAT the same from PDATE (planting date)
# *INITIAL CONDITIONS
# @C   PCR ICDAT  ICRT  ICND  ICRN  ICRE  ICWD ICRES ICREN ICREP ICRIP ICRID ICNAME
# 1    MZ 80085   -99     0     1     1   -99     0     0     0   100    15 -99


# ICBL <- c(25, 45, 95)
# SH20 <- -99
# SNH4 <- c(4.2, 4.4, 4.5)    # estas variables se pueden investigar cuales utilizar cuando no se tiene condiciones iniciales
# SNO3 <- c(11.9, 12.4, 7.6)  # estas variables se pueden investigar cuales utilizar cuando no se tiene condiciones iniciales
# ICDAT <- -99 #  for now

make_IC <- function(ICBL, SH20, SNH4, SNO3){
  
  IC_field <- data.frame(C = 1, PCR = 'MZ', ICDAT = -99, ICRT = -99, ICND = -99, ICRN = -99, ICRE = -99,
                                       ICWD = -99, ICRES = -99, ICREN = -99, ICREP = -99, ICRIP = -99, ICRID = -99,
                                       ICNAME = -99)
  
  IC_values <- data.frame(C= rep(1,length(SNH4)),ICBL, SH20,SNH4,
                          SNO3)
  

  
  initial_conditions <- list(field = IC_field, values = IC_values)
  
  return(initial_conditions)
  
}


# make_IC(ICBL, SH20, SNH4, SNO3)

















