# Using random forest to perform feature selection
library(randomForest)
library(varSelRF)
library(Hmisc)
library(preprocessCore)


# Example from iris dataset

iris <- iris[sample(nrow(iris)),]
irisX <- iris[1:100,1:4]
irisY <- iris[1:100,5]
irisTestX <- iris[101:150,1:4]
irisTestY <- iris[101:150,5]

rfobj <- randomForest(irisX,irisY,keep.forest=TRUE) # Has multiple attributes
pred <- predict(rfobj,irisTestX)

# variable importance
varImpMetric <- rfobj$importance

# Using out of bag error to select the variables
# varSelRF package
varSelObj <- varSelRF(irisX,irisY)


# Random forest classification
# Two potential tuning parameters in RF are:
# Number of trees (ntree) built and fraction of variable to choose when building a tree (mtry) 


Trees = c(seq(100,1000,100),1500)
numVar = dim(irisX)[2]
roundednumVar <- round(sqrt(numVar),digits=0)
varFrac = c(roundednumVar*seq(0.1,1,0.1))

classificationErrorMatrix <- matrix(nrow=length(Trees),ncol=length(numVar))

for (i in 1:length(Trees)){
  for (j in 1:length(varFrac)){
    rfObj <- randomForest(irisX,irisY,ntree=Trees[i],varFrac[j])
    #predictedClasses<-rfobjCancer$predicted
    #classificationError<-mean(classes==predictedClasses)
    validationPrediction <- prediction(rfObj,LeftOutData)
    classificationErrorMatrix[i,j] <- mean(validationPrediction==trueClass)
    
  }
  
}
