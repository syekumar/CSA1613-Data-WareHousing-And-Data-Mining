# Part (a): Theoretical Maximum Rules Calculation
d <- 6 # Unique items: Milk, Beer, Diapers, Bread, Butter, Cookies
max_rules <- 3^d - 2^(d+1) + 1
cat("Maximum possible association rules (theoretical):", max_rules, "\n")

# Part (b): Max size of frequent itemsets from data
if (!require("arules")) install.packages("arules")
library(arules)

tx_list2 <- list(
  c("Milk", "Beer", "Diapers"),
  c("Bread", "Butter", "Milk"),
  c("Milk", "Diapers", "Cookies"),
  c("Bread", "Butter", "Cookies"),
  c("Beer", "Cookies", "Diapers"),
  c("Milk", "Diapers", "Bread", "Butter"),
  c("Bread", "Butter", "Diapers"),
  c("Beer", "Diapers"),
  c("Milk", "Diapers", "Bread", "Butter"),
  c("Beer", "Cookies")
)

transactions2 <- as(tx_list2, "transactions")

# Find max size of frequent itemsets for any minsup > 0 (e.g., minsup = 1/10)
itemsets2 <- apriori(transactions2, parameter = list(supp = 1/10, target = "frequent itemsets"))
max_size <- max(size(itemsets2))
cat("Maximum size of frequent itemsets found:", max_size, "\n")