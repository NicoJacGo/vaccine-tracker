library(dplyr)
library(readr)

da <- read.csv("aggregate.csv")

edf <- merge(d1,d2, by=intersect(names(d1), names(d2)), all = TRUE, all.d1= all, all.d2 = all)

edf <- merge(da,d5, by=intersect(names(da), names(d5)), all = TRUE, all.da= all, all.d5 = all)

da <- da[ , -which(names(da) %in% c("X.1"))]

write.csv(da, file="aggregate.csv")

da <- da %>% 
  rowwise() %>% 
  mutate("Sum" = sum(Doses_W1, Doses_W2, Doses_W3, Doses_W4, Doses_W5, na.rm = TRUE))


