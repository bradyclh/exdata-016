#set working directory.
setwd("D:/Brady/coursera/Exploratory Data Analysis")

#read rds files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Question 4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#filter by EI.Sector like %Coal%
SCC2 <- SCC[grep("Coal",SCC$EI.Sector), c("SCC", "EI.Sector")]

#merge NEI and SCC2
merged_data <- merge(NEI, SCC2, by.x="SCC", by.y="SCC")

#calculate sum of PM2.5 emission for each year.
PM25sum2 <- aggregate(merged_data$Emissions, list(Year=merged_data$year), sum)
names(PM25sum2) <- c("Year", "Sum")

library(ggplot2)
#make a plot
g <- ggplot(PM25sum2, aes(Year, Sum))
g + geom_point(alpha = 1/3) + geom_smooth(method="lm", se=FALSE, col="steelblue") + labs(x = "Year") + labs(y = "Total PM2.5 Emission from coal combustion-related sources")

#copy a plot to png device
dev.copy(png, file="plot4.png")

#close device
dev.off()
