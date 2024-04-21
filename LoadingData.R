library(e1071)
library(kknn)

A <-
  read.table(
    "parkinsons.data",
    header = TRUE,
    sep = ",",
    na.strings = "?"
  )
set.seed(2345)
A <- A[order(runif(dim(A)[1])), ]
A<-A[-1]
nt <- as.integer(dim(A)[1] * 0.7)
print(nt)
train <- A[1:nt, ]
test <- A[(nt + 1):dim(A)[1], ]

