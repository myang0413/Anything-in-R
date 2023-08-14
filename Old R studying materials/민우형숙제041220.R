#####숙제-구별/연도별 so2 랑 o3의 평균값/ max/min 3개의 plot 으로 나타내기 (line plot)

library(magrittr)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(tidyverse)
library(stringr)

df0 = read.csv("~/민우형수업/Measurement_summary.csv")
head(df0)

colnames(df0) = c("date", "code", "address", "lat", "long",
                  "so2", "no2", "o3", "co", "pm10", "pm2.5")


###연도별 so2랑 o3의 평균값

##summarize variables 
summary(df0)


##Subsetting and creating new columns of month and year
yrs<-df0%>%select(c(date,pm2.5,pm10))%>%mutate(date2=as.Date(date))%>%mutate(Year=year(date2))%>%mutate(Month=month(date2))%>%gather(key=pollutants,value=value,pm2.5,pm10)%>%mutate(value= replace(value, which(value<0), NA))%>%spread(key=pollutants,value=value)

View(yrs)
##각 연도와 월별로 so2 average와 o3 average 계산 
df1<-yrs%>%group_by(Year,Month)%>%summarise(so2.avg=mean(so2),o3.avg=mean(o3))

df1
##Visualization for so2 average per month of each year
df1%>%ggplot(aes(x=Month,y=so2.avg))+geom_line(mapping=aes(x=Month,y=so2.avg,color=factor(Year)))+theme_classic()



##Visualization for o3 average per month of each year
df1%>%ggplot(aes(x=Month,y=o3.avg))+geom_line(mapping=aes(x=Month,y=o3.avg,color=factor(Year)))+theme_classic()

##Visualization for so2 average vs o3 average over 3 years (2017-2019)
df1%>%ggplot(aes(x=so2.avg,y=o3.avg))+geom_line(mapping=aes(x=so2.avg,y=o3.avg,color=factor(Year)))+theme_classic()+xlim(-0.025,0.01)

#one 1 rows of missing value 

##각 연도와 월별로 so2 max/min와 o3 max/min 계산 
df2<-yrs%>%group_by(Year,Month)%>%summarise(so2.max=max(so2),o3.max=max(o3),so2.min=min(o3),o3.min=min(o3))

summary(df2)

##Visualization for so2 max vs o3 max over 3 years (2017-2019)
df2%>%ggplot(aes(x=so2.max,y=o3.max))+geom_line(mapping=aes(x=so2.max,y=o3.max,color=factor(Year)))+theme_classic()

##Visualization for so2 min vs o3 min over 3 years (2017-2019)
df2%>%ggplot(aes(x=so2.min,y=o3.min))+geom_line(mapping=aes(x=so2.min,y=o3.min,color=factor(Year)))+theme_classic()

##Visualization for so2 min vs o3 min over 3 years (2017-2019)
df2%>%ggplot(aes(x=so2.max,y=o3.max))+geom_line(mapping=aes(x=so2.max,y=o3.max,color=factor(Year)))+theme_classic()

#구별 so2랑 o3의 평균값
df0$address<-as.character(df0$address)
class(df0$address)
df0$address[1]<-str_subset(df0$address[1],"gu$")

#for loop 

#########daily pm2.5 pm10 average
