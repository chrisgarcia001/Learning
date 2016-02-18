# Unzip and read in data
#unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#----------------------------------------------------------------------------------------------------------------------------
# Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Get out unique corresponding SCC codes
sccs <- as.character(subset(SCC, as.character(SCC.Level.One) == "Mobile Sources")$SCC)

# Get out data for these.
total.pollution <- data.frame()
for(yr in unique(NEI$year)) {
	yr.total <- sum(subset(NEI, yr == year & is.element(SCC, unique(sccs)))$Emissions, na.rm = TRUE)
	total.pollution <- rbind(total.pollution, c(yr, yr.total))
}
colnames(total.pollution) <- c("year", "total")
plot(total.pollution$year, total.pollution$total, type = "b", lwd = 2, col = "orange", 
     pch = 17, xlab = "Year", ylab = "Total PM2.5 Emissions", 
	 main = "Total Motor Vehicle Sources Emissions by Year (Baltimore)") 