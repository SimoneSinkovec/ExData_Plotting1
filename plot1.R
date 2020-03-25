data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".") # read txt file with read.table.

data$Date <- as.character(data$Date) #class had to be character for subsetting without as.Date() & strptime() function
feb <- subset(data, Date == "1/2/2007" | Date == "2/2/2007") #subset data for both days

feb$Global_active_power <- as.numeric(as.character(feb$Global_active_power, dec = ".")) #class has to be numeric for plotting histogram

png("plot1.png", width=480, height=480) # open PNG connction in working directory, with requested layout
hist(feb$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power") #make histogram of numeric data from Global_active_power, made color red, name on x-axis is changed, and title is properly added.
dev.off() #close link to file device