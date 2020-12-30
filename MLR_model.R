## Multiple Linear Regression 

setwd(dir = "C:\\Users/ian/Documents/Machine Learning A-Z New/Part 2 - Regression/Section 5 - Multiple Linear Regression/")
getwd()

## look and understand the data
startup_data <- read.csv("50_Startups.csv")
colnames(startup_data)
head(startup_data)
hist(startup_data$Marketing.Spend)
boxplot(startup_data$R.D.Spend)
summary(startup_data)
str(startup_data)

## convert categorical variable into dummy variables -- encode 
unique(startup_data$State)
startup_data$State <- factor(x = startup_data$State, levels = c("California", "Florida", "New York"), 
                             labels = c(1,2,3)) ## convert into numbers  

## Split dataset 
library(caTools)
set.seed(123)
split = sample.split(Y = startup_data$Profit, SplitRatio = 0.8)
training_set = subset(startup_data, split == T)
test_set = subset(startup_data, split == F)


## Fitting the train data to the MLR
regressor1 <- lm(formula = Profit ~ .,
                data = training_set) ## dot represents all the other variables in the formula 
summary(regressor) 
## can see that the lm function is smart enough to create dummy variables for our categorical data 
## although we had to convert them into numbers first ( but no need for one hot encoding )
## and also removed one of them ( one of the states ) to avoid dummy variable trap ( excluded variable 
## factored into the constant )
## the more stars beside the p value, the better it is (the smaller the p value)
## we can see that the only variable that is useful is R&D spend ( predictor of profit )

## Rewrite linear regression
regressor2 <- lm(formula = Profit ~ R.D.Spend,
                data = training_set) ## dot represents all the other variables in the formula 
summary(regressor) 


## Predicting the test set results 
y_pred1 <- predict(regressor1, test_set)
y_pred2 <- predict(regressor2, test_set)

plot(y_pred1, col = "red", pch = 20)
points(y_pred2, col = "blue", pch = 20)

## very similar prediction between both models (the one with all x variables and the one with only R&D)
## shows that the function is smart enough to identify stronger predictors 

## Building an optimal model via Backward Elimination 
regressor <- lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
                 data = startup_data) ## since we are figuring out important predictors, just use the whole dataset
summary(regressor)

