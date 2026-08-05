# 1. Create Dataset & Save to CSV
emp_data <- data.frame(
  EmployeID = c(111, 222, 333, 444, 555, 666),
  Gender = c("Male", "Male", "Female", "Female", "Female", "Male"),
  Age = c(28, 25, 26, 25, 30, 29),
  Salary = c(150000, 150000, 160000, 160000, 170000, 200000),
  Credit = c(39, 27, 42, 40, 64, 72)
)
write.csv(emp_data, "employee_data.csv", row.names = FALSE)

# 2. Perform K-Means with varying cluster sizes (e.g., k = 2 and k = 3)
set.seed(42)
emp_features <- scale(emp_data[, c("Salary", "Credit")])

# k = 2
km_2 <- kmeans(emp_features, centers = 2)
# k = 3
km_3 <- kmeans(emp_features, centers = 3)

# 3. Plot clusters
par(mfrow = c(1, 2))
plot(emp_data$Salary, emp_data$Credit, col = km_2$cluster, pch = 19, 
     main = "K-Means (k=2)", xlab = "Salary", ylab = "Credit")
plot(emp_data$Salary, emp_data$Credit, col = km_3$cluster, pch = 19, 
     main = "K-Means (k=3)", xlab = "Salary", ylab = "Credit")