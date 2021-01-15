library(pdftables)
library(pdftools)

# pdf tables api key only valid for 50 pages

text <- pdf_text("COVIDVaccineAllocation-Week1.pdf")

convert_pdf("COVIDVaccineAllocation-Week1.pdf", output_file = "week1.csv", format="csv",message = TRUE, api_key = "qzmpa858d2z7")

# header tailoring

df <- read.csv("week5.csv")
names(df) <- as.character(df[1,])
df <- df[2:nrow(df),]
