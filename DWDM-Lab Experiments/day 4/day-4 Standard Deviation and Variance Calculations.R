avg_speed <- c(78, 81, 82, 74, 83, 82, 77, 80, 70)
total_time <- c(39, 37, 36, 42, 35, 36, 40, 38, 46)

# (a) Standard Deviation
sd_speed <- sd(avg_speed)
sd_time  <- sd(total_time)

cat("a) Standard Deviation:\n")
cat("   AvgSpeed Standard Deviation:", sd_speed, "\n")
cat("   TotalTime Standard Deviation:", sd_time, "\n\n")

# (b) Variance
var_speed <- var(avg_speed)
var_time  <- var(total_time)

cat("b) Variance:\n")
cat("   AvgSpeed Variance:", var_speed, "\n")
cat("   TotalTime Variance:", var_time, "\n")