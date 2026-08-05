# 1. Generate dataset based on given decision tree logic
set.seed(42)
n <- 100
height <- runif(n, 150, 200)
weight <- runif(n, 50, 100)

gender <- ifelse(height > 180, "Male", 
                 ifelse(weight > 80, "Male", "Female"))

df_tree <- data.frame(Height = height, Weight = weight, Gender = factor(gender))

# 2. Rule Induction Logic (Direct rule representation)
rule_predict <- function(h, w) {
  if (h > 180) return("Male")
  else if (w > 80) return("Male")
  else return("Female")
}

preds <- factor(mapply(rule_predict, df_tree$Height, df_tree$Weight))

# 3. Accuracy & Confusion Matrix
if (!require("caret")) install.packages("caret")
library(caret)

cm <- confusionMatrix(preds, df_tree$Gender)
print(cm)

# Plot Confusion Matrix
fourfoldplot(cm$table, color = c("#CC6666", "#99CC99"), main = "Confusion Matrix")