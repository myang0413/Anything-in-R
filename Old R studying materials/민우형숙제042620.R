#1. unemployment rate (엑셀 기준 Y열)
#지역(region)에 따른 실업률은 urban/rural별로 어떤 차이가 있을까? (line #plot으로 그리기)

library(ggplot2)
library(dplyr)
library(tidyr)
library(magrittr)

labor<- read_excel("Labor_database.xlsx")

colnames(labor)<-labor[3,]

labor1<-labor%>%
  slice(-c(1:3))%>%
  select(1,3,7,25)%>%
  rename(country=1,region=2,area=3,rate=4)%>%
  filter(area%in%c("Rural","Urban"))%>%
  mutate(rate=as.numeric(rate))%>%
  filter(!is.na(rate))

labor1$region<-factor(labor1$region)

labor2<-labor1%>%group_by(region,area)%>%summarise(avgrate=mean(rate))

labor3<-labor2%>%ggplot()+geom_point(aes(x=region,y=avgrate,color=area))+theme(axis.text.x = element_text(angle = 45, hjust = 1))

labor3


#2. employment by sectors (엑셀 기준 AK, AL, AM열)
#- 지역과 시간에 따른 섹터별 노동쉐어는 얼마나 될까? (bar plot으로 그리기, #x축을 year로)


data1<-labor%>% 
  slice(-c(1:3))%>%
  select(1,3,5,37,38,39)%>%
  rename(country=1,region=2,year=3,agri=4,industry=5,service=6)%>%
  gather(key=sector,value=share,agri,industry,service)%>%
  mutate(share=as.numeric(share))%>%
  filter(!is.na(share))
 
data2<-data1%>%group_by(region,year,sector)%>%summarise(avg_share=mean(share))

data3<-data2%>%ggplot()+geom_point(aes(x=year,y=avg_share,color=sector))+facet_wrap(~region)+scale_x_discrete(breaks = seq(1988,2017,4))

data3

#3. education attainment (엑셀 기준 BW ~ BZ열)
#- 지역과 연령에 따라 교육수준이 얼마나 다를까? (line plot으로 그리기)

dat1<-labor%>% 
  slice(-c(1:3))%>%
  select(1,3,7,75,76,77,78)%>%
  rename(country=1,region=2,age=3,No_Ed=4,primary_Ed=5,second_Ed=6,post_second_Ed=7)%>%
  filter(age%in%c("Young worker","Old worker"))%>%
  gather(key=Ed_level,value=Ed_perc,No_Ed,primary_Ed,second_Ed,post_second_Ed)%>%
  mutate(Ed_perc=as.numeric(Ed_perc))%>%
  filter(!is.na(Ed_perc))

dat2<-dat1%>%group_by(region,age,Ed_level)%>%summarise(avg.Ed_perc=mean(Ed_perc))

dat3<-dat2%>%mutate(Ed_level=factor(Ed_level,levels=c("No_Ed","primary_Ed","second_Ed","post_second_Ed")))%>%ggplot(aes(fill=Ed_level,x=region,y=avg.Ed_perc))+geom_bar(position="stack", stat="identity")+facet_wrap(~age)+theme(axis.text.x = element_text(angle = 45, hjust = 1))

dat3
