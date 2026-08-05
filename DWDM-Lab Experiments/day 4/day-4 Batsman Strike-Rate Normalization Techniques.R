rates <- c(100, 70, 60, 90, 90)

# (a) Min-Max Normalization (min=0, max=1)
min_val <- min(rates)
max_val <- max(rates)
min_max_norm <- (rates - min_val) / (max_val - min_val)
cat("(a) Min-Max Normalization:\n", min_max_norm, "\n\n")

# (b) Z-Score Normalization
z_score_norm <- (rates - mean(rates)) / sd(rates)
cat("(b) Z-Score Normalization:\n", z_score_norm, "\n\n")

# (c) Z-Score Normalization using Mean Absolute Deviation (MAD)
mad_val <- mean(abs(rates - mean(rates)))
z_score_mad <- (rates - mean(rates)) / mad_val
cat("(c) Z-Score Normalization (using MAD):\n", z_score_mad, "\n\n")

# (d) Normalization by Decimal Scaling
j <- ceiling(log10(max(abs(rates))))
decimal_scaled <- rates / (10^j)
cat("(d) Decimal Scaling Normalization:\n", decimal_scaled, "\n")