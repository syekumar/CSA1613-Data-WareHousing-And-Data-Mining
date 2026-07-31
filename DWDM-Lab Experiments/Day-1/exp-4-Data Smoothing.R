x <- c(11,13,13,15,15,16,19,20,
       20,20,21,21,22,23,24,30,
       40,45,45,45,71,72,73,75)

bins <- matrix(x,nrow=3)

# Bin Mean
apply(bins,2,function(a) rep(mean(a),length(a)))

# Bin Median
apply(bins,2,function(a) rep(median(a),length(a)))

# Bin Boundaries
boundary <- function(a){
  low <- min(a)
  high <- max(a)
  ifelse(abs(a-low)<abs(a-high),low,high)
}
apply(bins,2,boundary)