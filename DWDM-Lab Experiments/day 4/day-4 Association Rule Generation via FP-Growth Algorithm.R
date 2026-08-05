if (!require("arules")) install.packages("arules")
library(arules)

tx_grocery <- list(
  c("Bread", "Cheese", "Egg", "Juice"),
  c("Bread", "Cheese", "Juice"),
  c("Bread", "Milk", "Yogurt"),
  c("Bread", "Juice", "Milk"),
  c("Cheese", "Juice", "Milk")
)

trans_grocery <- as(tx_grocery, "transactions")

# Extract rules: supp = 0.50, conf = 0.75
rules_grocery <- apriori(trans_grocery, 
                         parameter = list(supp = 0.50, conf = 0.75, target = "rules"))

cat("Generated Association Rules:\n")
inspect(rules_grocery)