rm(list=ls())
(clear <- function() {cat("\014")})()
setwd("~/R Studio")
install.packages("igraph")
library(igraph)

dset <- read.csv("Mommy_blogLinks_tiny.csv", header = FALSE)
dset <- read.csv("Mommy_blogLinks.csv", header = FALSE)
dset <- read.csv("Mommy_twitterMentions.csv", header = FALSE)

# Reading an edge list
mommy.graph <- graph.data.frame(dset)
mommy.graph <- graph.data.frame(dset, directed = FALSE)

# Plot a simple graph
layout1 = layout.fruchterman.reingold(mommy.graph)
layout2 = layout.auto(mommy.graph)
layout3 = layout.davidson.harel(mommy.graph)
layout4 = layout.circle(mommy.graph)
layout5 = layout.drl(mommy.graph)
layout6 = layout.gem(mommy.graph)
layout7 = layout.graphopt(mommy.graph)
plot(mommy.graph, layout=layout7)

# Compute density
graph.density(mommy.graph)

# Compute centralization measures for all nodes in the graph
dc = centralization.degree(mommy.graph)
cc = centralization.closeness(mommy.graph)
bc = centralization.betweenness(mommy.graph)

dc$res[which.max(dc$res)]
cc$res[which.max(cc$res)]
bc$res[which.max(bc$res)]

unique(get.data.frame(mommy.graph)[,1])[which.max(dc$res)]
unique(get.data.frame(mommy.graph)[,1])[which.max(cc$res)]
unique(get.data.frame(mommy.graph)[,1])[which.max(bc$res)]
