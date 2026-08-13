# ============================================================
# Q2. BOX PLOT FOR TENNIS PLAYERS' SCORES
# ============================================================

# Player IDs
player_id <- c(
  "P1", "P2", "P3", "P4", "P5",
  "P6", "P7", "P8", "P9", "P10",
  "P11", "P12", "P13", "P14", "P15"
)

# Player names
player_name <- c(
  "Player A", "Player B", "Player C", "Player D", "Player E",
  "Player F", "Player G", "Player H", "Player I", "Player J",
  "Player K", "Player L", "Player M", "Player N", "Player O"
)

# Points scored
points <- c(
  12, 15, 14, 10, 18,
  20, 22, 13, 11, 35,
  16, 17, 19, 21, 23
)

# Create data frame
players <- data.frame(
  Player_ID = player_id,
  Player_Name = player_name,
  Points = points
)

# Display data
print(players)


# ------------------------------------------------------------
# 1. Summary Statistics
# ------------------------------------------------------------

cat("\nSummary Statistics:\n")
print(summary(points))


# ------------------------------------------------------------
# 2. Mean
# ------------------------------------------------------------

mean_points <- mean(points)

cat("\nMean =", mean_points, "\n")


# ------------------------------------------------------------
# 3. Median
# ------------------------------------------------------------

median_points <- median(points)

cat("Median =", median_points, "\n")


# ------------------------------------------------------------
# 4. Quartiles
# ------------------------------------------------------------

Q1 <- quantile(points, 0.25)
Q3 <- quantile(points, 0.75)

cat("Q1 =", Q1, "\n")
cat("Q3 =", Q3, "\n")


# ------------------------------------------------------------
# 5. Interquartile Range
# ------------------------------------------------------------

IQR_value <- IQR(points)

cat("IQR =", IQR_value, "\n")


# ------------------------------------------------------------
# 6. Find Outlier Limits
# ------------------------------------------------------------

lower_limit <- Q1 - 1.5 * IQR_value
upper_limit <- Q3 + 1.5 * IQR_value

cat("Lower Outlier Limit =", lower_limit, "\n")
cat("Upper Outlier Limit =", upper_limit, "\n")


# ------------------------------------------------------------
# 7. Identify Outliers
# ------------------------------------------------------------

outliers <- points[
  points < lower_limit | points > upper_limit
]

cat("\nOutlier Values:\n")
print(outliers)


# ------------------------------------------------------------
# 8. Identify Player with Outlier Score
# ------------------------------------------------------------

outlier_players <- players[
  players$Points < lower_limit |
    players$Points > upper_limit,
]

cat("\nOutlier Players:\n")
print(outlier_players)


# ------------------------------------------------------------
# 9. Draw Box Plot
# ------------------------------------------------------------

boxplot(
  points,
  main = "Box Plot of Tennis Players' Scores",
  ylab = "Points Scored",
  xlab = "Tennis Players"
)


# ------------------------------------------------------------
# 10. Horizontal Box Plot
# ------------------------------------------------------------

boxplot(
  points,
  horizontal = TRUE,
  main = "Box Plot of Points Scored",
  xlab = "Points Scored"
)