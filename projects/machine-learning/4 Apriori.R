rm(list=ls())
(clear = function() {cat("\014")})()
setwd("~/R Studio")
install.packages("arules")
library(arules)
data(Groceries)

# Perhaps a personal choice, but I don't feel like any confidence that is less than 33% is worth much
rules <- apriori(Groceries, parameter = list(support = 0.006, confidence = 0.33, minlen = 2))
inspect(sort(rules, by = "support"))
inspect(sort(rules, by = "confidence"))
inspect(sort(rules, by = "lift"))


# These are interesting
rules <- apriori(Groceries, parameter = list(support = 0.005, confidence = 0.2, minlen = 2))
inspect(sort(rules, by = "confidence")[450:550])
inspect(rules)
