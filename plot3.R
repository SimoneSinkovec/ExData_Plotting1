data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")
data$Date <- as.character(data$Date) #class had to be character for subsetting without as.Date() & strptime() function
feb <- subset(data, Date == "1/2/2007" | Date == "2/2/2007") #subset data for both days
library(tidyr)
feb <- unite(feb, datetime, c(Date, Time), sep = "_", remove = TRUE, na.rm = FALSE) #paste column date + time to one variable "datetime"
feb$datetime <- as.character(feb$datetime) #convert "datetime" to charactor, for converting to Class = "POSIXlt" "POSIXt" 
feb$datetime <- strptime(feb$datetime, format = "%d/%m/%Y_%H:%M:%S") #convert "datetime to "POSIXlt" "POSIXt"
feb$Sub_metering_1 <- as.numeric(as.character(feb$Sub_metering_1, dec = ".")) #class has to be numeric for plot
feb$Sub_metering_2 <- as.numeric(as.character(feb$Sub_metering_2, dec = ".")) #class has to be numeric for plot
feb$Sub_metering_3 <- as.numeric(as.character(feb$Sub_metering_3, dec = ".")) #class has to be numeric for plot

png("plot3.png", width=480, height=480) # open PNG connction in working directory, with requested layout
with(feb, plot(feb$datetime, feb$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")) #Plot empty plot
lines(feb$datetime, feb$Sub_metering_1, type="l") #draws black line in plot
lines(feb$datetime, feb$Sub_metering_2, type="l", col="red") #draws red line in plot
lines(feb$datetime, feb$Sub_metering_3, type="l", col="blue") #draws blue line in plot
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1) #creates legend topright
dev.off() #close link to file device