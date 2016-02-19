#-----------------------------------------------------------------------------
# NOTE: Please ensure data file is in same working directory as this script.
#-----------------------------------------------------------------------------

hp <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
hp <- subset(hp, is.element(Date, c("1/2/2007", "2/2/2007")))
hp <- subset(hp, Sub_metering_1 != "?" & Sub_metering_2 != "?" & Sub_metering_3 != "?")

data1 <- hp
dts <- paste(as.character(hp$Date), as.character(hp$Time))
data1$datetime <- strptime(dts, "%d/%m/%Y %H:%M")
png(file = "plot3.png")
with(data1, plot(datetime, as.numeric(as.character(Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering", col="black"))
with(data1, lines(datetime, as.numeric(as.character(Sub_metering_2)), col="red"))
with(data1, lines(datetime, as.numeric(as.character(Sub_metering_3)), col="blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()