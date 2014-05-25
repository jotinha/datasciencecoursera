#load data 
if (!exists('NEI')) {
   NEI <- readRDS("data/summarySCC_PM25.rds")
}
if (!exists('SCC')) {
   SCC <- readRDS("data/Source_Classification_Code.rds")
}
if (!file.exists('figure')) dir.create('figure')
png("figure/plot1.png",width=480,height=480)


r <- tapply(NEI$Emissions,list(NEI$year),sum)
barplot(r/1e6,space=2, 
        xlab='Year',ylab='Emissions (Million Tons)',
        main = "PM-25 total emissions in the United States per year")


dev.off()