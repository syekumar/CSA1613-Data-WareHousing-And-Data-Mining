# Define vectors
x <- c(4, 1, 5, 7, 10, 2, 50, 25, 90, 36) # Mobile phones sold
y <- c(12, 5, 13, 19, 31, 7, 153, 72, 275, 110) # Money

# Scatter plot
plot(x, y, 
     main = "Scatter Plot: Mobile Phones Sold vs Money",
     xlab = "Number of Mobile Phones Sold (X)",
     ylab = "Money (Y)",
     col = "blue", pch = 19, cex = 1.3)
grid()