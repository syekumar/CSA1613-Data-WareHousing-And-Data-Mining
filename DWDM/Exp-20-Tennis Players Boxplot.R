points <- c(25,30,28,35,32,40,45,38,31,90)

boxplot(points,
        col="yellow",
        main="Player Scores")

boxplot.stats(points)$out