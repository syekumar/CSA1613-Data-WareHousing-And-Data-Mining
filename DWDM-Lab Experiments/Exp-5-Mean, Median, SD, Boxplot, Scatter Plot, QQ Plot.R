age <- c(23,27,39,41,47,49,50,52,54,54,56,57,58,58,60,61,63,65)

fat <- c(9.5,26.5,7.8,17.8,31.4,36.1,19.6,28.8,
         31.1,30.2,31.6,30.5,23.2,26.7,25.2,27.8,29.5,30.2)

mean(age)
median(age)
sd(age)

mean(fat)
median(fat)
sd(fat)

boxplot(age,fat,names=c("Age","Fat"))

plot(age,fat,
     main="Scatter Plot",
     xlab="Age",
     ylab="Body Fat")

qqnorm(age)
qqline(age)

qqnorm(fat)
qqline(fat)