AllData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=TRUE, dec=".")
datasubset <- AllData[AllData$Date %in% c("1/2/2007","2/2/2007") ,]
globalActivePower <- as.numeric(datasubset$Global_active_power)
globalReactivePower <- as.numeric(datasubset$Global_reactive_power)
voltage <- as.numeric(datasubset$Voltage)


dateandtime <- strptime(paste(datasubset$Date, datasubset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
subMetering1 <- as.numeric(datasubset$Sub_metering_1)
subMetering2 <- as.numeric(datasubset$Sub_metering_2)
subMetering3 <- as.numeric(datasubset$Sub_metering_3)


png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
plot(dateandtime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(dateandtime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(dateandtime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(dateandtime, subMetering2, type="l", col="red")
lines(dateandtime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(dateandtime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()