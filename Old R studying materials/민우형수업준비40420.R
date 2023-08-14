library(readr)
library(ggplot2)
library(magrittr)
library(rlang)
library(dplyr)
library(Stat2Data)
library(AER)

date1<-air1$`Measurement date`


ggplot(data=air1,aes(x=O3,y=SO2))+
  geom_line()
