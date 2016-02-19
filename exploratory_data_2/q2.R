# Unzip and read in data
#unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#----------------------------------------------------------------------------------------------------------------------------
# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
total.pollution <- data.frame()
for(yr in unique(NEI$year)) {
	yr.total <- sum(subset(NEI, yr == year & fips == "24510")$Emissions, na.rm = TRUE)
	total.pollution <- rbind(total.pollution, c(yr, yr.total))
}
colnames(total.pollution) <- c("year", "total")
plot(total.pollution$year, total.pollution$total, type = "b", lwd = 2, col = "green", 
     pch = 17, xlab = "Year", ylab = "Total PM2.5 Emissions", 
	 main = "Total Emissions by Year (Baltimore)") 