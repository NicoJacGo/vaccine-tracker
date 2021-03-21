library(dplyr)
library(readr)

da <- read.csv("new_aggregate.csv")
d7 <- read.csv("week7.csv")
d8 <- read.csv("week8.csv")
#edf <- merge(d1,d2, by=intersect(names(d1), names(d2)), all = TRUE, all.d1= all, all.d2 = all)

edf <- merge(da,d7, by=intersect(names(da), names(d7)), all = TRUE, all.da= all, all.d7 = all)


edf[11] <- NULL

edf <- edf[,c(1,2,3,4,5,6,7,8,9,10,14,11,12,13)]

edf <- merge(edf,d8, by=intersect(names(edf), names(d8)), all = TRUE, all.edf= all, all.d8 = all)
edf <- edf[,c(1,2,3,4,5,6,7,8,9,10,11,15,13,14,12)]
#da <- da[ , -which(names(da) %in% c("X"))]

write.csv(edf, file="aggregate.csv")

edf$Doses_W8 <- as.numeric(gsub(",","",edf$Doses_W8))
edf <- edf %>% 
  rowwise() %>% 
  mutate("Sum" = sum(Doses_W1, Doses_W2, Doses_W3, Doses_W4, Doses_W5, Doses_W6, Doses_W7, Doses_W8, na.rm = TRUE))


write.csv(edf, file="aggregate.csv")
