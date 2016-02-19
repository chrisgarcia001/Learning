# Unzip and read in data
#unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#----------------------------------------------------------------------------------------------------------------------------
# Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
#grep("[c]oal", "qwweqabcabCoal")
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
plot(total.pollution$year, total.pollution$total, type = "b", lwd = 2, col = "purple", 
     pch = 17, xlab = "Year", ylab = "Total PM2.5 Emissions", 
	 main = "All Coal Combustion Source Emissions by Year (US)") 