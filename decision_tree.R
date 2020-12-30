## Decision Tree Regression model 

getwd()
setwd("Machine Learning A-Z New/Part 2 - Regression/Section 8 - Decision Tree Regression/")

## dataset
dataset_salary <- read.csv(file = "Position_Salaries.csv")
dataset_salary <- dataset_salary[2:3]


## Building the model
library(rpart)
regressor <- rpart(data = dataset_salary, formula = Salary ~.)


## predicting values 
y_pred <- predict(regressor, data.frame(Level = 6.5)) ## Level is our X variable here in the context of salaries 

## visualisation of the model
library(ggplot2)
ggplot() +
  geom_point(aes(x= Level, y = Salary), data = dataset_salary, color = "red") +
  geom_line(aes(x = Level, y = predict(regressor, dataset_salary)), dataset_salary, color = "blue") +
  ggtitle("Decision Tree Regression") 
  
## issue: there are no splits or separate leaves -- need to add parameter for the regression tree model


## Building the model (with splits)
library(rpart)
regressor_improve <- rpart(data = dataset_salary, formula = Salary ~.,
                           control = rpart.control(minsplit = 1))
y_pred2 <- predict(regressor_improve, data.frame(Level = 6.5))

## visualisation of the model part 2
library(ggplot2)
ggplot() +
  geom_point(aes(x= Level, y = Salary), data = dataset_salary, color = "red") +
  geom_line(aes(x = Level, y = predict(regressor_improve, dataset_salary)), dataset_salary, color = "blue") +
  ggtitle("Decision Tree Regression") 

## we can see now that there are splits (or leaves)
## however, supposed to split the independent interval and give average of each interval 
## we can see here that in some intervals, it is a slope i.e. not constant! 

## problem: due to resolution (the slope is how the graph joined two different sections)
## this is a non-linear, non-continuous regression model (unlike all previous models)
## how to visualise 
## rewrite the visualisation code with increased visualisation -- i.e. X_grid 

X_grid <- seq(min(dataset_salary$Level), max(dataset_salary$Level), 0.01)

ggplot() +
  geom_point(aes(x = dataset_salary$Level, y = dataset_salary$Salary),
             colour = 'red') +
  geom_line(aes(x = X_grid, y = predict(regressor_improve, newdata = data.frame(Level = X_grid))),
            colour = 'blue') +
  ggtitle('Truth or Bluff (Regression Model)') +
  xlab('Level') +
  ylab('Salary')


predict(regressor_improve, newdata = data.frame(Level = X_grid))


## true regression tree shouldnt have any slopes, only flat parts (which are averages)
## finds the best way to group datapoints together (i.e. positions 1 to 6 are in the same group)












