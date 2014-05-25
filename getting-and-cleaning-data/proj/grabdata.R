dataurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
datafname <- "Dataset.zip"
download.file(dataurl,dest=datafname,method="wget")
unzip(datafname)
file.remove(datafname)
