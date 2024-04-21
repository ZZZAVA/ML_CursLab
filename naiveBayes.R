install.packages("naivebayes")
library(naivebayes)

kernels <- list("gaussian", "epanechnikov", "rectangular","triangular",
                "biweight", "cosine", "optcosine")


for (k in kernels) {
  classifier_cl <- naive_bayes(factor(train$status) ~ ., data = train,usekernel = TRUE, kernel = k )
  y_pred <- predict(classifier_cl, newdata = test) 
  cm <- table(test$status, y_pred)	 
  print(paste("kernel: ", k))
  print(cm)
  print(paste("Error in % : ", 1 - sum(diag(cm)) / sum(cm)))
}

