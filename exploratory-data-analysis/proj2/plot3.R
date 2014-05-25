#load data 
if (!exists('NEI')) {
   NEI <- readRDS("data/summarySCC_PM25.rds")
}
if (!exists('SCC')) {
   SCC <- readRDS("data/Source_Classification_Code.rds")
}
if (!file.exists('figure')) dir.create('figure')

library(ggplot2)

png("figure/plot3.png",width=480,height=480)

idxs <- NEI$fips == '24510'
r <- aggregate(Emissions ~ type + year,sum,data=NEI,subset = idxs)
 
#if plot fails due to "attempt to apply non-function" error, update ggplot2 package and retry
plt <- qplot(year,Emissions,data=r,geom=c('point','line'),color=type,
             xlab = 'year',
             ylab = 'Emissions (tons)',
             main = 'PM-25 total emissions in Baltimore City, MD'
             )

print(plt)  #must explicity call this or saving to png won't work
dev.off()