data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".") # read txt file with read.table.
data$Date <- as.character(data$Date) #class had to be character for subsetting without as.Date() & strptime() function
feb <- subset(data, Date == "1/2/2007" | Date == "2/2/2007") #subset data for both days

library(tidyr) #opens package "tidyr" dor using unite()
feb <- unite(feb, datetime, c(Date, Time), sep = "_", remove = TRUE, na.rm = FALSE) #paste column date + time to one variable "datetime"
feb$datetime <- as.character(feb$datetime) #convert "datetime" to charactor, for converting to Class = "POSIXlt" "POSIXt" 
feb$datetime <- strptime(feb$datetime, format = "%d/%m/%Y_%H:%M:%S") #convert "datetime to "POSIXlt" "POSIXt"

feb$Global_active_power <- as.numeric(as.character(feb$Global_active_power, dec = ".")) #class has to be numeric for plot
feb$Sub_metering_1 <- as.numeric(as.character(feb$Sub_metering_1, dec = ".")) #class has to be numeric for plot
feb$Sub_metering_2 <- as.numeric(as.character(feb$Sub_metering_2, dec = ".")) #class has to be numeric for plot
feb$Sub_metering_3 <- as.numeric(as.character(feb$Sub_metering_3, dec = ".")) #class has to be numeric for plot
feb$Voltage <- as.numeric(as.character(feb$Voltage, dec = ".")) #class has to be numeric for plot
feb$Global_reactive_power <- as.numeric(as.character(feb$Global_reactive_power, dec = ".")) #class has to be numeric for plot

png("plot4.png", width=480, height=480) #open PNG file device connection in working directory, with requested layout
par(mfrow = c(2,2)) #makes file device ready for image with 4 plot: 2 rows, 2 columns
plot(feb$datetime, feb$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)") #plot topleft
plot(feb$datetime, feb$Voltage, type = "l", xlab = "datetime", ylab = "Voltage") #plot topright
with(feb, plot(feb$datetime, feb$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")) #Plot empty plot for buttomleft
lines(feb$datetime, feb$Sub_metering_1, type="l") #draws black line in plott buttomleft
lines(feb$datetime, feb$Sub_metering_2, type="l", col="red") #draws red line in plot buttomleft
lines(feb$datetime, feb$Sub_metering_3, type="l", col="blue") #draws blue line in plot buttomleft
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1) #creates legend for buttomleft
plot(feb$datetime, feb$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power") #plots buttom right
dev.off() #close link to file device