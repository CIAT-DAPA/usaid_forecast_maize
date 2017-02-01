## es necesario que esta funcion escriba los parametros dado la localidad a generar el pronostico agroclimatico
# funcion que va generar los parametros por region 

# El parametro region genera la informacion necesaria para ajustar los parametros de entrada para DSSAT v 4.6 necesarios a correr por
# las regiones del proyecto con USAID

make_xfile_region("LaUnion")

make_xfile_region <- function(region){
  
  
  if(region == "LaUnion"){
    
    
    ## Parameters necessary to write experimental file
    
    # out_file <- "./JBID.MZX"
    
    out_file <- "./proof.MZX"
    overwrite <- F
    details <- '*USAID-CIAT project Agroclimatic forecasts'
    people <- "Leonardo Ordoñez and Jeison Mesa"
    
    IC <- 0  # Inital conditions
    MI <- 0  # input if you are going to use a irrigation, 1 = TRUE, 0 = FALSe 
    MF <- 0 # Fertilization field, 1 = TRUE, 0 = FALSE
    MH <- 0 # its necessary to include harvest date when you turn on this parameter
    
    
    CR <- 'MZ'    # Crop Code, you need to search this parameter for de manual DSSAT (its different by crop)
    INGENO <- 'CI0027' # Cultivar indentifier, this is the code for cultivar to run depend of crop
    CNAME <- 'PIO 30F35HRB_'  # Whatever code to identify the cultivar ran, maybe no too long string
    
    WSTA <- 'CCCR8000' # Weather Station Code, its the same code to using in WTH file
    ID_SOIL <- 'CCBuga0001' # Id soil to using in the SOIL.SOl
    
    
    ICBL <- c(25, 45, 95)
    SH20 <- -99
    SNH4 <- c(4.2, 4.4, 4.5)    # estas variables se pueden investigar cuales utilizar cuando no se tiene condiciones iniciales
    SNO3 <- c(11.9, 12.4, 7.6)  # estas variables se pueden investigar cuales utilizar cuando no se tiene condiciones iniciales
    ICDAT <- -99 #  for now
    
    input_fertilizer <- list()
    input_fertilizer$FDATE = c(21, 21, 35, 35, 58)  ## Dias de la aplicacion +
    input_fertilizer$FMCD = c('FE006', 'FE016', 'FE005', 'FE016', 'FE005') ## Investigar acerca de este parametro
    input_fertilizer$FACD = 'AP002' ## Investigar acerca de este parametro
    input_fertilizer$FDEP = 4       ## Profundidad de la aplicacion del nitrogeno
    input_fertilizer$FAMN = c(33.3, 0, 63.9, 0, 63.9)
    input_fertilizer$FAMP = c(29.1, 0, 0, 0, 0) ## Investigar mas acerca de este parametro
    input_fertilizer$FAMK = c(0, 36, 0, 39.2, 0)
    input_fertilizer$FAMC = 0
    input_fertilizer$FAMO = 0
    input_fertilizer$FOCD = 0
    input_fertilizer$FERNAME = -99
    input_fertilizer$FERTI = 'D' ## D = dias despues de la siembra, es necesario actualizar con las otras opciones que tiene este parametro
    
    
    
    ## doing a comment that explain all parameters
    input_pDetails <- list()
    input_pDetails$PDATE <- 80092 # Planting date
    input_pDetails$SDATE <- pmax(input_pDetails$PDATE  - 20, 0)   ## Starting simulation. 20 days before planting date
    input_pDetails$plant <- 'R'  # R = planting on reporting date
    ## Remember Simulation date starts 20 days before planting date
    input_pDetails$EDATE <- -99
    input_pDetails$PPOP <- 6.25
    input_pDetails$PPOE <- 6.25
    input_pDetails$PLME <- 'S'
    input_pDetails$PLDS <- 'R'
    input_pDetails$PLRS <- 80
    input_pDetails$PLRD <- 90
    input_pDetails$PLDP <- 4
    ## Variables como PLWT, PAGE, PENV, PLPH, SPRL con -99
    
    input_sControls <- list()
    input_sControls$NYERS <- 1 ## Years for simulation
    input_sControls$SMODEL <- 'MZCER046' # model to use
    input_sControls$WATER <- 'N'   ## Y = Utiliza balance Hidrico, N = No utiliza balance hidrico
    input_sControls$NITRO <-  'N'  ## Y = utiliza balance nitrogeno, N =  no utiliza balance nitrogeno
    input_sControls$PLANT <- 'R'  # R = planting on reporting date ## Add the other options
    input_sControls$IRRIG <- 'N'  ##  R =  on reporting date, A automatically irragated, N Nothing, add the other options
    input_sControls$FERTI = 'N' ## add more options
    input_sControls$SDATE <- pmax(input_pDetails$PDATE - 20, 0)

    
    PFRST <- -99
    PLAST <- -99
    
    proof <- make_archive(out_file, overwrite = F,  encoding = "UTF-8") 
    
    write_details(proof, make_details(details, people))
    write_treatments(proof, make_treatments(IC, MI, MF, MH))
    write_cultivars(proof, make_cultivars(CR, INGENO, CNAME))
    write_fields(proof, make_fields(WSTA, ID_SOIL))
    # Las corridas serán entonces de acuerdo al potencial en rendimiento que puedan alcanzar las plantas
    # write_IC(proof, make_IC(ICBL, SH20, SNH4, SNO3)) # posiblemente este campo no se necesite durante la corrida de los pronosticos
    # write_MF(proof, make_MF(input_fertilizer))         # sin requerimientos por fertilizantes dejarlo con potencial
    write_pDetails(proof, make_pDetails(input_pDetails))     
    write__sControls(proof, make_sControls(input_sControls))
    write_Amgmt(proof, make_Amgmt(PFRST, PLAST))
    close(proof)
    
    
  }
  
}














