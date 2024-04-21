library(glmnet)
x <- as.matrix(A[,1:8])
y <- as.numeric(as.factor(A[,9]))
glm <- cv.glmnet(x,y,family="poisson",nlambda =5,alpha =1)
predict(glm,type="coef", s = 0.002)

