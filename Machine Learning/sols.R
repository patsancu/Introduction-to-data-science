setwd('~/Development/IntroDataScience/assignment5/')
seaflow = read.csv('seaflow_21min.csv', header = TRUE)

# Questions 1 & 2

# How many particles labeled "synecho" are in the file provided?
# What is the 3rd Quantile of the field fsc_small? (the summary function computes this on your behalf)
summary(seaflow)

#Question 3

# What is the mean of the variable "time" for your training set?

splitdf <- function(dataframe, seed=NULL) {
	#Splits dataframe in two
  if (!is.null(seed)) set.seed(seed)
  index <- 1:nrow(dataframe)
  trainindex <- sample(index, trunc(length(index)/2))
  trainset <- dataframe[trainindex, ]
  testset <- dataframe[-trainindex, ]
  list(trainset=trainset,testset=testset)
}

p = splitdf(seaflow)
train = p$trainset
test = p$testset
summary(train)


#Question 4

# In the plot of pe vs. chl_small, the particles labeled ultra should appear
# to be somewhat "mixed" with two other populations of particles. Which 
# two populations?

library(ggplot2)
ggplot(seaflow, aes(x= pe, y=chl_small, color=pop)) + geom_point(size = 5)


#Questions 5,6,7

# Use print(model) to inspect your tree. Which populations, if any, is your 
# tree incapable of recognizing? (Which populations do not appear on any 
# 	branch?) (It's possible, but very unlikely, that an incorrect answer to 
# this question is the result of improbable sampling.) 

# Most trees will include a node near the root that applies a rule to the pe 
# field, where particles with a value less than some threshold will descend 
# down one branch, and particles with a value greater than some threshold will 
# descend down a different branch. If you look at the plot you created previously, 
# you can verify that the threshold used in the tree is evident visually. What 
# is the value of the threshold on the pe field learned in your model?

# Based on your decision tree, which variables appear to be most important 
# in predicting the class population?

library(rpart)
fol <- formula(pop ~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small)
model <- rpart(fol, method="class", data=train)
install.packages('rattle')
install.packages('rpart.plot')
install.packages('RColorBrewer')
library(rattle)
library(rpart.plot)
library(RColorBrewer)
fancyRpartPlot(model)
print(model)


#Question 8

# How accurate was your decision tree on the test data? Enter a number 
# between 0 and 1.

estimate <- predict(model, test, type='class')
prop.table(table(test$pop == estimate))

#Question 9

# What was the accuracy of your random forest model on the test 
# data? Enter a number between 0 and 1.

library(randomforest)
model <- randomForest(fol, data=train)
estimateTree <- predict(model, test, type='class')

prop.table(table(test$pop == estimateTree))



#Question 10

# After calling importance(model), you should be able to determine which variables 
# appear to be most important in terms of the gini impurity measure. Which ones are 
# they?

importance(model)



#Question 11

# What was the accuracy of your support vector machine model on the test data? 
# Enter a number between 0 and 1.

library('e1071')
model <- svm(fol, data=train)
estimateSVM <- predict(model, test, type='class')
prop.table(table(test$pop == estimateSVM))



#Question 12

# Construct a confusion matrix for each of the three methods using the table function. 
# What appears to be the most common error the models make?

table(pred = estimate, true = test$pop)
table(pred = estimateTree, true = test$pop)
table(pred = estimateSVM, true = test$pop)



#Question 13

# The variables in the dataset were assumed to be continuous, but one of 
# them takes on only a few discrete values, suggesting a problem. Which variable 
# exhibits this problem?
plot(x=seaflow$chl_small)
plot(x=seaflow$fsc_small)
plot(x=seaflow$fsc_perp)
plot(x=seaflow$fsc_big)
plot(x=seaflow$chl_big)
plot(x=seaflow$pe)


#Question 14
filteredSeaflow = seaflow[seaflow$file_id != 208, ]
q = splitdf(filteredSeaflow)
filteredTrain = q$trainset
filteredTest = q$testset
summary(filteredTrain)

modelFiltered <- rpart(fol, method="class", data=filteredTrain)
estimateFiltered <- predict(modelFiltered, filteredTest, type='class')
prop.table(table(filteredTest$pop == estimateFiltered))
fancyRpartPlot(modelFiltered)

modelFiltered <- randomForest(fol, data=filteredTrain)
estimateFilteredTree <- predict(modelFiltered, filteredTest, type='class')
prop.table(table(filteredTest$pop == estimateFilteredTree))

modelFiltered <- svm(fol, data=filteredTrain)
estimateFilteredSVM <- predict(modelFiltered, filteredTest, type='class')
prop.table(table(filteredTest$pop == estimateFilteredSVM))

table(pred = estimateFiltered, true = filteredTest$pop)
table(pred = estimateFilteredTree, true = filteredTest$pop)
table(pred = estimateFilteredSVM, true = filteredTest$pop)