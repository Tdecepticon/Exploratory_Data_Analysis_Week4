#load libraries 
library(ggplot2)
library(dplyr)

# unzip zip file to specified folder
#unzip(zipfile = dataFiles.zip" ##commented, because file already exists

#Read Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset NEI table to get Baltimore City Data (fip == "24510" & Type= Road)

NEIBalCityOnRoad <- subset(NEI,NEI$fips=="24510" & NEI$type=="ON-ROAD")

#Generating Baltimore City PM2.5 Emission On Road
TotalBalCityEmissionOnRoad <- aggregate(Emissions ~ year + type,NEIBalCityOnRoad,sum)

png(filename = "plot5.png",width=480,height = 480,units = "px",pointsize = 12,bg="white")

x5 <- barplot(height = TotalBalCityEmissionOnRoad$Emissions,
              names.arg = TotalBalCityEmissionOnRoad$year,
              xlab = "Years",
              ylab = "Total PM 2.5 Emission in tons on Road",
              ylim = c(0,400),col=c("#B2182B", "#F4A582","#D1E5F0","#4393C3"))

text(x=x5, y=50, labels=round(TotalBalCityEmissionOnRoad$Emissions,2) , xpd=TRUE, srt=90)
dev.off()