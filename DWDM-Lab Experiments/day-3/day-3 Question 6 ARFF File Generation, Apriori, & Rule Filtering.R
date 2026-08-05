if (!require("arules")) install.packages("arules")
library(arules)

# 1. Create and save ARFF format dataset
arff_content <- "@relation market_basket

@attribute Hot_Dogs {0, 1}
@attribute Buns {0, 1}
@attribute Ketchup {0, 1}
@attribute Coke {0, 1}
@attribute Chips {0, 1}

@data
1,1,1,0,0
1,1,0,0,0
1,0,0,1,1
0,0,0,1,1
0,0,1,0,1
1,0,0,1,1
"
writeLines(arff_content, "dataset.arff")

# 2. Frequent Itemset and Association Rules Analysis
tx_food <- list(
  c("Hot Dogs", "Buns", "Ketchup"),
  c("Hot Dogs", "Buns"),
  c("Hot Dogs", "Coke", "Chips"),
  c("Chips", "Coke"),
  c("Chips", "Ketchup"),
  c("Hot Dogs", "Coke", "Chips")
)

trans_food <- as(tx_food, "transactions")

# Run Apriori: min_sup = 0.3333, min_conf = 0.60
rules_food <- apriori(trans_food, 
                      parameter = list(supp = 0.3333, conf = 0.60, target = "rules"))

# Display rules and status
rules_df <- as(rules_food, "data.frame")
rules_df$Status <- ifelse(rules_df$confidence >= 0.60 & rules_df$support >= 0.3333, "Accepted", "Rejected")

print(rules_df)