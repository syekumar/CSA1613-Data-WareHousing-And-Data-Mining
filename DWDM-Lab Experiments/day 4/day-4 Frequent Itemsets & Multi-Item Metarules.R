if (!require("arules")) install.packages("arules")
library(arules)

tx_metarule <- list(
  c("M", "O", "N", "K", "E", "Y"),
  c("D", "O", "N", "K", "E", "Y"),
  c("M", "A", "K", "E"),
  c("M", "U", "C", "K", "Y"),
  c("C", "O", "O", "K", "I", "E")
)

trans_metarule <- as(tx_metarule, "transactions")

# (a) Find Frequent Itemsets
freq_items <- apriori(trans_metarule, parameter = list(supp = 0.40, target = "frequent itemsets"))
cat("(a) Frequent Itemsets:\n")
inspect(freq_items)

# (b) Strong Rules Matching Metarule: buys(X, item1) AND buys(X, item2) => buys(X, item3)
all_rules <- apriori(trans_metarule, parameter = list(supp = 0.40, conf = 0.60, target = "rules"))

# Filter rules where LHS contains at least 2 items (length == 3 total rule size or lhs size == 2)
multi_item_rules <- subset(all_rules, size(lhs(all_rules)) >= 2)

cat("\n(b) Strong Rules matching 3-item Metarules:\n")
inspect(multi_item_rules)