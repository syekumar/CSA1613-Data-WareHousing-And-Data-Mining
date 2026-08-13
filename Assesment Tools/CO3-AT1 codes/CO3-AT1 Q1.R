# ============================================================
# Q1. AGE AND PHOTOGRAPH PREFERENCE
# ============================================================

# Create data
preference <- data.frame(
  A = c(18, 2, 20),
  B = c(22, 28, 10),
  C = c(20, 40, 40)
)

# Display data
print(preference)

# ------------------------------------------------------------
# 1. Covariance between Photograph B and Photograph C
# ------------------------------------------------------------

cov_B_C <- cov(preference$B, preference$C)

cat("Covariance between B and C =", cov_B_C, "\n")


# ------------------------------------------------------------
# 2. Covariance Matrix
# ------------------------------------------------------------

cov_matrix <- cov(preference)

cat("\nCovariance Matrix:\n")
print(cov_matrix)


# ------------------------------------------------------------
# 3. Correlation between Photograph B and Photograph C
# ------------------------------------------------------------

cor_B_C <- cor(preference$B, preference$C)

cat("\nCorrelation between B and C =", cor_B_C, "\n")


# ------------------------------------------------------------
# 4. Correlation Matrix
# ------------------------------------------------------------

cor_matrix <- cor(preference)

cat("\nCorrelation Matrix:\n")
print(cor_matrix)


# ------------------------------------------------------------
# 5. Chi-Square Test
#    Test relationship between age and photograph preference
# ------------------------------------------------------------

age_photo <- matrix(
  c(
    18, 22, 20,
    2, 28, 40,
    20, 10, 40
  ),
  nrow = 3,
  byrow = TRUE
)

# Add row and column names
rownames(age_photo) <- c(
  "5-6 Years",
  "7-8 Years",
  "9-10 Years"
)

colnames(age_photo) <- c(
  "Photo A",
  "Photo B",
  "Photo C"
)

cat("\nAge vs Photograph Preference Table:\n")
print(age_photo)


# Perform Chi-Square Test
chi_result <- chisq.test(age_photo)

cat("\nChi-Square Test Result:\n")
print(chi_result)


# ------------------------------------------------------------
# 6. Decision
# ------------------------------------------------------------

if (chi_result$p.value < 0.05) {
  cat("\nConclusion: There is a significant relationship")
  cat(" between age and photograph preference.\n")
} else {
  cat("\nConclusion: There is no significant relationship")
  cat(" between age and photograph preference.\n")
}