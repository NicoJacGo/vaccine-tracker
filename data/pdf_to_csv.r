library(pdftables)

write.csv(head(iris, 20), file = "COVIDVaccineAllocation-Week1.csv", row.names = FALSE)

convert_pdf("COVIDVaccineAllocation-Week1.pdf", "COVIDVaccineAllocation-Week1.csv")

