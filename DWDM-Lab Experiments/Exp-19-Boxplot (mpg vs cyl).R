boxplot(mpg~factor(cyl),
        data=mtcars,
        col="lightgreen",
        xlab="Cylinders",
        ylab="MPG",
        main="MPG vs Cylinders")