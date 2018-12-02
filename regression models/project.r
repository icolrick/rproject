library(dplyr)
library(ggplot2)
data(mtcars)



mod <- lm(mpg ~ am, mtcars)
summary(mod)
y
mtcars$am <- factor(c("Automatic", "Manual"))

boxplot (mpg ~ am, mtcars,
         col = c("red", "blue"),
         ylab = "Miles/gallon",
         xlab = "Transmission",
         main = "Transmission type effect on mile per gallon efficiency")















