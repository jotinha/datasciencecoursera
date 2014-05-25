#load data 
if (!exists('NEI')) {
   NEI <- readRDS("data/summarySCC_PM25.rds")
}
if (!exists('SCC')) {
   SCC <- readRDS("data/Source_Classification_Code.rds")
}
if (!file.exists('figure')) dir.create('figure')

png("figure/plot4.png",width=480,height=480)

#first we add column to SCC table to mark coal related sources
#by searching for "coal" string in shortname
SCC$isCoalRelated <- grepl("coal",SCC$Short.Name,ignore.case=T)

#now we work on the NEI data
r <- aggregate(Emissions ~year + SCC,data=NEI,FUN=sum)

#merge the two tables by the SCC code, but use only the interesting columns
#it's important we do this on r, instead of on NEI, because it's much faster
r <- merge(
   r,
   SCC[,c('SCC','isCoalRelated')],
   by = 'SCC'
)

#re-aggregate
r <- aggregate(Emissions ~ year, data=r, FUN=sum, subset=r$isCoalRelated)

barplot(r$Emissions/1e6,names.arg=r$year,space=2, 
        xlab='Year',ylab='Emissions (Million Tons)',
        main = "PM-25 emissions due to coal sources in the United States per year"
)

dev.off()