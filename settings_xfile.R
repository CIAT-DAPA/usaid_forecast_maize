## Change the next lines for new initial conditions
## make parameter for condiciones iniciales upper limit or lower limit (since looks wilt point)
## add C function tu use multiple opciones is required during to run DSSAT
## add read soil information from (file SOIL) to determine de upper limit for initial conditions
## test
## out_file <- "./JBID.RIX"
# overwrite <- F


# Proof make_details

make_details <- function(...){
  
  
  general <- list(DETAILS = '*EXP.DETAILS: CALB1501MZ Calibracion Buga Valle 2015B',
                  PEOPLE = "Leonardo Ordoñez and Jeison Mesa",
                  ADDRESS = "CIAT",
                  SITE = "CALI")
  
  return(general)
  
}


# make_details()
