marks <- c(55,60,71,63,55,65,50,55,58,
           59,61,63,65,67,71,72,75)

# Histogram
hist(marks,col="lightblue")

# Equal Frequency
sort(marks)

split(sort(marks),cut(seq_along(marks),3,labels=FALSE))

# Equal Width
cut(marks,breaks=3)