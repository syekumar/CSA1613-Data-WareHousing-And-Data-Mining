# Write ARFF File
arff_electronics <- "@relation electronics

@attribute SONY {0, 1}
@attribute BPL {0, 1}
@attribute LG {0, 1}
@attribute SAMSUNG {0, 1}
@attribute ONIDA {0, 1}

@data
1,1,1,0,0
0,1,0,1,0
0,1,0,0,1
1,1,0,1,0
1,0,0,0,1
0,1,0,0,1
1,0,0,0,1
1,1,1,0,1
1,1,0,0,1
"
writeLines(arff_electronics, "electronics.arff")

# Apriori / Rule Extraction
if (!require("arules")) install.packages("arules")
library(arules)

tx_elec <- list(
  c("SONY", "BPL", "LG"),
  c("BPL", "SAMSUNG"),
  c("BPL", "ONIDA"),
  c("SONY", "BPL", "SAMSUNG"),
  c("SONY", "ONIDA"),
  c("BPL", "ONIDA"),
  c("SONY", "ONIDA"),
  c("SONY", "BPL", "ONIDA", "LG"),
  c("SONY", "BPL", "ONIDA")
)

trans_elec <- as(tx_elec, "transactions")

# Min Support = 2 / 9 = ~0.2222, Min Confidence = 0.50
rules_elec <- apriori(trans_elec, parameter = list(supp = 2/9, conf = 0.50, target = "rules"))

cat("Unique and Extracted Association Rules:\n")
inspect(unique(rules_elec))