#set working directory.
setwd("D:/Brady/coursera/Exploratory Data Analysis")

#read rds files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Question 6
#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

#filter by Short.Name like %Motor Vehicle%
SCC2 <- SCC[grep("Motor Vehicle",SCC$Short.Name), c("SCC", "Short.Name")]

#filter by fips == "24510" & "06037"
NEI2 <- NEI[which(NEI$fips == "24510" | NEI$fips == "06037"),]

#merge NEI and SCC2
merged_data <- merge(NEI2, SCC2, by.x="SCC", by.y="SCC")

#calculate sum of PM2.5 emission for each year.
PM25sum2 <- aggregate(merged_data$Emissions, list(Year=merged_data$year, City=merged_data$fips), sum)
names(PM25sum2) <- c("Year", "City", "Sum")

PM25sum2$City <- gsub("06037", "Los Angeles", PM25sum2$City)
PM25sum2$City <- gsub("24510", "Baltimore", PM25sum2$City)

library(ggplot2)
#make a plot
g <- ggplot(PM25sum2, aes(Year, Sum))
g + geom_point(alpha = 1/3) + facet_wrap(~ City, nrow = 3, ncol = 1) + geom_smooth(method="lm", se=FALSE, col="steelblue") + labs(x = "Year") + labs(y = "Total PM2.5 Emission from motor vehicle sources")

#copy a plot to png device
dev.copy(png, file="plot6.png")

#close device
dev.off()
