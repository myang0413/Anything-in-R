library(magrittr)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
df = read.csv("~/민우형수업/Measurement_summary.csv")
head(df)
colnames(df) = c("date", "code", "address", "lat", "long",
                 "so2", "no2", "o3", "co", "pm10", "pm2.5")

df2<-df%>%select(-c(lat,long,address))%>%mutate(date2=as.Date(date))%>%filter(year(date2)%in%c(2017,2018))%>%mutate(Month=month(date2))

df3<-df2%>%group_by(Month)%>%summarise(pm2.5.avg=mean(pm2.5),pm10.avg=mean(pm10))


df3%>%gather(key=class,value=value,pm2.5.avg,pm10.avg)%>%
  ggplot(aes(x=Month,y=value))+geom_line(aes(color=factor(class)))

#station 갯수 알아내기 
length(unique(df$code))

#기초적이고 핵심적인 data visualization 과정 (데이터 필터링, calculate value, melting+plot) 


head(df2)
tail(df2)




class(df$date)

