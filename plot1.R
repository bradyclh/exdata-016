#set working directory.
setwd("D:/Brady/coursera/Exploratory Data Analysis")

#read rds files
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Question 1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission
#from all sources for each of the years 1999, 2002, 2005, and 2008.

#calculate sum of PM2.5 emission for each year.
#aggregate(NEI$Emissions, list(Year=NEI$year), sum)
#using tapply function is more fast than the method aggregate.
PM25sum <- tapply(NEI$Emissions, NEI$year, sum)

#make a plot
plot(PM25sum, pch=19, col=names(PM25sum), xaxt="n", xlab="Year", ylab="Total PM2.5 Emission")
axis(1, at=1:length(names(PM25sum)), labels=names(PM25sum))

#copy a plot to png device
dev.copy(png, file="plot1.png")

#close device
dev.off()



