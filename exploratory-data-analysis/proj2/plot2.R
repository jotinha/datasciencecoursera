#load data 
if (!exists('NEI')) {
   NEI <- readRDS("data/summarySCC_PM25.rds")
}
if (!exists('SCC')) {
   SCC <- readRDS("data/Source_Classification_Code.rds")
}
if (!file.exists('figure')) dir.create('figure')
png("figure/plot2.png",width=480,height=480)

idxs <- NEI$fips == '24510'
r <- tapply(NEI$Emissions[idxs],list(NEI$year[idxs]),sum)
x <- as.integer(row.names(r))
y <- array(r)

plot(x,y,
     xlab='Year',ylab='Emissions (tons)',
     main = "PM-25 total emissions in Baltimore City, MD per year")
abline(lm(y ~ x))

dev.off()