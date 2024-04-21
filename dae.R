library(DAAG)

library(ggplot2)
library(dplyr)
library(plotly)

library(FactoMineR)
library(factoextra)
library(tensorflow)

#Define Dataset 
ais <-     read.table("parkinsons.data",
header = TRUE,
sep = ",",
na.strings = "?")
ais <- ais[order(runif(dim(ais)[1])), ]
ais<-ais[-1]
head(ais[-1])


minmax <- function(x) (x - min(x))/(max(x) - min(x))
x_train <- apply(ais[,1:11], 2, minmax)

# PCA
pca <- prcomp(x_train)

##Scree plot
fviz_screeplot(pca, ncp=10)

# autoencoder in keras
library(keras)
# set training data
x_train <- as.matrix(x_train)
# set model
model <- keras_model_sequential()
model %>%
  layer_dense(units = 6, activation = "tanh", input_shape = ncol(x_train)) %>%
  layer_dense(units = 2, activation = "tanh", name = "bottleneck") %>%
  layer_dense(units = 6, activation = "tanh") %>%
  layer_dense(units = ncol(x_train))
# view model layers
summary(model)

