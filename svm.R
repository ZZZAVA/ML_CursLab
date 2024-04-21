vals <- 1:20
kernels <- list("sigmoid","polynomial","radial")


v_cost_best <- double(20)
v_miss_best <- double(20)
kern = ""
v_cost <- double(20)
v_miss <- double(20)
min = 1
for(k in kernels){
  
  for (i in vals)
  {
    svmModel = svm(
      status ~ .,
      data = train,
      type = "C-classification",
      cost = i,
      kernel = k
    )
    
    predictionTest = predict(svmModel, test)
    res = table(test$status, predictionTest)
    table(test$status, predictionTest)
    v_miss[i] = (res[2] + res[3]) / (res[1] + res[2] + res[3] + res[4])
    v_cost[i] = i
  }
  if(min(v_miss) < min) {
    min = min(v_miss)
    v_cost_best = v_cost
    v_miss_best = v_miss
    kern =  k
  }
}

plot(v_cost_best,
     v_miss_best,
     type = "o",
     xlab = "Cost",
     ylab = "Error")

print(paste("kernel: ", kern))
print(paste ("Minimal error in % : ",min(v_miss_best)))

