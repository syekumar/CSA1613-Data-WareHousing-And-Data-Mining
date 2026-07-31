# Data
A <- c(18,2,20)
B <- c(22,28,10)
C <- c(20,40,40)

# Data Frame
data <- data.frame(A,B,C)

# 1. Covariance between B and C
cov(B,C)

# 2. Covariance Matrix
cov(data)

# 3. Correlation between B and C
cor(B,C)

# 4. Correlation Matrix
cor(data)