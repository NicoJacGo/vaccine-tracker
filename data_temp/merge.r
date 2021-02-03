library(dplyr)
library(readr)

da <- read.csv("aggregate.csv")
d6 <- read.csv("week6.csv")

#edf <- merge(d1,d2, by=intersect(names(d1), names(d2)), all = TRUE, all.d1= all, all.d2 = all)

edf <- merge(da,d6, by=intersect(names(da), names(d6)), all = TRUE, all.da= all, all.d6 = all)

edf[11] <- NULL

edf <- edf[,c(1,2,3,4,5,6,7,8,9,11,10)]


#da <- da[ , -which(names(da) %in% c("X"))]

write.csv(edf, file="aggregate.csv")

edf <- edf %>% 
  rowwise() %>% 
  mutate("Sum" = sum(Doses_W1, Doses_W2, Doses_W3, Doses_W4, Doses_W5, Doses_W6, na.rm = TRUE))


write.csv(edf, file="aggregate.csv")
