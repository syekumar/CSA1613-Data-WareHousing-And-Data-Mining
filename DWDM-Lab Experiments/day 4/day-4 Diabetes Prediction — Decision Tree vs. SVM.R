if (!file.exists("diabetes.csv")) {
  download.file("https://raw.githubusercontent.com/jbrownlee/Datasets/master/pima-indians-diabetes.data.csv", "diabetes.csv")
}
df_diag <- read.csv("diabetes.csv", header = FALSE)
colnames(df_diag) <- c("Pregnancies", "Glucose", "BloodPressure", "SkinThickness", "Insulin", "BMI", "Pedigree", "Age", "Outcome")
df_diag$Outcome <- factor(df_diag$Outcome)

if (!require("caret")) install.packages("caret")
if (!require("e1071")) install.packages("e1071")
if (!require("rpart")) install.packages("rpart")
library(caret)
library(e1071)
library(rpart)

set.seed(42)
idx <- createDataPartition(df_diag$Outcome, p = 0.7, list = FALSE)
train <- df_diag[idx, ]
test  <- df_diag[-idx, ]

# 1. Decision Tree Model
dt <- rpart(Outcome ~ ., data = train, method = "class")
dt_p <- predict(dt, test, type = "class")
cm_dt <- confusionMatrix(dt_p, test$Outcome, positive = "1")

# 2. SVM Model
svm_m <- svm(Outcome ~ ., data = train)
svm_p <- predict(svm_m, test)
cm_svm <- confusionMatrix(svm_p, test$Outcome, positive = "1")

# Results matrix
results <- data.frame(
  Metric = c("Accuracy", "F1 Score"),
  Decision_Tree = c(cm_dt$overall["Accuracy"], cm_dt$byClass["F1"]),
  SVM = c(cm_svm$overall["Accuracy"], cm_svm$byClass["F1"])
)
print(results)

# Barplot comparison
barplot(as.matrix(results[, 2:3]), main="Decision Tree vs SVM on Diabetes Data",
        beside=TRUE, col=c("skyblue", "orange"), legend.text=results$Metric, ylim=c(0, 1))