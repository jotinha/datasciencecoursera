#load data 
if (!exists('NEI')) {
   NEI <- readRDS("data/summarySCC_PM25.rds")
}
if (!exists('SCC')) {
   SCC <- readRDS("data/Source_Classification_Code.rds")
}
if (!file.exists('figure')) dir.create('figure')
png("figure/plot6.png",width=600,height=480)

#first we add column to SCC table to mark mobile related sources
#by searching for "mobile vehicle" string in levelone
SCC$isMobileSource <- SCC$SCC.Level.One == "Mobile Sources"

#now we work on the NEI data and subset to Baltimore and LA
r <- aggregate(Emissions ~year + SCC + fips,data=NEI,FUN=sum,subset = NEI$fips %in% c('24510','06037'))

#change fips to actual city name
r$Location = factor(r$fips,levels=c('24510','06037'),labels=c('Baltimore, MD','LA County, CA'))
r$fips = NULL

#merge the two tables by the SCC code, but use only the interesting columns
#it's important we do this on r, instead of on NEI, because it's much faster
r <- merge(
   r,
   SCC[,c('SCC','isMobileSource')],
   by = 'SCC'
)

#create contigency table of emissions with location in rows and year in columns
xr <- xtabs(Emissions ~ Location + year,data=r, subset = r$isMobileSource)
years <- as.numeric(colnames(xr))

#plot emissions relative to first year
plot(years,xr['Baltimore, MD',]*100/xr['Baltimore, MD','1999'],type='n',
     xlab='Year',ylab='Emissions relative to 1999 (%)',
     main = "Changes in PM-25 emissions by Mobile Sources since 1999, at two locations"
)
lines(years,xr['LA County, CA',]*100/xr['LA County, CA','1999'],type='b',col=1,lwd=2)
lines(years,xr['Baltimore, MD',]*100/xr['Baltimore, MD','1999'],type='b',col=2,lwd=2)
legend('bottomleft',c('LA County, CA','Baltimore, MD'),col=c(1,2),lty=1,lwd=2)

dev.off()
