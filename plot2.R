AllData2 <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=TRUE, dec=".")
datasubset <- AllData2[AllData2$Date %in% c("1/2/2007","2/2/2007") ,]
globalActivePower <- as.numeric(datasubset$Global_active_power)
datetime <- strptime(paste(datasubset$Date, datasubset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()