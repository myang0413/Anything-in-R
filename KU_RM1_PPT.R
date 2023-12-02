library(readr)
rm1 <- read_csv("dataset.csv")
head(rm1)
rm2<-rm1[1:21,1:6]
names(rm2)[2] <- "GDP_per_capita"
rm2
mod1<-lm(GDP_per_capita~Foreign_Direct_Investment+Government_Health_Expenditure
         +Telecommunication_Investment,data=rm2)
summary(mod1)
library(car)
mod2<-vif(mod1)
mod2
