library(pdftables)
library(pdftools)

# pdf tables api key only valid for 50 pages

text <- pdf_text("COVIDVaccineAllocation-Week9.pdf")

convert_pdf("COVIDVaccineAllocation-Week15.pdf", output_file = "week15.csv", format="csv",message = TRUE, api_key = "66pnwrb55ow9")

# header tailoring

df <- read.csv("week10.csv")
names(df) <- as.character(df[1,])
df <- df[2:nrow(df),]
