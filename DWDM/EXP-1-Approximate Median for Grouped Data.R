age <- c("1-5","5-15","15-20","20-50","50-80","80-110")
freq <- c(200,450,300,1500,700,44)

N <- sum(freq)
cf <- cumsum(freq)

L <- 20
f <- 1500
cf_prev <- 950
h <- 30

median <- L + ((N/2 - cf_prev)/f) * h
print(median)