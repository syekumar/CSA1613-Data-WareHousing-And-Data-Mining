# Install required package if not present
if (!require("arules")) install.packages("arules", dependencies=TRUE)
library(arules)

# Create transaction list
tx_list1 <- list(
  c("a", "d", "e"),
  c("a", "b", "c", "e"),
  c("a", "b", "d", "e"),
  c("a", "c", "d", "e"),
  c("b", "c", "e"),
  c("b", "d", "e"),
  c("c", "d"),
  c("a", "b", "c"),
  c("a", "d", "e"),
  c("a", "b", "e")
)

# Convert to transactions class
transactions1 <- as(tx_list1, "transactions")

# 1. Apriori Algorithm
apriori_rules1 <- apriori(transactions1, 
                          parameter = list(supp = 3/10, conf = 0.50, target = "rules"))
inspect(apriori_rules1)

# Frequent Itemsets (used in FP-Growth analysis)
frequent_itemsets1 <- apriori(transactions1, 
                              parameter = list(supp = 3/10, target = "frequent itemsets"))
inspect(frequent_itemsets1)