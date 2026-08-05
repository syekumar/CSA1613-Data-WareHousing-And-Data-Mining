library(e1071)
library(caret)

# Using built-in Iris dataset as categorical classification standard
data(iris)

set.seed(123)
train_idx <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
train <- iris[train_idx, ]
test <- iris[-train_idx, ]

# 1. Naïve Bayes
nb_model <- naiveBayes(Species ~ ., data = train)
nb_preds <- predict(nb_model, test)
nb_cm <- confusionMatrix(nb_preds, test$Species)

# 2. SVM
svm_model <- svm(Species ~ ., data = train, kernel = "radial")
svm_preds <- predict(svm_model, test)
svm_cm <- confusionMatrix(svm_preds, test$Species)

# Compare Accuracies
cat("Naïve Bayes Accuracy:", nb_cm$overall['Accuracy'], "\n")
cat("SVM Accuracy:", svm_cm$overall['Accuracy'], "\n")

# Barplot comparison
accuracies <- c(NaïveBayes = nb_cm$overall['Accuracy'], SVM = svm_cm$overall['Accuracy'])
barplot(accuracies, col = c("skyblue", "salmon"), ylim = c(0, 1), main = "Classifier Accuracy Comparison")