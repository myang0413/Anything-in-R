library(ggplot2)

data("diamonds")
df0 = diamonds

df1 = ggplot2::economics

head(df1)
colnames(df1)
summary(df1)

hist(df1$unemploy)

ggplot(data = df1, aes(x=date, y=pop)) +
  geom_line()

library(lubridate)
head(df1$date)

df1$year = year(df1$date)
df1$month = month(df1$date)

### 
table(df1$year)
table(df0$color)

which(df1$year >= 2000)
## econ2000 = df1[which(df1$year >= 2000), ]
econ2000 = df1[df1$year >= 2000,]
table(econ2000$year)

ggplot(econ2000, aes(x=month, y=pop)) +
  geom_line(aes(color = year))

## you should factorize "year" variable to make a group
ggplot(econ2000, aes(x=month, y=pop)) +
  geom_line(aes(color = factor(year), group = year)) +
  scale_color_discrete(name = "Year") +
  labs(title = "Population Growth", x = "Month", y = "Population")

## theme_classic() remove all backgrounds
ggplot(econ2000, aes(x=month, y=pop)) +
  geom_line(aes(color = factor(year), group = year)) +
  scale_color_discrete(name = "Year") +
  labs(title = "Population Growth", x = "Month", y = "Population") +
  theme_classic()

## theme_classic() remove all backgrounds
ggplot(econ2000, aes(x=month, y=pop)) +
  geom_line(aes(color = factor(year), group = year)) +
  scale_color_discrete(name = "Year",
                       value = c("red", "orange", "yellow", "green", "blue", "purple", "black")) +
  labs(title = "Population Growth", x = "Month", y = "Population") +
  theme_classic()

###
print("Hello MG")

### control statements
x=1

## ==: equal // !=: not equal // > // <
if(x>2){
  print("hello")
}

x=100

### Please remember!!
if(x==1){
  print("hello")
} else if(x==2){
  print("hello2")
} else{
  print("i don't know")
}

## | == "or" // & == "and"
x=2
if(x==1 | x==2){
  print("hello")
}

x=1.5
if(x>0 & x<2){
  print("hello")
}

## for loops
for(i in 1:10){
  print(i)
}

for(i in seq(2, 10, 2)){
  print(i)
}

### Combination of if and for loops
df1$test = NA
for(i in 1:nrow(df1)){
  if(df1$year[i] < 1980){
    df1$test[i] = "old"
  }
  else{
    df1$test[i] = "new"
  }
}

table(df1$test)

## year < 1980: "old" // 1980 < year < 2000: "mid" // year > 2000: "new"
for(i in 1:nrow(df1)){
  if(df1$year[i] < 1980){
    df1$test[i] = "old"
  }
  else if(1979 < df1$year[i] & df1$year[i] < 2000){
    df1$test[i] = "mid"
  }
  else{
    df1$test[i] = "new"
  }
}

table(df1$test)

df1$test = NA
df1[df1$year < 1980,]$test = "old"
df1[df1$year > 1979 & df1$year < 2000,]$test = "mid"
df1[df1$year > 1999,]$test = "new"

for(i in 1:nrow(data)){
  if(is.na(data$use[i])==FALSE){}
  else if(data$use[i]=="NO"){
    data$use[i] <- data$use[i+1]
  }
  else{
    data$use[i] <- data$use[i-1]
  }
}

### dplyr
## Selecting columns is done with select,
## filtering rows with filter,
## grouping data with group_by and summarize,
## changing or adding columns with mutate

library(magrittr)
df0 %>% head(n=4) %>% dim

df0[,c(1,7)]

## select
df0 %>% select(c(carat, price))
df0 %>% select(-c(x, y))

name = colnames(df0)[c(1:3)]

df0 %>% select_(.dots = name[c(1:3)])

df0 %>% select(starts_with('c'))
df0 %>% select(ends_with('e'))

## contains
df0 %>% select(contains('l'))

df0 %>% select(matches('r.+t'))







