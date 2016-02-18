#-----------------------------------------------------------------------------
# NOTE: Please ensure data file is in same working directory as this script.
#-----------------------------------------------------------------------------


hp <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
hp <- subset(hp, is.element(Date, c("1/2/2007", "2/2/2007")))

# Formatting Function Example:
# strptime("16/12/2006 17:24:00", "%d/%m/%Y %H:%M") => "2006-12-16 17:24:00 EST"

data1 <- hp
dts <- paste(as.character(hp$Date), as.character(hp$Time))
data1$datetime <- strptime(dts, "%d/%m/%Y %H:%M")
png(file = "plot2.png")
with(data1, plot(datetime, as.numeric(as.character(Global_active_power)), type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()