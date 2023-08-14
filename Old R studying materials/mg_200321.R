x = 2
x = 4

assign("result", lm(y ~ x1))

rm(x)

x = 1
y = 2
z = 3

## remove all objects
rm(list = ls())

name = "Minwoo"
age = 28

is.numeric(age)
is.character(age)

age2 = "28"
is.numeric(age2)
is.character(age2)

nchar(name)

names = c("MW", "MG", "SY")

## length: count the number of elements in a vector
length(names)

date1 = as.Date("1950-06-25")
class(date1)

# date3 = as.character("1950062503")
# substr(date3,1,4)

## However, as.Date type takes big size
library(lubridate)
year(date1)
month(date1)
hour(date1)

date2 = as.POSIXct("1950-06-25 18:00")
hour(date2)

logic = is.Date(date1)
## is.logical(logic)

names
class(names)

ages = c(28, 23, 20)
class(ages)

mix = c("MW", 28)
class(mix[2])

x = c(1:10)
x = rep(c(1:10), 10)

x1 = seq(2, 10, 2)
x2=rep(x1,10)
x2


x = seq(1900, 1990, 10)

q <- c("Hockey", "Football", "Baseball", "Curling", "Rugby",
       "Lacrosse", "Basketball", "Tennis", "Cricket", "Soccer")

nchar(q)
length(q)

q = rep(q, 100)

q[seq(2, length(q), 2)]

q2 = as.factor(q, ordered = T)
relevel(q2, ...)
#as.numeric(q2)

age = rep(c(21:30),100)
age = as.factor(age)

age = c(1:10)

age[5] = NA
age

is.na(age[1])
is.na(age[5])

 ## ignore missing values
mean(age, na.rm = T)

### create dataframe
x = c(10:1)
y = c(-4:5)
q = c("Hockey", "Football", "Baseball", "Curling", "Rugby",
      "Lacrosse", "Basketball", "Tennis", "Cricket", "Soccer")
df <- data.frame(x, y, q)
df

colnames(df) = c("first", "second", "sport")
colnames(df)[3] = "sports"
names(df)

df2 = df[6:10,]
rownames(df2) = c(1:5)

nrow(df2)
ncol(df2)
dim(df2)

head(df)
tail(df)

## () is used at functions
## [] is used at vectors, dataframes, lists, ...
df[5,2]

df2 = rbind(df, df)
df2 = rbind(df2, df)

df2[df2$sports=="Basketball" | df2$sports=="Hockey",]$second = NA

## So Important!!
df2$sports[1] = NA
df2[df2$sports=="Football" & !is.na(df2$sports),]$second = NA

## basic operators: == != > < >= <= | &
