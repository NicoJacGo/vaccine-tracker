library(pdftables)

# pdf tables api key only valid for 50 pages

text <- pdf_text("COVIDVaccineAllocation-Week4.pdf")

convert_pdf("COVIDVaccineAllocation-Week4.pdf", output_file = "week4.csv", format="csv",message = TRUE, api_key = "sldcc9e4wnhk")

# header tailoring

df <- read.csv("week4.csv")
names(df) <- as.character(df[1,])
df <- df[2:nrow(df),]
