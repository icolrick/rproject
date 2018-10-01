library(dplyr)
png("graph3.png", width = 480, height = 480)
data <- read.table(("household_power_consumption.txt"), header = T, sep = ";")

data <- tbl_df(data)
data <- subset(data ,data$Date=="1/2/2007" | data$Date=="2/2/2007")

y1 <- data$Sub_metering_1
y2 <- data$Sub_metering_2
y3 <- data$Sub_metering_3

x <- strptime(paste(data$Date, data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

plot(x, y1, xlab = "", ylab = "", type = "l", col = "green", ylim = c(0, 40))
par(new = TRUE)
plot(x, y2, xlab = "", ylab = "", type = "l", col = "red", ylim = c(0, 40))
par(new = TRUE)
plot(x, y3, xlab = "", ylab = "Energy sub metering", type = "l", col = "blue", ylim = c(0, 40))
legend("topright", lty = 1, col = c("green", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
