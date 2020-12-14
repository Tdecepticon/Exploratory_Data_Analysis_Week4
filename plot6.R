#load libraries 
library(ggplot2)
library(dplyr)

# unzip zip file to specified folder
#unzip(zipfile = dataFiles.zip" ##commented, because file already exists

#Read Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Assignment #Q6: Compare emissions from motor vehicle sources in Baltimore 
## City with emissions from motor vehicle sources in Los Angeles County, 
## California (fips == "06037"). Which city has seen greater changes over time 
## in motor vehicle emissions?

Vhcls <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
VhclsSCC <- SCC[Vhcls,]$SCC
VhclsNEI <- NEI[NEI$SCC %in% VhclsSCC,]
VhclsBaltimoreNEI <- VhclsNEI[VhclsNEI$fips == 24510,]
VhclsBaltimoreNEI$city <- "Baltimore City"
VhclsLANEI <- VhclsNEI[VhclsNEI$fips=="06037",]
VhclsLANEI$city <- "Los Angeles County"
bothNEI <- rbind(VhclsBaltimoreNEI,VhclsLANEI)


png("Plot6.png",width=500,height=400,units="px",bg="transparent")

g <- ggplot(bothNEI, 
            aes(x=factor(year), 
                y=Emissions, 
                fill=city)) +
  geom_bar(aes(fill=year),
           stat="identity") +
  facet_grid(scales="free", 
             space="free", 
             .~city) +
  guides(fill=FALSE) + 
  theme_bw() +
  labs(x="year", 
       y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(g)
dev.off() 