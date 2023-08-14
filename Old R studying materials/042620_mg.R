library(tidyr)
library(dplyr)
library(tidyverse)
library(ggplot2)

pov_meta<- read_csv("민우형수업/Poverty_Metadata.csv")
pov_data <- read_csv("민우형수업/Poverty_Data.csv")
 
View(pov_data)

pov_data1<-pov_data%>%select(-c(1,3))%>%
  rename(country=1,series=2)%>%
  filter(series=="SP.POP.TOTL")%>%
  gather(key=year,value=pop,-country,-series)%>%
  mutate(year=as.numeric(substr(year,1,4)),pop=as.numeric(pop))%>%
  filter(!is.na(pop))


labor<- read_excel("Labor_database.xlsx")
colnames(labor)<-labor[3,]
colnames(labor)
labor1<-labor%>%
  slice(-c(1:3))%>%
  select(2,3)%>%
  rename(country=1,region=2)
which(is.na(labor1$region))  
head(labor1)

pov_data2<-left_join(pov_data1,labor1)
which(is.na(pov_data2$region))  
head(pov_data2)
pov_data3<-pov_data2%>%
  filter(!is.na(region))%>%
  group_by(region,year)%>%
  summarise(sum.pop=sum(pop))

pov_data3%>%
  ggplot()+
  geom_area(aes(x=year,y=sum.pop,fill=region))

#x축 continous (ex) time)-line plot, stacked area plot

#x축 discrete-bar plot, point plot,pie chart...

pov_data1a<-pov_data%>%
  select(-c(1,3))%>%
  rename(country=1,series=2)%>%
  gather(key=year,value=value,-country,-series)%>%
  mutate(value = ifelse(value=="..", NA, value))%>%
  mutate(value=as.numeric(value))%>%
  mutate(count=ifelse(is.na(value),0,1))%>%
  group_by(country,series)%>%
  summarise(sum_count=sum(count))%>%
  group_by(series)%>%
  summarise(avg_count=mean(sum_count))%>%
  arrange(desc(avg_count))

table(pov_data1a$avg_count)

View(pov_meta)

pov_meta1<-pov_meta%>%
  select(c(1,3,5))%>%
  rename(series=1,indicator_name=2,long_def=3)

pov_complete<-left_join(pov_data1a,pov_meta1)
View(pov_complete)

write_csv(pov_complete,"pov_complete.csv")

pov_data1<-pov_data%>%
  select(-c(3))%>%
  rename(country=1,code=2,series=3)%>%
  gather(key=year,value=value,-country,-code,-series)%>%
  mutate(year=as.numeric(substr(year,1,4)))%>%
  filter(series %in% unique(pov_complete[pov_complete$avg_count>10,]$series[c(3,5)]))
View(pov_data1)
head(pov_data1)
tail(pov_data1)

unique(pov_complete[pov_complete$avg_count>10,]$series)

pov_complete1<-pov_complete%>%
  select(c(1,2))

pov_data2<-left_join(pov_data1,pov_complete1)%>%
  filter(avg_count>10)

covid1<-covid%>%
  select(2,4)%>%
  rename(level=1,country=2)

covid_pov1<-left_join(covid1,pov_data1)%>%
  filter(!is.na(level))%>%
  mutate(value=ifelse(value=="..",NA,value))%>%
  mutate(value=as.numeric(value))%>%
  filter(!is.na(year))

covid_pov2<-covid_pov1%>%
  group_by(year,level,series)%>%
  summarise(avg.val=mean(value,na.rm=TRUE))%>%
  ungroup()%>%
  mutate(level=factor(level,levels=c("Low income","Lower middle income","Upper middle income","High income")))

summary(covid_pov1)
head(covid_pov2)
test2<-covid_pov2%>%
  filter(is.na(year))


covid_pov3<-covid_pov2%>%
  ggplot()+
  geom_line(mapping=aes(x=year,y=avg.val,color=level))+
  facet_wrap(~series)+
  theme(legend.title =element_blank())+
  labs(y= "poverty gap value [percentage]")

covid_pov3



View(test1)
nrow(test1)
nrow(covid_pov1)

View(covid_pov1)
table(pov_data1$year)

View(pov_data1)

library(pacman)
p_load(tidyr, dplyr, magrittr, data.table, lfe, ggplot2, lubridate, broom, tibble)

character 인 애들은 unique 로 하면 summarise 쓸수있다 




#1st column=country name/2nd column=yr/3rd


##숙제-stacked bar plot (재밌을법한 그래프 3개 만들어보고 문자드리기)
lag
drop_na
