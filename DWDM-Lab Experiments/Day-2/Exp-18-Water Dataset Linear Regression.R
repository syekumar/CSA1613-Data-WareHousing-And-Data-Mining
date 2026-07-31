library(MASS)

data(water)

plot(water$hardness,
     water$mortality,
     xlab="Hardness",
     ylab="Mortality",
     main="Scatter Plot")

model <- lm(mortality~hardness,data=water)

abline(model,col="red")

predict(model,
        newdata=data.frame(hardness=88))