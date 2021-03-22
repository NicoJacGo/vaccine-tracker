library(dplyr)
library(readr)

da <- read.csv("aggregate.csv")
d9 <- read.csv("week9.csv")
d10 <- read.csv("week10.csv")
d11 <- read.csv("week11.csv")
d12 <- read.csv("week12.csv")
d13 <- read.csv("week13.csv")
d14 <- read.csv("week14.csv")
d15 <- read.csv("week15.csv")

new <- read.csv("new_aggregate.csv")
new[1] <- NULL
#edf <- merge(d1,d2, by=intersect(names(d1), names(d2)), all = TRUE, all.d1= all, all.d2 = all)

edf <- merge(da,d9, by=intersect(names(da), names(d9)), all = TRUE, all.da= all, all.d9 = all)
edf <- merge(edf,d10, by=intersect(names(edf), names(d10)), all = TRUE, all.edf= all, all.d10 = all)
edf <- merge(edf,d11, by=intersect(names(edf), names(d11)), all = TRUE, all.edf= all, all.d11 = all)
edf <- merge(edf,d12, by=intersect(names(edf), names(d12)), all = TRUE, all.edf= all, all.d12 = all)
edf <- merge(edf,d13, by=intersect(names(edf), names(d13)), all = TRUE, all.edf= all, all.d13 = all)
edf <- merge(edf,d14, by=intersect(names(edf), names(d14)), all = TRUE, all.edf= all, all.d14 = all)
edf <- merge(edf,d15, by=intersect(names(edf), names(d15)), all = TRUE, all.edf= all, all.d15 = all)

edf[11] <- NULL

edf2 <- edf[,c(1,2,3,4,5,6,7,8,9,10,11,12,16,17,18,19,20,21,22,13,14,15)]

edf <- merge(edf,d8, by=intersect(names(edf), names(d8)), all = TRUE, all.edf= all, all.d8 = all)
edf <- edf[,c(1,2,3,4,5,6,7,8,9,10,11,15,13,14,12)]
#da <- da[ , -which(names(da) %in% c("X"))]




write.csv(edf, file="aggregate.csv")

edf2$Doses_W15 <- as.numeric(gsub(",","",edf2$Doses_W15))

edf2 <- edf2 %>% 
  rowwise() %>% 
  mutate("Sum" = sum(Doses_W1, Doses_W2, Doses_W3, Doses_W4, Doses_W5, Doses_W6, Doses_W7, Doses_W8, Doses_W9, Doses_W10, Doses_W11, Doses_W12, Doses_W13, Doses_W14, Doses_W15, na.rm = TRUE))


write.csv(edf, file="new_aggregate.csv")
write.csv(edf2, file="aggregate2.csv", row.names = FALSE)

new2 = read.csv("aggregate2.csv")
