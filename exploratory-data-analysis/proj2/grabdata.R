if (any(!file.exists('data/Source_Classification_Code.rds','data/summarySCC_PM25.rds'))) {
   dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
   datafname <- "Dataset.zip"
   download.file(dataurl,dest=datafname,method="wget")
   unzip(datafname,exdir='data')
   file.remove(datafname)
}
