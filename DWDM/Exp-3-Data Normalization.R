x <- c(200,300,400,600,1000)

# Min-Max
minmax <- (x-min(x))/(max(x)-min(x))
print(minmax)

# Z-score
zscore <- (x-mean(x))/sd(x)
print(zscore)