args <- alist(a = 1, b = 2)
body <- quote(a + b)

make_function1 <- function(args, body, env = parent.frame()) {
  args <- as.pairlist(args)
  eval(call("function", args, body), env)
}

make_function2 <- function(args, body, env = parent.frame()) {
  f <- function() {
    
    NYERS <- 20 ## Years for simulation
    SMODEL <- 'MZCER045' # model to use
    WATER <- 'N'   ## Y = Utiliza balance Hidrico, N = No utiliza balance hidrico
    NITRO <-  'N'  ## Y = utiliza balance nitrogeno, N =  no utiliza balance nitrogeno
    PLANT <- 'R'  # R = planting on reporting date ## Add the other options
    IRRIG <- 'N'  ##  on reporting date, A automatically irragated, N Nothing, add the other options
    FERTI = 'N' ## add more options
    # SDATE <- pmax(input_pDetails$PDATE - 20, 0)
  }
  
  formals(f) <- args
  body(f) <- body
  environment(f) <- env
  return(f)

  
}



make_function3 <- function(args, body, env = parent.frame()) {
  as.function(c(args, body), env)
  return()
  
}

make_function2(args, body)
function(a = 1, b = 2) a + b


myf <- function(x) {
  innerf <- function(x) assign("Global.res", x^2, envir = .GlobalEnv)
  innerf(x+1)
}

myf(3)
Global.res




























get_test_var <- function(x){
  return(x)
}



add_function_to_envir <- function(my_function_name, to_envir) {
  
  ##  my_function_name <- get_test_var 
  #   to_envir <- environment()
  script_text <- capture.output(eval(parse(text = my_function_name)))
  script_text[1] <- paste0(my_function_name, " <- ", script_text[1])
  eval(parse(text = script_text), envir = to_envir)
}

some_function3 <- function(){
  test_var <- "col"
  add_function_to_envir("get_test_var", environment()) 
  
  
  return(get_test_var(test_var)) 
}



p <- some_function3() 


f <- function(abc = 1, def = 2, ghi = 3) {
  list(sys = sys.call(), match = match.call())
}
f(d = 2, 2)



find_assign2 <- function(x) {
  if (is.atomic(x) || is.name(x)) {
    character()
  } else if (is.call(x)) {
    if (identical(x[[1]], quote(`<-`))) {
      as.character(x[[2]])
    } else {
      unlist(lapply(x, find_assign2))
    }
  } else if (is.pairlist(x)) {
    unlist(lapply(x, find_assign2))
  } else {
    stop("Don't know how to handle type ", typeof(x), 
         call. = FALSE)
  }
}



find_assign2(quote({
  a <- 1
  b <- 2
  a <- 3
}))


f2 <- function(x = z) {
  z <- 100
  x
}
f2()


g <- function(x) {
  y <- 2
  UseMethod("g")
}
g.numeric <- function(x) y
g()
g(10)
