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
  
  
  general <- list(details,
                  people,
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



