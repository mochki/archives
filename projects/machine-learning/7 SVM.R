rm(list=ls())
(clear = function() {cat("\014")})()
setwd("R Studio")
library(e1071)

#####################
### For vowel.csv ###
#####################
# I was getting around 97% accuracy

dset <- read.csv("vowel.csv")

# set up our data
dset <- cbind(dset[,1:2], as.data.frame(scale(dset[,3:12])), dset[,13])
colnames(dset)[13] <- "Class"
allRows <- 1:nrow(dset)
testRows <- sample(allRows, trunc(length(allRows) * 0.3))
test.data <- dset[testRows,]
train.data <- dset[-testRows,]

# Build the SVM
gammas <- 2 ^ seq(-15, 3, 2)
costs <- 2 ^ seq(-5, 15, 2)

calcAccuracy <- function(gam, cst, print=FALSE) {
  model <- svm(Class~., data = train.data, kernel = "radial", gamma = gam, cost = cst)
  prediction <- predict(model, test.data[,-ncol(test.data)])
  agreement <- prediction == test.data$Class
  accuracy <- prop.table(table(agreement))
  
  if (print) {
    confusion.matrix <- table(pred=prediction, true=test.data$Class)
    print(confusion.matrix)
    print(accuracy)
  }
  
  return (as.double(accuracy["TRUE"]))
}

#  I'm sorry functional programming
attempt = 1
results <- matrix(0, length(gammas)*length(costs), 3)
colnames(results) <- c("gamma", "cost", "accuracy")
for (gam in gammas) {
  for (cst in costs) {
    results[attempt,] <- c(gam, cst, calcAccuracy(gam, cst))
    attempt <- attempt + 1
  } 
}

results <- results[sort.list(results[,3], decreasing = TRUE), ]
sprintf("Gamma: %f", as.double(results[1,1]))
sprintf("Cost: %f", as.double(results[1,2]))
calcAccuracy(as.double(results[1,1]), as.double(results[1,2]), print = TRUE)



#######################
### For letters.csv ###
#######################
# This one takes forever.
# With gamma at 0.125 and cost at 8, I got 97% accuracy, so that's pretty cool.

dset <- read.csv("letters.csv")

# set up our data
dset <- cbind(dset[,1], as.data.frame(scale(dset[,2:17])))
colnames(dset)[1] <- "Class"
allRows <- 1:nrow(dset)
testRows <- sample(allRows, trunc(length(allRows) * 0.3))
test.data <- dset[testRows,]
train.data <- dset[-testRows,]

# Build the SVM
gammas <- 2 ^ seq(-3, 3, 2)
costs <- 2 ^ seq(-1, 5, 2)

calcAccuracy <- function(gam, cst, print=FALSE) {
  sprintf("Gamma: %f, Cost: %f", gam, cst)
  model <- svm(Class~., data = train.data, kernel = "radial", gamma = gam, cost = cst)
  prediction <- predict(model, test.data[,-1])
  agreement <- prediction == test.data$Class
  accuracy <- prop.table(table(agreement))
  
  if (print) {
    confusion.matrix <- table(pred=prediction, true=test.data$Class)
    print(confusion.matrix)
    print(accuracy)
  }
  
  return (as.double(accuracy["TRUE"]))
}

#  I'm sorry functional programming
attempt = 1
results <- matrix(0, length(gammas)*length(costs), 3)
colnames(results) <- c("gamma", "cost", "accuracy")
for (gam in gammas) {
  for (cst in costs) {
    results[attempt,] <- c(gam, cst, calcAccuracy(gam, cst))
    attempt <- attempt + 1
  } 
}

results <- results[sort.list(results[,3], decreasing = TRUE), ]
sprintf("Gamma: %f", as.double(results[1,1]))
sprintf("Cost: %f", as.double(results[1,2]))
calcAccuracy(as.double(results[1,1]), as.double(results[1,2]), print = TRUE)




#######################
### For abalone.csv ###
#######################
# Also takes too long. Current setting, I get around 56-57%

dset <- read.csv("abalone.csv")

# set up our data
dset <- cbind(dset[,1], as.data.frame(scale(dset[,2:9])))
colnames(dset)[1] <- "Class"
allRows <- 1:nrow(dset)
testRows <- sample(allRows, trunc(length(allRows) * 0.3))
test.data <- dset[testRows,]
train.data <- dset[-testRows,]

# Build the SVM
gammas <- 2 ^ seq(-3, 3, 2)
costs <- 2 ^ seq(-1, 5, 2)

calcAccuracy <- function(gam, cst, print=FALSE) {
  sprintf("Gamma: %f, Cost: %f", gam, cst)
  model <- svm(Class~., data = train.data, kernel = "radial", gamma = gam, cost = cst)
  prediction <- predict(model, test.data[,-1])
  agreement <- prediction == test.data$Class
  accuracy <- prop.table(table(agreement))
  
  if (print) {
    confusion.matrix <- table(pred=prediction, true=test.data$Class)
    print(confusion.matrix)
    print(accuracy)
  }
  
  return (as.double(accuracy["TRUE"]))
}

#  I'm sorry functional programming
attempt = 1
results <- matrix(0, length(gammas)*length(costs), 3)
colnames(results) <- c("gamma", "cost", "accuracy")
for (gam in gammas) {
  for (cst in costs) {
    results[attempt,] <- c(gam, cst, calcAccuracy(gam, cst))
    attempt <- attempt + 1
  } 
}

results <- results[sort.list(results[,3], decreasing = TRUE), ]
sprintf("Gamma: %f", as.double(results[1,1]))
sprintf("Cost: %f", as.double(results[1,2]))
calcAccuracy(as.double(results[1,1]), as.double(results[1,2]), print = TRUE)