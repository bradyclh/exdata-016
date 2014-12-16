#set working directory.
setwd("D:/Brady/coursera/Exploratory Data Analysis")

#read rds files
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Question 3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

#filter by fips == "24510"
NEI2 <- NEI[which(NEI$fips == "24510"),]

#calculate sum of PM2.5 emission for each year.
PM25sum2 <- aggregate(NEI2$Emissions, list(Year=NEI2$year, TYPE=NEI2$type), sum)
names(PM25sum2) <- c("Year", "Type", "Sum")

library(ggplot2)
#make a plot
g <- ggplot(PM25sum2, aes(Year, Sum))
g + geom_point(alpha = 1/3) + facet_wrap(~ Type, nrow = 2, ncol = 2) + labs(x = "Year") + labs(y = "Total PM2.5 Emission")

#copy a plot to png device
dev.copy(png, file="plot3.png")

#close device
dev.off()

