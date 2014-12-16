#set working directory.
setwd("D:/Brady/coursera/Exploratory Data Analysis")

#read rds files
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#Question 2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.

#filter by fips == "24510"
NEI2 <- NEI[which(NEI$fips == "24510"),]

#calculate sum of PM2.5 emission for each year.
#aggregate(NEI$Emissions, list(Year=NEI$year), sum)
#using tapply function is more fast than the method aggregate.
PM25sum <- tapply(NEI2$Emissions, NEI2$year, sum)

#make a plot
plot(PM25sum, pch=19, col=names(PM25sum), xaxt="n", xlab="Year", ylab="Total PM2.5 Emission")
axis(1, at=1:length(names(PM25sum)), labels=names(PM25sum))

#copy a plot to png device
dev.copy(png, file="plot2.png")

#close device
dev.off()


