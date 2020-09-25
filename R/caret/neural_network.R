library(caret);
library(foreach);
library(ggplot2);
library(mvnfast);
library(e1071);

########################
# Simulate data
########################

# Observations
n = 100;
# Parameters
mu1 = c(0,0);
mu2 = c(2,2);
sigma1 = matrix(c(1,0.5,0.5,1),nrow=2,byrow=T);
sigma2 = matrix(c(1,-0.2,-0.2,1),nrow=2,byrow=T);
# Membership probability
p1 = 0.35;
p2 = 1 - p1;
# Simulate
D = foreach(i=1:n,.combine=rbind) %do% {
  # Cluster
  z = 1 + rbinom(n=1,size=1,prob=p2);
  # Covariate
  if(z==1){
    x = rmvn(n=1,mu=mu1,sigma=sigma1);
  } else {
    x = rmvn(n=1,mu=mu2,sigma=sigma2);
  }
  # Out
  Out = data.frame(t(c(z,x)));
  colnames(Out) = c("y","x1","x2");
  return(Out);
}




# Plot
q = ggplot(D,aes(x=x1,y=x2,color=factor(y))) + geom_point();
q = q + theme_bw() + scale_color_manual(name="Class",values=c("steelblue","coral"));
show(q);

########################
# Data Splitting
########################

# Get complement of testing set
setComp = function(a,n){
  # a : Set
  # n : Obs
  
  omega = seq(1:n);
  b = omega[!(omega %in% a)];
  return(b);
}

n = nrow(D);
Splits = createFolds(seq(1:n),k=5);

a = Splits$Fold1;
b = setComp(a,n);

Dtrain = D[b,];
Dtest = D[a,];



########################
# Neural Networks
########################

## Tuning options
# Decay : Regularization parameter
# Size : Hidden units
grid = expand.grid(.decay = 10^seq(from=-1,to=-5),.size=c(5,10,100));
TC = trainControl(method="cv", repeats=5, selectionFunction="best");

nnet1 = train(form=factor(y)~., data=Dtrain, method="nnet",
              preProc = c("center","scale"), trace = F, maxit = 1000,
              tuneGrid = grid, trControl = TC);

# Predictions
p1 = predict(nnet1, newdata=Dtest);


predictionAccuracy <- mean(Dtest$y == p1)
