library(readr)
library(dplyr)
library(tidyr)
data <- read_csv("Measurement_summary.csv")

colnames(data) = c("date", "code", "address", "lat", "long",
                 "so2", "no2", "o3", "co", "pm10", "pm2.5")

data = data %>% mutate_if(.<0, NA)

data2 = data %>% select(-c(address, lat, long)) %>%
  gather(key = pollutant, value = value, so2, no2, o3, co, pm10, pm2.5) %>%
  mutate(value = replace(value, which(value<0), NA)) %>%
  mutate(year = year(date)) %>%
  mutate(month = month(date)) %>%
  mutate(hour = hour(date))

data3 = data2 %>% group_by(year, month, pollutant) %>%
  summarise(value.avg = mean(value, na.rm=T)) %>%
  spread(key = pollutant, value = value.avg)

yrs<-data%>%select(c(date,pm2.5,pm10))%>%gather(key=pollutants,value=value,pm2.5,pm10)%>%mutate(value= replace(value, which(value<0), NA))

yrs2<-yrs%>%spread(key=pollutants,value=value)

table(yrs$pollutants)

## gather & spread

##Visualization for so2 average vs o3 average over 3 years (2017-2019)
library(ggplot2)
data3 %>% 
  ggplot() +
  geom_point(mapping=aes(x=pm2.5, y=pm10, color=factor(year))) +
  theme_classic()

##Visualization for so2 average per month of each year
data3 %>%
  ggplot() +
  geom_line(mapping=aes(x=month, y=o3 , color=factor(year))) + 
  theme_classic() +
  scale_x_continuous(breaks = seq(1,12,1))

## string manuplation: use "stringr" package!!
library(stringr)
data$class2 = unlist(str_split(data$address, " "))[grep("-gu", unlist(str_split(data$address, " ")))]
data$class2 = str_sub(data$class2, 1, nchar(data$class2)-1)

#str_locate(data$address[1], ",")
#str_locate_all(data$address[1], ",")

data2 = data %>% select(-c(code, address, lat, long)) %>%
  gather(key = pollutant, value = value, so2, no2, o3, co, pm10, pm2.5) %>%
  mutate(value = replace(value, which(value<0), NA)) %>%
  mutate(year = year(date)) %>%
  mutate(month = month(date)) %>%
  mutate(hour = hour(date))

data3 = data2 %>% group_by(hour, class2, pollutant) %>%
  summarise(value.avg = mean(value, na.rm=T)) %>%
  spread(key = pollutant, value = value.avg)

data3 %>%
  ggplot() +
  geom_line(mapping=aes(x=month, y=pm2.5, color=factor(class2))) + 
  theme_classic() +
  scale_x_continuous(breaks = seq(1,12,1))

data3 %>%
  ggplot() +
  geom_line(mapping=aes(x=month, y=pm2.5)) + 
  theme_classic() +
  scale_x_continuous(breaks = seq(1,12,1)) +
  facet_wrap(~class2)

data3 %>%
  ggplot() +
  geom_line(mapping=aes(x=hour, y=pm2.5)) + 
  theme_classic() +
  scale_x_continuous(breaks = seq(0,23,1)) +
  facet_wrap(~class2)

data3 %>%
  ggplot() +
  ggtitle(sprintf("Time: %s", Sys.time())) +
  geom_line(mapping=aes(x=hour, y=pm2.5)) + 
  theme_classic() +
  scale_x_continuous(breaks = seq(0,23,1)) +
  facet_wrap(~class2)

### Try!! draw a maximum of no2 by weekday (Mon, Tue, ... Sun) by gu
## 1) Mon: 1, Tue: 2, ... Sun :7
## 2) factor

## Ch.16: Manipulating Strings
paste("a", "b", sep = "&")
paste0("a", "b")

library(XML)
theURL <- "http://www.loc.gov/rr/print/list/057_chron.html"
df <- readHTMLTable(theURL, which=3, as.data.frame=TRUE,
                            skip.rows=1, header=TRUE,
                            stringAsFactors=FALSE)

## Please memorize: "str_split" & "str_sub"
library(stringr)
yearList <- str_split(presidents$YEAR, pattern = "-")

str_sub(df$PRESIDENT[1],1,6)
str_sub(df$PRESIDENT[1],-8,-1)

str_detect(df$PRESIDENT, pattern="John")
df[str_detect(df$PRESIDENT, pattern="John"),]

con <- url("http://www.jaredlander.com/data/warTimes.rdata")
load(con)
close(con)

warTimes
theTimes <- str_split(string=warTimes, pattern="(ACAEA)|-", n=2)
theStart <- sapply(theTimes, FUN=function(x) x[1])
theStart <- str_trim(theStart)
str_extract(string=theStart, pattern="January")

## Try!! substract "-ro" in the "address" column. Please use "str_detect" instead of "grep"


