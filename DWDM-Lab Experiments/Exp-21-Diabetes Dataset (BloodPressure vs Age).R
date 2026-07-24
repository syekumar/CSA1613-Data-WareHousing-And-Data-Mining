data <- read.csv("diabetes.csv")

# Scatter Plot
plot(data$Age,
     data$BloodPressure,
     col="blue",
     pch=19,
     xlab="Age",
     ylab="Blood Pressure",
     main="Blood Pressure vs Age")

# Bar Chart
bp <- tapply(data$BloodPressure,
             data$Age,
             mean)

barplot(bp,
        col="green",
        xlab="Age",
        ylab="Average Blood Pressure",
        main="Average Blood Pressure by Age")