library(Rtsne)
library(ggplot2)
tsne <- Rtsne(A, check_duplicates = FALSE, pca = TRUE, dim = 2)
plot(tsne$Y, pch = 20, bg = c("red", "green", "blue", "blueviolet", "coral","darkcyan","violetred","orange","royalblue"))

