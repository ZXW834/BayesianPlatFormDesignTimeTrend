## code to prepare `dataforvignette` dataset goes here

load("data-raw/notrend_screening600_s5_fourarm04_ARratiothall_earlystop.RData")
dataloginformd=cutoff.information$dataloginformd
recommandloginformd=cutoff.information$recommandloginformd
predictedtpIEinformd=cutoff.information$predictedtpIEinformd


load("data-raw/TABLEEARLYcstagenullARTHALL.RData")
OPC_null = OPC
load("data-raw/TABLEEARLYcstagealtARTHALL.RData")
OPC_alt = OPC

load("data-raw/TABLEOPC_Trial.simulationforreadme.RData")
OPC_Trial.simulation=OPC_Trial.simulation

load("data-raw/GPdata.RData")
optimdata_sym=optimdata

load("data-raw/GPdatafourarmEarlyPocock_asy.RData")
optimdata_asy=c(GP.res,ESS=list(ESS),testeddata=list(dnew))

usethis::use_data(dataloginformd, recommandloginformd, predictedtpIEinformd,
                  OPC_null, OPC_alt,OPC_Trial.simulation, optimdata_sym,optimdata_asy, overwrite = TRUE)
