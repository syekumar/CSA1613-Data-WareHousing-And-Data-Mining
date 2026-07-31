price <- c(1,1,5,5,5,5,5,8,8,
           10,10,10,10,12,14,14,14,
           15,15,15,15,15,15,
           18,18,18,18,18)

summary(price)
mean(price)
median(price)
sd(price)

hist(price,col="orange")
boxplot(price,col="pink")