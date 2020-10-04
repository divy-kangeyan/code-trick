# PCA
irisPCA <- prcomp(t(iris[,1:4]))
Pcomponents_iris <-irisPCA$rotation
plot(Pcomponents_iris[,1],Pcomponents_iris[,2], col = iris[,5],
     xlab="PC1", ylab="PC2")

# MDS

fit <- cmdscale(corrDistObject,eig=TRUE, k=2)
x <- fit$points[,1]
y <- fit$points[,2]
colorLabel<-c()


# LDA
library(MASS)
model <- lda(Species~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, data = iris)
plot(model)

# t-SNE
library(tsne)

iris_tSNE <- tsne(iris[,1:4], k=2, perplexity = 30, max_iter=5000)
plot(iris_tSNE[,2], iris_tSNE[,1],col=iris[,5])

     

