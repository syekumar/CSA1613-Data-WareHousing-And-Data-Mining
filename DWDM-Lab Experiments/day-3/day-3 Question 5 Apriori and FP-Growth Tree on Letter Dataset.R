if (!require("arules")) install.packages("arules")
library(arules)

tx_letters <- list(
  c("M", "O", "N", "K", "E", "Y"),
  c("D", "O", "N", "K", "E", "Y"),
  c("M", "A", "K", "E"),
  c("M", "U", "C", "K", "Y"),
  c("C", "O", "O", "K", "I", "E")
)

trans_letters <- as(tx_letters, "transactions")

# Minimum support = 50% (2 / 5)
frequent_itemsets <- apriori(trans_letters, 
                             parameter = list(supp = 2/5, conf = 0.80, target = "frequent itemsets"))

cat("Frequent Itemsets:\n")
inspect(frequent_itemsets)

# Generate Rules (Min Conf = 80%)
letter_rules <- apriori(trans_letters, 
                        parameter = list(supp = 2/5, conf = 0.80, target = "rules"))
cat("\nGenerated Rules:\n")
inspect(letter_rules)