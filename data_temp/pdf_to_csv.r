library(pdftables)
library(pdftools)

# pdf tables api key only valid for 50 pages

text <- pdf_text("COVIDVaccineAllocation-Week9.pdf")

convert_pdf("COVIDVaccineAllocation-Week13.pdf", output_file = "week13.csv", format="csv",message = TRUE, api_key = "0k2ll5jrq6ot")

# header tailoring

df <- read.csv("week10.csv")
names(df) <- as.character(df[1,])
df <- df[2:nrow(df),]
