# Prepare Sample Dataset
data1 <- data.frame(
  CustomerID = c(1, 12, 23, 34, 45),
  Gender = c("Male", "Male", "Female", "Female", "Female"),
  Age = c(19, 21, 20, 23, 31),
  AnnualIncome = c(15, 15, 16, 16, 17),
  SpendingScore = c(39, 81, 6, 77, 40)
)

# Extract features
features <- data1[, c("AnnualIncome", "SpendingScore")]

# Set k = 3 instead of 5 for a 5-row sample dataset
set.seed(123)
kmeans_res <- kmeans(features, centers = 3, nstart = 20)

# Assign cluster labels
data1$Cluster <- as.factor(kmeans_res$cluster)
print(data1)

# Visualization
library(ggplot2)
ggplot(data1, aes(x = AnnualIncome, y = SpendingScore, color = Cluster)) +
  geom_point(size = 4) +
  theme_minimal() +
  labs(title = "Customer Segmentation", x = "Annual Income (k$)", y = "Spending Score (1-100)")