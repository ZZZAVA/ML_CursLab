distances <- list(1,2,3,4,5)
men <- 1
index <-0
fit.park2 <-train.kknn(
  status ~ .,
  train,
  kmax = floor(sqrt(dim(train)[1] + 5)),
  kernel = c(
    "triangular",
    "epanechnikov",
    "biweight",
    "triweight",
    "inv",
    "gaussian",
    "rank" ,
    "optimal"
  ),
  distance = 1
)
for (i in distances) {
  fit.park1<-
    train.kknn(
      status ~ .,
      train,
      kmax = floor(sqrt(dim(train)[1] + 5)),
      kernel = c(
        "triangular",
        "epanechnikov",
        "biweight",
        "triweight",
        "inv",
        "gaussian",
        "rank" ,
        "optimal"
      ),
      distance = i
    )
  if(min(fit.park1$MEAN.SQU) < men) { 
    men= min(fit.park1$MEAN.SQU) 
    fit.park2<-fit.park1
    index <- i
  }
}	
print(fit.park2)
print(paste("distance: ", as.character(index)))
plot(fit.park2,cex = 0.5)

