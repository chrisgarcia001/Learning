#-----------------------------------------------------------------------------
# NOTE: Please ensure data file is in same working directory as this script.
#-----------------------------------------------------------------------------

hp <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
hp <- subset(hp, is.element(Date, c("1/2/2007", "2/2/2007")))
hp <- subset(hp, Sub_metering_1 != "?" & Sub_metering_2 != "?" & Sub_metering_3 != "?")

data1 <- hp
dts <- paste(as.character(hp$Date), as.character(hp$Time))
data1$datetime <- strptime(dts, "%d/%m/%Y %H:%M")
png(file = "plot4.png")
par(mfrow = c(2, 2))
with(data1, 
	{plot(datetime, as.numeric(as.character(Global_active_power)), type="l", xlab="", ylab="Global Active Power (kilowatts)")
	 plot(datetime, as.numeric(as.character(Voltage)), type="l", xlab="datetime", ylab="Voltage")
	 {plot(datetime, as.numeric(as.character(Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering", col="black")
	  lines(datetime, as.numeric(as.character(Sub_metering_2)), col="red")
	  lines(datetime, as.numeric(as.character(Sub_metering_3)), col="blue")
	  legend("topright", lty = 1, col = c("black", "red", "blue"), 
			 bty = "n",
	         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	 }
	 plot(datetime, as.numeric(as.character(Global_reactive_power)), type="l", xlab="datetime", ylab="Global Reactive Power")
})
dev.off()