library(readxl)
library(dplyr)
library(magrittr)
covid <- read_excel("COVID_data.xlsx", 
                         sheet = "Raw data")
head(covid)
View(covid)
summary(covid)

colnames(covid)
colnames(covid)<-c("code","income","region","country","start_date","end_date","level_1_policy","level_2_policy")

colnames(covid)

#중복되는 것들 뺄때 
covid2<-covid%>%mutate(index = paste0(code, "-", start_date, "-", end_date,"-", level_1_policy,"-",level_2_policy))%>%distinct(index,.keep_all=T)

nrow(covid)
nrow(covid2)

table(covid2$income)

table(covid2$level_1_policy)

#소득이 더 높은 나라가 정책을 더많이 할까?
covid2%>%mutate(policy_count=1)%>%group_by(country,income)%>%summarise(sum.policy1=sum(policy_count))%>%group_by(income)%>%summarise(avg.policy1=mean(sum.policy1))%>%mutate(income=factor(income,levels=c("Low income","Lower middle income","Upper middle income","High income")))%>%ggplot()+geom_point(mapping=aes(x=income,y=avg.policy1))

head(covid2)
library(lubridate)
covid2%>%mutate(duration=as.Date(end_date)-as.Date(start_date))%>%mutate(duration=as.numeric(duration)+1)%>%filter(duration>0)%>%group_by(country)%>%summarise(income=unique(income),avgdur1=mean(duration))%>%group_by(income)%>%summarise(avgdur2=mean(avgdur1))
                                                                                                                                                            
hist(covid3$duration)
table(covid3$region)

labor<- read_excel("Labor_database.xlsx")
colnames(labor)<-labor[3,]
View(labor)

#remove rows (slice)
labor%>%slice(-c(1:3))%>%select(c(1,3,5,7,62,63))%>%filter(Subsample%in%c("Female","Male"))%>%rename(country = 1,region=2,year=3,sex=4,under=5,excessive=6)%>%mutate(under=as.numeric(under),excessive=as.numeric(excessive))%>%filter(!is.na(under))%>%group_by(region,year,sex)%>%summarise(avg.under=mean(under),avg.excessive=mean(excessive))

###숙제-그래프 그리기 (region=facet_wrap,group=sex,year=x-axis)

colnames(labor)

