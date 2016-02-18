#-----------------------------------------------------------------------------
# NOTE: Please ensure data file is in same working directory as this script.
#-----------------------------------------------------------------------------

hp <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
hp <- subset(hp, Date == "1/2/2007" | Date == "2/2/2007")

dat <- as.numeric(as.character(hp$Global_active_power))
dat <- dat[!is.na(dat)]
png(file = "plot1.png")
hist(dat, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
dev.off()