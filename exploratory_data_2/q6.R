# Unzip and read in data
#unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#----------------------------------------------------------------------------------------------------------------------------
# Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has 
# seen greater changes over time in motor vehicle emissions?

# Get out unique corresponding SCC codes
sccs <- as.character(subset(SCC, as.character(SCC.Level.One) == "Mobile Sources")$SCC)

balt <- data.frame()
la <- data.frame()
for(yr in unique(NEI$year)) {
	balt.yr <- sum(subset(NEI, yr == year & fips == "24510" & is.element(SCC, unique(sccs)))$Emissions, na.rm = TRUE)
	la.yr <- sum(subset(NEI, yr == year & fips == "06037" & is.element(SCC, unique(sccs)))$Emissions, na.rm = TRUE)
	balt <- rbind(balt, c(yr, balt.yr))
	la <- rbind(la, c(yr, la.yr))
}
colnames(balt) <- c("year", "total")
colnames(la) <- c("year", "total")
par(mfrow = c(2, 1))
plot(balt$year, balt$total, type = "b", lwd = 2, col = "green", 
     pch = 17, xlab = "Year", ylab = "Total PM2.5 Emissions", 
	 main = "Total Motor Vehicle Emissions by Year (Baltimore)") 
plot(la$year, la$total, type = "b", lwd = 2, col = "blue", 
     pch = 17, xlab = "Year", ylab = "Total PM2.5 Emissions", 
	 main = "Total Motor Vehicle Emissions by Year (Los Angeles)") 
