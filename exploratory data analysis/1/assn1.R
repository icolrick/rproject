library(dplyr)
lpng("graph1.png", width = 480, height = 480)
data <- read.table(file.choose(), header = T, sep = ";")

g1 <- tbl_df(data)
g1 <- subset(g1 ,g1$Date=="1/2/2007" | g1$Date=="2/2/2007")
g1 <- g1$Global_active_power
g1 <- as.numeric(as.character(g1))
hist(g1, main = paste("Global Active Power"), xlab = paste("Global Active Power (kilowatts)"), ylab = paste("Frequency"), col = "red")
