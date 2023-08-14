#Importing the necessary packages
library(dplyr)
library(readr)
library(randomForest)
library(rsample) 
library(Metrics)

#Importing the data
CA=read.csv("/cloud/project/train_cali_housing.csv")

#Look at the first peak of the data
head(CA)

#Finding out about structure of the data
glimpse(CA)

#Drop columns that are not necessary
CA<-CA[-c(1,8,9)]

#Create a first Random Forest model
set.seed(123)
CA_split <- initial_split(CA, prop = .7)
CA_train <- training(CA_split)
CA_test  <- testing(CA_split)
rf.CA<-randomForest(MedHouseVal~.,data=CA_train,ntree=100,mtry=5,
                      importance=T,na.action=na.omit)
print(rf.CA)
plot(rf.CA)

#Number of trees with lowest MSE
which.min(rf.CA$mse)

#RMSE of this optimal random forest
sqrt(rf.CA$mse[which.min(rf.CA$mse)]) #RMSE=0.7064773

#Feature (variable) importance
importance(rf.CA,type=1) #MedInc is the most important feature
varImpPlot(rf.CA,type=1)
plot(rf.CA)

#Make predictions & Take a peak the prediction
pred_rf<- predict(rf.CA, CA_test)
head(pred_rf)

#Calculate RMSE for prediction model
RMSE <- sqrt(sum((pred_rf - CA_test$MedHouseVal)^2)/length(pred_rf))
print(RMSE)

