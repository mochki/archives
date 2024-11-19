rm(list=ls())
(clear <- function() {cat("\014")})()
setwd("~/R Studio")
library(datasets)
library(cluster)

# let's just see what this looks like
dset <- state.x77
distance <- dist(as.matrix(dset))
hc <- hclust(distance)
plot(hc)

# scaled version
dset <- state.x77
dset <- scale(dset)
attr(dset,"scaled:center")<-NULL 
attr(dset,"scaled:scale")<-NULL
distance <- dist(as.matrix(dset))
hc <- hclust(distance)
plot(hc)

# Okay, so let's remove area from the dataset
dset <- state.x77
dset <- scale(dset)
attr(dset,"scaled:center")<-NULL 
attr(dset,"scaled:scale")<-NULL
distance <- dist(as.matrix(dset[,-8]))
hc <- hclust(distance)
plot(hc)

# How about just on frost?
dset <- state.x77
dset <- scale(dset)
attr(dset,"scaled:center")<-NULL 
attr(dset,"scaled:scale")<-NULL
distance <- dist(as.matrix(dset[,-c(1:6, 8)]))
hc <- hclust(distance)
plot(hc)

# How about... Illteracy & HS grad?
dset <- state.x77
dset <- scale(dset)
attr(dset,"scaled:center")<-NULL 
attr(dset,"scaled:scale")<-NULL
distance <- dist(as.matrix(dset[,-c(1, 2, 4, 5, 7, 8)]))
hc <- hclust(distance)
plot(hc)

# How about... Income?
dset <- state.x77
dset <- scale(dset)
attr(dset,"scaled:center")<-NULL 
attr(dset,"scaled:scale")<-NULL
distance <- dist(as.matrix(dset[,-c(1, 3:8)]))
hc <- hclust(distance)
plot(hc)

# Let's start on k-means
dset <- state.x77
dset <- scale(dset)
attr(dset,"scaled:center")<-NULL 
attr(dset,"scaled:scale")<-NULL
clst <- kmeans(dset, 3)
print(clst$size)
print(clst$centers)

# Let's find elbow k
dset <- state.x77
dset <- scale(dset)
attr(dset,"scaled:center")<-NULL 
attr(dset,"scaled:scale")<-NULL
table = NULL;
for (i in 1:25) {
  clst <- kmeans(dset, i)
  table[i] = sum(clst$withinss)
}
plot(table)

# We have definitively decided that k=5
dset <- state.x77
dset <- scale(dset)
attr(dset,"scaled:center")<-NULL 
attr(dset,"scaled:scale")<-NULL
clst <- kmeans(dset, 5)
seps <- clst$cluster
clusplot(dset, clst$cluster)