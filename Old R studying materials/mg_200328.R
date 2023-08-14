### data <- read_excel("Coal/data/Coal.xlsx", sheet = "demand")

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
## dim(df2)

head(df)
tail(df)

summary(df)

colnames() #***
rownames()
ncol() #***
nrow()
head() #***
tail()
summary() #***

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

## df <- data.frame(First=x, Second=y, Sport=q)
head(df, n=20)

class(df)

df[2,3]

df[c(3:5),c(2:3)]

df[seq(1, nrow(df), 2),]

## dataframe is a bundle of vectors
## list is a bundle of dataframes (= a bundle of vectors)

a = c(1,2,3)
b = list(c(1,2,3))

# creates a two element list
# the first is a three element vector
# the second element is a five element vector
list3 <- list(c(1,2,3), c(3:7))

result = lm(First ~ Second, data = df)
result$coefficients

list6 <- list(TheDataFrame=df, TheVector=c(1:10), TheList=list3)

length(list6)

## linear albegra ##
A = matrix(1:10, nrow=5) ## 5X2
B = matrix(21:30, nrow=5) ## 5X2
C = matrix(21:40, nrow=2) ## 2X10

## 행렬연산을 R에서 할 수 있다!!
A+B
A*B
A==B

B
t(B)

A %*% t(B)

df[1,2]
A[1,2]

## all elements of matrix are numbers
## dataframe contains Date, Character, Logical ...

df
plot(df$Second ~ df$First)

ar <- array(1:12, dim=c(2, 3, 2))
ar
ar[1,,]

### Read data
# (1) csv (2) xlsx (3) txt

library(ggplot2)

 df0 = diamonds

head(df0)
head(df0, n=15)
summary(df0)
colnames(df0)

## Histogram (= distribution)
summary(df0$carat)
hist(df0$carat) ## IMPORTANT
## hist(df0$carat, main="Carat Histogram", xlab="Carat")

## Scatterplot
colnames(df0)
plot(df0$price ~ df0$carat)

plot(price ~ carat, data=df0)

## Correlation
cor(df0[,c("price", "carat")])

## summary(lm(price ~ carat, data = df0))

## Boxplot
summary(df0$carat)
boxplot(df0$carat)

### GGPLOT
ggplot(data = df0) +
  geom_histogram(aes(x = carat))

ggplot(data = df0) +
  geom_histogram(aes(x = carat), fill = "blue")

## density plot
ggplot(data = df0) +
  geom_density(aes(x=carat), fill="red")

## scatterplot
ggplot(data = df0, aes(x=carat, y=price)) +
  geom_point(color = "red")

colnames(df0)[3] = "color2"

## draw scatterplot by specific groups
ggplot(data = df0, aes(x=carat, y=price)) +
  geom_point(aes(color = color2))

ggplot(data = df0, aes(x=carat, y=price)) +
  geom_point(aes(color = cut))

## facet_wrap and facet_grid functions take only character(factor) types
ggplot(data = df0, aes(x=carat, y=price)) +
  geom_point(aes(color = color2)) +
  facet_wrap(~color2)

ggplot(data = df0, aes(x=carat, y=price)) +
  geom_point(aes(color = color2)) +
  facet_grid(cut~clarity)

### PRACTICE
cap <- read_excel("Coal/data/Coal.xlsx", sheet = "capacity")
cap2 <- cap %>% select(-total) %>% tidyr::gather(key = type, value = capacity, -year) %>% mutate(capacity = capacity/1000)

ggplot(data = cap2, aes(x=year, y=capacity)) +
  geom_point(aes(color = type)) +
  facet_wrap(~ type)


