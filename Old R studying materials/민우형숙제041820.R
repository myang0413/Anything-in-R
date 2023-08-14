
### Try!! draw a maximum of no2 by weekday (Mon, Tue, ... Sun) by gu
## 1) Mon: 1, Tue: 2, ... Sun :7
## 2) factor


##### trying the factor method
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(magrittr)
library(lubridate)

data <- read.csv("~/민우형수업/Measurement_summary.csv")
colnames(data) = c("date", "code", "address", "lat", "long",
                   "so2", "no2", "o3", "co", "pm10", "pm2.5")

#making -gu column
data$class2 = unlist(str_split(data$address, " "))[grep("-gu", unlist(str_split(data$address, " ")))]
data$class2 = str_sub(data$class2, 1, nchar(data$class2)-1)

#creating days column for specifying days of the week 
data2<-data%>%mutate(days=weekdays(as.Date(data$date)))

data2$days<-factor(data2$days,levels =c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"))
class(data2$days)

data3<-data2%>%group_by(days,class2)%>%summarise(max.no2=max(no2))


#creating the plot visualizing a maximum of no2 by weekday (Mon, Tue, ... Sun) by gu
data3%>%ggplot()+geom_point(mapping=aes(x=days,y=max.no2))+facet_wrap(~class2)+theme_classic()+theme(axis.text.x=element_text(size=rel(0.57),angle=0))
                                                

#####trying the numbering method(1=Monday, 2=Tuesday, ... 7=Sunday)

data$date=as.POSIXct(data$date)
data$days=weekdays(as.Date(data$date))
data$weekday1 = as.numeric(format(data$date, format = "%u"))


dat2<-data%>%group_by(weekday1,class2)%>%summarise(max.no2=max(no2))


#creating the plot visualizing a maximum of no2 by weekday (1=Monday, 2=Tuesday, ... 7=Sunday) by gu
dat2%>%ggplot()+geom_point(mapping=aes(x=weekday1,y=max.no2))+facet_wrap(~class2)+theme_classic()+scale_x_continuous(breaks = seq(1,7,1))


## Try!! substract "-ro" in the "address" column. Please use "str_detect" instead of "grep"

data$class3 = unlist(str_split(data$address, " "))[str_detect(unlist(str_split(data$address, " ")),pattern="ro")]


