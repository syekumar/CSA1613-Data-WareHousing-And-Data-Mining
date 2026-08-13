# ============================================================
# Q4. COMPARISON OF MATHS CLASSES
# ============================================================


# ------------------------------------------------------------
# 1. Enter Class A Marks
# ------------------------------------------------------------

class_A <- c(
  76, 35, 47, 64, 95,
  66, 89, 36, 84
)


# ------------------------------------------------------------
# 2. Enter Class B Marks
# ------------------------------------------------------------

class_B <- c(
  51, 56, 84, 60, 59,
  70, 63, 66, 50
)


# ------------------------------------------------------------
# 3. Display Data
# ------------------------------------------------------------

cat("Class A Marks:\n")
print(class_A)

cat("\nClass B Marks:\n")
print(class_B)


# ------------------------------------------------------------
# 4. Calculate Mean
# ------------------------------------------------------------

mean_A <- mean(class_A)
mean_B <- mean(class_B)

cat("\nMean of Class A =", mean_A, "\n")
cat("Mean of Class B =", mean_B, "\n")


# ------------------------------------------------------------
# 5. Calculate Median
# ------------------------------------------------------------

median_A <- median(class_A)
median_B <- median(class_B)

cat("\nMedian of Class A =", median_A, "\n")
cat("Median of Class B =", median_B, "\n")


# ------------------------------------------------------------
# 6. Calculate Range
# ------------------------------------------------------------

range_A <- diff(range(class_A))
range_B <- diff(range(class_B))

cat("\nRange of Class A =", range_A, "\n")
cat("Range of Class B =", range_B, "\n")


# ------------------------------------------------------------
# 7. Display Minimum and Maximum
# ------------------------------------------------------------

cat("\nClass A Minimum =", min(class_A), "\n")
cat("Class A Maximum =", max(class_A), "\n")

cat("\nClass B Minimum =", min(class_B), "\n")
cat("Class B Maximum =", max(class_B), "\n")


# ------------------------------------------------------------
# 8. Summary Statistics
# ------------------------------------------------------------

cat("\nSummary of Class A:\n")
print(summary(class_A))

cat("\nSummary of Class B:\n")
print(summary(class_B))


# ------------------------------------------------------------
# 9. Compare Mean
# ------------------------------------------------------------

if (mean_A > mean_B) {
  cat("\nClass A has the higher mean.\n")
} else if (mean_B > mean_A) {
  cat("\nClass B has the higher mean.\n")
} else {
  cat("\nBoth classes have the same mean.\n")
}


# ------------------------------------------------------------
# 10. Compare Median
# ------------------------------------------------------------

if (median_A > median_B) {
  cat("Class A has the higher median.\n")
} else if (median_B > median_A) {
  cat("Class B has the higher median.\n")
} else {
  cat("Both classes have the same median.\n")
}


# ------------------------------------------------------------
# 11. Compare Range
# ------------------------------------------------------------

if (range_A > range_B) {
  cat("Class A has the larger range.\n")
} else if (range_B > range_A) {
  cat("Class B has the larger range.\n")
} else {
  cat("Both classes have the same range.\n")
}


# ------------------------------------------------------------
# 12. Create Combined Dataset
# ------------------------------------------------------------

marks <- c(
  class_A,
  class_B
)

class_name <- c(
  rep("Class A", length(class_A)),
  rep("Class B", length(class_B))
)

box_data <- data.frame(
  Class = class_name,
  Marks = marks
)

print(box_data)


# ------------------------------------------------------------
# 13. Draw Box Plot
# ------------------------------------------------------------

boxplot(
  class_A,
  class_B,
  names = c("Class A", "Class B"),
  main = "Comparison of Class A and Class B",
  xlab = "Class",
  ylab = "Exam Marks"
)


# ------------------------------------------------------------
# 14. Draw Horizontal Box Plot
# ------------------------------------------------------------

boxplot(
  class_A,
  class_B,
  names = c("Class A", "Class B"),
  horizontal = TRUE,
  main = "Box Plot Comparison",
  xlab = "Exam Marks"
)