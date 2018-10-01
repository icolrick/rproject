library(dplyr)
png("graph4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

data <- read.table(("household_power_consumption.txt"), header = T, sep = ";")
data <- tbl_df(data)
data <- subset(data ,data$Date=="1/2/2007" | data$Date=="2/2/2007")

x <- strptime(paste(data$Date, data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

                                        #quadrant 2
q2y1 <- as.numeric(as.character(data$Global_active_power))
plot(x, q2y1, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

                                        # quadrant 1
q1y1 <- as.numeric(as.character(data$Voltage))
plot(x, q1y1, xlab = "datetime", ylab = "Voltage", type = "l")

                                        # quadrant 3
q3y1 <- data$Sub_metering_1
q3y2 <- data$Sub_metering_2
q3y3 <- data$Sub_metering_3

plot(x, q3y1, xlab = "", ylab = "", type = "l", col = "green", ylim = c(0, 40))
par(new = TRUE)
plot(x, q3y2, xlab = "", ylab = "", type = "l", col = "red", ylim = c(0, 40))
par(new = TRUE)
plot(x, q3y3, xlab = "", ylab = "Energy sub metering", type = "l", col = "blue", ylim = c(0, 40))
legend("topright", lty = 1, col = c("green", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

                                        # quadrant 4
q4y1 <- as.numeric(as.character(data$Global_reactive_power))
plot(x, q4y1, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
