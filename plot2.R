library(dplyr)
library(datesets)
library(tidyr)

data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".") # read txt file with read.table.
data$Date <- as.character(data$Date) #class had to be character for subsetting without as.Date() & strptime() function
feb <- subset(data, Date == "1/2/2007" | Date == "2/2/2007") #subset data for both days

feb <- unite(feb, datetime, c(Date, Time), sep = "_", remove = TRUE, na.rm = FALSE)  # paste column date + time to one variable "datetime"
feb$datetime <- as.character(feb$datetime) #convert "datetime" to charactor, for converting to Class = "POSIXlt" "POSIXt" 
feb$datetime <- strptime(feb$datetime, format = "%d/%m/%Y_%H:%M:%S") #convert "datetime to "POSIXlt" "POSIXt" 
feb$Global_active_power <- as.numeric(as.character(feb$Global_active_power, dec = ".")) #class has to be numeric for plotting histogram

png("plot2.png", width=480, height=480) # open PNG connction in working directory, with requested layout
plot(feb$datetime, feb$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)") #use plot for scatterplot with lines
dev.off() #close link to file device