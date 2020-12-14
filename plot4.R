#load libraries 
library(ggplot2)
library(dplyr)

# unzip zip file to specified folder
#unzip(zipfile = dataFiles.zip" ##commented, because file already exists

#Read Source Classification Code Table
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset SCC table to get all coal combustion emission
SCCComb <- grepl("Comb",SCC[,"SCC.Level.One"],ignore.case = TRUE)
SCCCoal <- grepl("coal",SCC[,"SCC.Level.Four"],ignore.case = TRUE)
CombustionSCC <- SCC[SCCComb,]$SCC
CombustionNEI <- NEI[NEI$SCC %in% CombustionSCC,]

#Generating plot for Coal Combustion Emission across United States Year on Year
png(filename = "plot4.png",width=480,height = 480,units = "px",pointsize = 12,bg="white")
x4 <- ggplot(CombustionNEI,aes(x = factor(year),y = Emissions/10^5)) +
  geom_bar(stat="identity", fill ="#F4A582", width=0.75) +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
print(x4)
dev.off()