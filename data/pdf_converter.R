library(tidyverse)
library(rvest)
library(pdftools)

url_modifier <- function(num) {
  sprintf(paste0("https://www.dshs.texas.gov/news/updates/COVIDVaccineAllocation-Week", num, ".pdf"))
}

week <- 0

for(i in seq(1, 1, 1)){
  week <<- week + i #assigning to global environment 
}

url_modifier(week)

download.file(url_modifier(week), basename(url_modifier(week)), quiet = TRUE, mode = "wb")













    