marks <- c(55, 60, 71, 63, 55, 65, 50, 55, 58, 59, 61, 63, 65, 67, 71, 72, 75)

# Plot histogram
hist(marks, col = "lightblue", main = "Histogram of Marks Scored", xlab = "Marks", breaks = 5)

# (a) Equal-Frequency Partitioning
quantiles <- quantile(marks, probs = seq(0, 1, length.out = 4))
bin_eq_freq <- cut(marks, breaks = quantiles, include.lowest = TRUE)
cat("(a) Equal-Frequency Partitioning:\n")
print(table(bin_eq_freq))

# (b) Equal-Width Partitioning
bin_eq_width <- cut(marks, breaks = 3)
cat("\n(b) Equal-Width Partitioning:\n")
print(table(bin_eq_width))

# (c) Clustering Partitioning (K-Means K=3)
set.seed(42)
km_marks <- kmeans(marks, centers = 3)
cat("\n(c) Clustering Partitioning (Cluster Centers):\n")
print(km_marks$centers)