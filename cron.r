library(rvest)
library(dbplyr)
library(taskscheduleR)

taskscheduler_create(
  taskname = "vaccine_distribution",
  rscript = "C:\\Users\\fro7e\\OneDrive\\Desktop\\vaccine-tracker\\vaccine-tracker\\scrape.r",
  schedule = "DAILY",
  starttime = format(Sys.time() + 62, "%H:%M"),
  startdate = format(Sys.Date(), "%m/%d/%Y"),
  Rexe = file.path(Sys.getenv("R_HOME"), "bin", "Rscript.exe")
)

#taskscheduler_stop("vaccine_distribution")
