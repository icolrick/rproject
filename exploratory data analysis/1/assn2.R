library(dplyr)
png("graph2.png", width = 480, height = 480)
data <- read.table("household_power_consumption.txt", header = T, sep = ";")

data <- tbl_df(data)
data <- subset(data ,data$Date=="1/2/2007" | data$Date=="2/2/2007")
y <- as.numeric(as.character(data$Global_active_power))
x <- strptime(paste(data$Date, data$Time, sep = ""), "%d/%m/%Y %H:%M:%S")


plot(x, y, main = paste(""), xlab = paste(""), ylab = paste("Global Active Power (kilowatts)"), type = "l")

