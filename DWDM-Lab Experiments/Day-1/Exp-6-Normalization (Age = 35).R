age <- c(23,27,39,41,47,49,50,52,54,54,56,57,58,58,60,61,63,65)

value <- 35

# Min-Max
(value-min(age))/(max(age)-min(age))

# Z-score
(value-mean(age))/12.94

# Decimal Scaling
value/100