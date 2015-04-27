# Practical Machine Learning - Class Project
#
# Main Help Pages for caret package
# http://caret.r-forge.r-project.org/

#install.packages("caret", dependencies = c("Depends", "Suggests"))
library(AppliedPredictiveModeling)
library(rattle)
library(caret)
library(rpart)
library(rpart.plot)

setwd("./Coursera R/Practical Machine Learning/Class Project")

# Load training and testing datasets
pml_training <- read.csv("pml-training.csv")
pml_testing <-read.csv("pml-testing.csv")

# Create Validation dataset from training dataset
inTrain <- createDataPartition(y=pml_training$classe, p=0.95, list=FALSE)
training <- pml_training[inTrain,]
validation <- pml_training[-inTrain,]
dim(training); dim(validation); dim(testing)

set.seed(5151)
modelFit <- train(classe ~ ., data=validation, method="glm", preProcess=c("pca"), trControl=trainControl(method=c("cv")))
modelFit
print(modelFit$finalModel)
plot(modelFit$finalModel, use.n=TRUE)
text(modelFit$finaldModel, use.n=TRUE, all=TRUE, cex=.8)

fancyRpartPlot(modelFit$finalModel)

confusionMatrix(testing$classe, predict(modelFit, testing))


