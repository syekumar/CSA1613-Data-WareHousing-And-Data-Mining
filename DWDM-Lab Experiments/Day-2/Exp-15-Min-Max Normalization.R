# Min-Max Normalization Example (Value = 80000)
v <- 80000
min_val <- 50000
max_val <- 100000

minmax_value <- (v - min_val) / (max_val - min_val)
cat("Min-Max Normalized value of 80000 =", minmax_value, "\n\n")

# Data for Normalization
x <- c(200, 300, 400, 600, 1000)

# Min-Max Normalization (Range 0 to 1)
minmax <- (x - min(x)) / (max(x) - min(x))
cat("Min-Max Normalization:\n")
print(minmax)

# Z-Score Normalization
zscore <- (x - mean(x)) / sd(x)
cat("\nZ-Score Normalization:\n")
print(zscore)