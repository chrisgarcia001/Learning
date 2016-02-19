# Unzip and read in data
unzip("exdata_data_NEI_data.zip", overwrite = TRUE)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#----------------------------------------------------------------------------------------------------------------------------
# Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which 
#  of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#  Use the ggplot2 plotting system to make a plot answer this question. 
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
#print(plot3)
ggsave(filename="plot3.png", plot=plot3, width=3.5, height=3.5)