library(cluster)
A_cluster <- A[,-8]
metrics <- c("manhattan","euclidean")
methods <- c("average","complete","single")
best <- agnes(A_cluster, metric = "euclidean", stand = FALSE, method = "average")
min = 1
metrica = ""
methed = ""

for(i in metrics){
  for(j in methods ){
    agn <- agnes(A_cluster, metric = i, stand = FALSE, method = j)
    groups <- cutree(agn, k = 5)
    t <- table(groups, A[, 9])
    
    if((sum(diag(t)) / sum(t)) < min){
      min <- sum(diag(t)) / sum(t)
      best <- agn
      metrica <- i
      methed <- j 
    }
  } 
}


plot(best)
print(paste("metric: ",metrica))
print(paste("method: ",methed))
print(min)

