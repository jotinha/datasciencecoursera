#load data 
if (!exists('NEI')) {
   NEI <- readRDS("data/summarySCC_PM25.rds")
}
if (!exists('SCC')) {
   SCC <- readRDS("data/Source_Classification_Code.rds")
}
if (!file.exists('figure')) dir.create('figure')

png("figure/plot5.png",width=480,height=480)

#first we add column to SCC table to mark mobile related sources
#by searching for "mobile vehicle" string in levelone
SCC$isMobileSource <- SCC$SCC.Level.One == "Mobile Sources"

#now we work on the NEI data and subset to Baltimore
r <- aggregate(Emissions ~year + SCC,data=NEI,FUN=sum,subset = NEI$fips == '24510')

#merge the two tables by the SCC code, but use only the interesting columns
#it's important we do this on r, instead of on NEI, because it's much faster
r <- merge(
   r,
   SCC[,c('SCC','isMobileSource')],
   by = 'SCC'
)

#re-aggregate
r <- aggregate(Emissions ~ year, data=r, FUN=sum, subset=r$isMobileSource)

barplot(r$Emissions,names.arg=r$year,space=2, 
        xlab='Year',ylab='Emissions (tons)',
        main = "PM-25 emissions by Mobile Sources in Baltimore, MD per year"
)

dev.off()