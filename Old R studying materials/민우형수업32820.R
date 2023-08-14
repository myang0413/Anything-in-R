rm(list=ls())
#environment 의 object 지우는것 

character
numeric
date
logical
#4개의 factor

x=c("문규","문규","문규양")
length(x)
#vector 갯수 새는법

nchar(x[3])

x1=as.Date("1998-04-13")
class(x1)
#class 을 더 많이쓴다

x2=c("문규",1)
#vector 1개라도 character 가있으면 character 로 사용된다

x3=c(1:100)
x4=rep(c(1:10),10)

#c를 넣는것을 습관화하기

x5=seq(2,100,2)
#1부터 100까지 짝수 
#ex) 연도축에 5년씩 두고 싶을때 그래프에서 


x6=seq(1900,2000,5)
x6


x7=seq(0,10,0.5)
x7

#c 는 정수단위에서만 벡테생성 가능

is.na()
#중요한 함수 

------------------------------------------------
colnames()
#column name 확인하는 습관가지기 

###coal dataset 에서 capacity tab 가지고그래프 그려보기 

##밑에 차이점(만약에 1개이상 dataset 을 쓰면 geom_point() 에 넣기 )
ggplot()+
  geom_point(data=df0,aes(x=,y=))

ggplot(data=df0,aes(x=,y=))+
  geom_point()



