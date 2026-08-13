# ============================================================
# Q3. DECISION TREE CLASSIFIER FOR LOAN APPROVAL
# ============================================================

# Install packages if required
# install.packages("rpart")
# install.packages("rpart.plot")

# Load libraries
library(rpart)
library(rpart.plot)


# ------------------------------------------------------------
# 1. Create Dataset
# ------------------------------------------------------------

loan_data <- data.frame(
  
  Age = c(
    "young",
    "young",
    "middle",
    "old",
    "old",
    "old",
    "middle",
    "young",
    "young",
    "old",
    "middle",
    "middle",
    "old",
    "young",
    "middle"
  ),
  
  Income = c(
    "high",
    "high",
    "high",
    "medium",
    "low",
    "low",
    "low",
    "medium",
    "low",
    "medium",
    "medium",
    "high",
    "medium",
    "medium",
    "low"
  ),
  
  Employment = c(
    "employed",
    "self-employed",
    "employed",
    "employed",
    "unemployed",
    "self-employed",
    "unemployed",
    "employed",
    "unemployed",
    "self-employed",
    "employed",
    "self-employed",
    "unemployed",
    "self-employed",
    "employed"
  ),
  
  Credit = c(
    "good",
    "average",
    "good",
    "good",
    "poor",
    "average",
    "poor",
    "average",
    "poor",
    "good",
    "average",
    "good",
    "poor",
    "average",
    "poor"
  ),
  
  Loan = c(
    "yes",
    "yes",
    "yes",
    "yes",
    "no",
    "no",
    "no",
    "yes",
    "no",
    "yes",
    "yes",
    "yes",
    "no",
    "yes",
    "no"
  )
)


# ------------------------------------------------------------
# 2. Display Dataset
# ------------------------------------------------------------

cat("Loan Dataset:\n")
print(loan_data)


# ------------------------------------------------------------
# 3. Convert Variables into Factors
# ------------------------------------------------------------

loan_data$Age <- factor(loan_data$Age)

loan_data$Income <- factor(loan_data$Income)

loan_data$Employment <- factor(
  loan_data$Employment
)

loan_data$Credit <- factor(
  loan_data$Credit
)

loan_data$Loan <- factor(
  loan_data$Loan
)


# ------------------------------------------------------------
# 4. Build Decision Tree Model
# ------------------------------------------------------------

model <- rpart(
  Loan ~ Age + Income + Employment + Credit,
  data = loan_data,
  method = "class"
)


# ------------------------------------------------------------
# 5. Display Model Summary
# ------------------------------------------------------------

cat("\nDecision Tree Model:\n")
print(model)


# ------------------------------------------------------------
# 6. Display Decision Tree
# ------------------------------------------------------------

rpart.plot(
  model,
  main = "Decision Tree for Loan Approval"
)


# ------------------------------------------------------------
# 7. Predict Loan Approval
# ------------------------------------------------------------

prediction <- predict(
  model,
  loan_data,
  type = "class"
)

cat("\nPredicted Loan Approval:\n")
print(prediction)


# ------------------------------------------------------------
# 8. Actual vs Predicted
# ------------------------------------------------------------

comparison <- data.frame(
  Actual = loan_data$Loan,
  Predicted = prediction
)

cat("\nActual vs Predicted:\n")
print(comparison)


# ------------------------------------------------------------
# 9. Confusion Matrix
# ------------------------------------------------------------

confusion_matrix <- table(
  Actual = loan_data$Loan,
  Predicted = prediction
)

cat("\nConfusion Matrix:\n")
print(confusion_matrix)


# ------------------------------------------------------------
# 10. Calculate Accuracy
# ------------------------------------------------------------

accuracy <- mean(
  prediction == loan_data$Loan
)

cat("\nAccuracy =", accuracy, "\n")

cat(
  "Accuracy Percentage =",
  accuracy * 100,
  "%\n"
)