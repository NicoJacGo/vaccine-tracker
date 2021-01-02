library(rvest)
library(dplyr)

# might need to ask web scraper (will use scraper as replacing downloads is hazardous) 

fileurl <- "https://tabexternal.dshs.texas.gov/vizql/t/THD/w/COVID-19VaccineinTexasDashboard/v/VaccineDosesAdministered/vudcsv/sessions/0B07A44BCDF146848A2E92B89F976F14-3:3/views/835363737388761835_14597693307097341076?summary=true"

download.file(fileurl, destfile = "data.csv", method = "curl")

# transforming data

a <- read.csv("data.csv")

p1 <- a[1] 
p2 <- a[3]

df_transformed = data.frame(p1,p2)
