# datagrasp task 1

###Stock Market Data
install.packages("ISLR")
library(ISLR)
?Smarket
Smarket = Smarket
dim(Smarket)
summary(Smarket)
str(Smarket)


par(mar = c(2, 2, 2, 2)) # Set the margin on all sides to 2

pairs(Smarket)

plot(Smarket$Year, Smarket$Direction)

cor(Smarket[c(-9,-10)]) # Error in cor(Smarket) : 'x' must be numeric

table(Smarket$Year)

## split dataset 
training_data <- Smarket[Smarket$Year < 2005,]
unique(training_data$Year)

test_data <- Smarket[Smarket$Year == 2005, ]
unique(test_data$Year)

## changing dependent variable to binary (1: up, 0: down)
?rep
Direction_binary <- rep(1, times = nrow(Smarket) )
Direction_binary[ Smarket$Direction == "Down" ] <- 0
Smarket$Direction_binary <- Direction_binary
is.factor(Smarket$Direction_binary)
Smarket$Direction_binary <- as.factor(Smarket$Direction_binary)

table(Smarket$Direction_binary)

## train the model 
?glm
smarket_logit_model <- glm(data = Smarket, formula = Direction_binary ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume, family = binomial())
summary(smarket_model)

## confusion matrix 
pred <- predict(smarket_logit_model, test_data, type = "response")
predicted <- ifelse(pred>0.5, 1, 0)
confus_matrix <- table(Predicted = predicted, Actual = test_data$Direction_binary)

## LDA 
library(MASS)
linear_da <- lda(data = Smarket ,Direction_binary ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume)
pred2 <- predict(linear_da, test_data)  
predicted2 <- ifelse(pred>0.5, 1, 0)
confus_matrix2 <- table(Predicted = predicted2, Actual = test_data$Direction_binary)

## advantages and disadvantages 
# logit regression is simple and effective and has low computational power 
# however it can't be used to solve non-linear problems and is vulnerable to overfitting
# also usually only used for binary classification



