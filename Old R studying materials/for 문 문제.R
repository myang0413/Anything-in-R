#1) 일단 row가 1000개이고 각각 "number", "class", "index"라는 이름의 column을 가진 empty 데이터프레임을 만들고,

#2) "number" column에는 숫자 1부터 1000까지 입력

#3) "class" column에는 "number"에 있는 수가 홀수라면 "odd", 짝수라면 "even"이라는 글자를 입력

#4) "index" column에는 "number"에 있는 수가 3의 배수라면 0으로 처리하고, 그 중에서도 5의 배수인 숫자들(예를들어 15, 30, 45…)은 NA로 처리. 나머지 숫자들은 "number"에 있는 숫자를 그대로 입력

number=c(1:1000)
df1<-data.frame(number)
  
for (i in 1:nrow(df1)){
  if(df1$number[i]%%2==0){
    df1$class[i] = "even"
  }
  else{
    df1$class[i] = "odd"
  }
}


for(i in 1:nrow(df1)){
  if(df1$number[i]%%3==0){
    df1$index[i]=0
  }
  else if(df1$number[i]%%5==0){
    df1$index[i]=NA
  }
  else{
    df1$index[i]=df1$number[i]
  }
}


View(df1)


%in%
  
  I(연속되는 연산을 할때 서야한다) 

lm

##left_join 궁금한변수를 추가하고싶은경우가 

##필요없는 애들은 먼저 빼놓고 gather 하기 