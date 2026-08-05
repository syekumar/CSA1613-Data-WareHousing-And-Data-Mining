if (!require("e1071")) install.packages("e1071")
if (!require("rpart")) install.packages("rpart")
if (!require("rpart.plot")) install.packages("rpart.plot")

library(e1071)
library(rpart)
library(rpart.plot)

# Define dataset
df_computer <- data.frame(
  age = factor(c("<=30", "<=30", "31...40", ">40", ">40", ">40", "31...40", "<=30", "<=30", ">40", "<=30", "31...40", "31...40", ">40")),
  income = factor(c("high", "high", "high", "medium", "low", "low", "low", "medium", "low", "medium", "medium", "medium", "high", "medium")),
  student = factor(c("no", "no", "no", "no", "yes", "yes", "yes", "no", "yes", "yes", "yes", "no", "yes", "no")),
  credit_rating = factor(c("fair", "excellent", "fair", "fair", "fair", "excellent", "excellent", "fair", "fair", "fair", "excellent", "excellent", "fair", "excellent")),
  buys_computer = factor(c("no", "no", "yes", "yes", "yes", "no", "yes", "no", "yes", "yes", "yes", "yes", "yes", "no"))
)

# Train/Test Split (80/20 train/test)
set.seed(42)
train_idx <- sample(1:nrow(df_computer), 0.8 * nrow(df_computer))
train_data <- df_computer[train_idx, ]
test_data  <- df_computer[-train_idx, ]

# 1. Naive Bayes Model
nb_model <- naiveBayes(buys_computer ~ ., data = train_data)
nb_preds <- predict(nb_model, test_data)
cat("Naive Bayes Predictions:\n")
print(nb_preds)

# 2. Decision Tree Model
dt_model <- rpart(buys_computer ~ ., data = train_data, method = "class")
dt_preds <- predict(dt_model, test_data, type = "class")
cat("\nDecision Tree Predictions:\n")
print(dt_preds)

# Plot Decision Tree
rpart.plot(dt_model, main="Decision Tree for Buys Computer")