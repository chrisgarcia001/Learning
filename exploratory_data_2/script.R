# Unzip and read in data
#unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#----------------------------------------------------------------------------------------------------------------------------
# Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

# Unzip and read in data
#unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
total.pollution <- data.frame()
for(yr in unique(NEI$year)) {
	yr.total <- sum(subset(NEI, yr == year)$Emissions, na.rm = TRUE)
	total.pollution <- rbind(total.pollution, c(yr, yr.total))
}
colnames(total.pollution) <- c("year", "total")
png(file = "plot1.png")
plot(total.pollution$year, total.pollution$total, type = "b", lwd = 2, col = "red", 
     pch = 17, xlab = "Year", ylab = "Total PM2.5 Emissions", 
	 main = "Total Emissions by Year (US)") 
dev.off()

#----------------------------------------------------------------------------------------------------------------------------
# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 

# Unzip and read in data
#unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
total.pollution <- data.frame()
for(yr in unique(NEI$year)) {
	yr.total <- sum(subset(NEI, yr == year & fips == "24510")$Emissions, na.rm = TRUE)
	total.pollution <- rbind(total.pollution, c(yr, yr.total))
}
colnames(total.pollution) <- c("year", "total")
png(file = "plot2.png")
plot(total.pollution$year, total.pollution$total, type = "b", lwd = 2, col = "green", 
     pch = 17, xlab = "Year", ylab = "Total PM2.5 Emissions", 
	 main = "Total Emissions by Year (Baltimore)") 
dev.off()
	 
#----------------------------------------------------------------------------------------------------------------------------
# Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which 
#  of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#  Use the ggplot2 plotting system to make a plot answer this question. 

# Unzip and read in data
#unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
yrs <- c()
tps <- c()
tots <- c()
i <- 1
for(yr in unique(NEI$year)) {
	for(tp in unique(NEI$type)) {
		yrs[i] <- yr
		tps[i] <- tp
		tots[i] <- sum(subset(NEI, (yr == year) & (tp == type) & (fips == "24510"))$Emissions, na.rm = TRUE)
		i <- i + 1
	}
}
poll <- data.frame(year = as.factor(yrs), type = as.factor(tps), total = tots)
library(ggplot2)
plot3 <- ggplot(data=poll, aes(x=year, y=total)) + geom_bar(aes(fill=type), stat="identity") + ggtitle("Baltimore Emissions Changes By Type and Year")
ggsave(filename="plot3.png", plot=plot3, width=4.5, height=4.5)

#----------------------------------------------------------------------------------------------------------------------------
# Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
#grep("[c]oal", "qwweqabcabCoal")

# Unzip and read in data
#unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
sccs <- c()
count <- 1
for(i in 1:nrow(SCC)) {
	if(grepl("[Cc]oal", as.character(SCC$SCC.Level.Three[i]))) {
		sccs[count] <- as.character(SCC$SCC[i])
		count <- count + 1
	}
}

total.pollution <- data.frame()
for(yr in unique(NEI$year)) {
	yr.total <- sum(subset(NEI, yr == year & is.element(SCC, unique(sccs)))$Emissions, na.rm = TRUE)
	total.pollution <- rbind(total.pollution, c(yr, yr.total))
}
colnames(total.pollution) <- c("year", "total")
png(file = "plot4.png")
plot(total.pollution$year, total.pollution$total, type = "b", lwd = 2, col = "purple", 
     pch = 17, xlab = "Year", ylab = "Total PM2.5 Emissions", 
	 main = "All Coal Combustion Source Emissions by Year (US)") 
dev.off()
	 
#----------------------------------------------------------------------------------------------------------------------------
# Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Unzip and read in data
#unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

# Get out unique corresponding SCC codes
sccs <- as.character(subset(SCC, as.character(SCC.Level.One) == "Mobile Sources")$SCC)

# Get out data for these.
total.pollution <- data.frame()
for(yr in unique(NEI$year)) {
	yr.total <- sum(subset(NEI, yr == year & is.element(SCC, unique(sccs)))$Emissions, na.rm = TRUE)
	total.pollution <- rbind(total.pollution, c(yr, yr.total))
}
colnames(total.pollution) <- c("year", "total")
png(file = "plot5.png")
plot(total.pollution$year, total.pollution$total, type = "b", lwd = 2, col = "orange", 
     pch = 17, xlab = "Year", ylab = "Total PM2.5 Emissions", 
	 main = "Total Motor Vehicle Sources Emissions by Year (Baltimore)") 
dev.off()
	 
#----------------------------------------------------------------------------------------------------------------------------
# Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has 
# seen greater changes over time in motor vehicle emissions?

# Unzip and read in data
#unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

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
png(file = "plot6.png")
par(mfrow = c(2, 1))
plot(balt$year, balt$total, type = "b", lwd = 2, col = "green", 
     pch = 17, xlab = "Year", ylab = "Total PM2.5 Emissions", 
	 main = "Total Motor Vehicle Emissions by Year (Baltimore)") 
plot(la$year, la$total, type = "b", lwd = 2, col = "blue", 
     pch = 17, xlab = "Year", ylab = "Total PM2.5 Emissions", 
	 main = "Total Motor Vehicle Emissions by Year (Los Angeles)") 
dev.off()