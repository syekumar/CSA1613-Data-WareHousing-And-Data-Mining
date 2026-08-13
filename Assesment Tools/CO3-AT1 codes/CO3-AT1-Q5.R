# ============================================================
# Q5. AGE AND BODY FAT ANALYSIS
# ============================================================

# Enter the data given in the question

age <- c(
  23, 23, 27, 27, 39, 41, 47, 49, 50,
  52, 54, 54, 56, 57, 58, 58, 60, 61
)

fat <- c(
  9.5, 26.5, 7.8, 17.8, 31.4, 25.9, 27.4, 27.2, 31.2,
  34.6, 42.5, 28.8, 33.4, 30.2, 34.1, 32.9, 41.2, 35.7
)


# ------------------------------------------------------------
# 1. Display the data
# ------------------------------------------------------------

data <- data.frame(
  Age = age,
  Body_Fat = fat
)

print(data)


# ------------------------------------------------------------
# 2. Mean
# ------------------------------------------------------------

mean_age <- mean(age)
mean_fat <- mean(fat)

cat("Mean Age =", mean_age, "\n")
cat("Mean Body Fat =", mean_fat, "\n")


# ------------------------------------------------------------
# 3. Median
# ------------------------------------------------------------

median_age <- median(age)
median_fat <- median(fat)

cat("Median Age =", median_age, "\n")
cat("Median Body Fat =", median_fat, "\n")


# ------------------------------------------------------------
# 4. Standard Deviation
# ------------------------------------------------------------

sd_age <- sd(age)
sd_fat <- sd(fat)

cat("Standard Deviation of Age =", sd_age, "\n")
cat("Standard Deviation of Body Fat =", sd_fat, "\n")


# ------------------------------------------------------------
# 5. Summary Statistics
# ------------------------------------------------------------

cat("\nSummary of Age:\n")
print(summary(age))

cat("\nSummary of Body Fat:\n")
print(summary(fat))


# ------------------------------------------------------------
# 6. Boxplot of Age
# ------------------------------------------------------------

boxplot(
  age,
  main = "Boxplot of Age",
  ylab = "Age",
  xlab = "Age"
)


# ------------------------------------------------------------
# 7. Boxplot of Body Fat
# ------------------------------------------------------------

boxplot(
  fat,
  main = "Boxplot of Body Fat",
  ylab = "% Body Fat",
  xlab = "% Fat"
)


# ------------------------------------------------------------
# 8. Combined Boxplot
# ------------------------------------------------------------

boxplot(
  age,
  fat,
  names = c("Age", "% Fat"),
  main = "Boxplot of Age and Body Fat"
)


# ------------------------------------------------------------
# 9. Scatter Plot
# ------------------------------------------------------------

plot(
  age,
  fat,
  main = "Scatter Plot: Age vs Body Fat",
  xlab = "Age",
  ylab = "% Body Fat",
  pch = 19
)


# ------------------------------------------------------------
# 10. Add Regression Line
# ------------------------------------------------------------

model <- lm(fat ~ age)

abline(
  model,
  lty = 2
)


# ------------------------------------------------------------
# 11. Correlation
# ------------------------------------------------------------

correlation <- cor(age, fat)

cat(
  "\nCorrelation between Age and Body Fat =",
  correlation,
  "\n"
)


# ------------------------------------------------------------
# 12. Q-Q Plot for Age
# ------------------------------------------------------------

qqnorm(
  age,
  main = "Q-Q Plot of Age"
)

qqline(age)


# ------------------------------------------------------------
# 13. Q-Q Plot for Body Fat
# ------------------------------------------------------------

qqnorm(
  fat,
  main = "Q-Q Plot of Body Fat"
)

qqline(fat)


# ------------------------------------------------------------
# 14. Detect Age Outliers
# ------------------------------------------------------------

age_outliers <- boxplot.stats(age)$out

cat("\nAge Outliers:\n")
print(age_outliers)


# ------------------------------------------------------------
# 15. Detect Body Fat Outliers
# ------------------------------------------------------------

fat_outliers <- boxplot.stats(fat)$out

cat("\nBody Fat Outliers:\n")
print(fat_outliers)


# ------------------------------------------------------------
# 16. Final Results
# ------------------------------------------------------------

cat("\n========================================\n")
cat("          FINAL RESULTS - Q5\n")
cat("========================================\n")

cat("Mean Age =", mean_age, "\n")
cat("Median Age =", median_age, "\n")
cat("SD of Age =", sd_age, "\n")

cat("\nMean Body Fat =", mean_fat, "\n")
cat("Median Body Fat =", median_fat, "\n")
cat("SD of Body Fat =", sd_fat, "\n")

cat("\nCorrelation =", correlation, "\n")

cat("========================================\n")