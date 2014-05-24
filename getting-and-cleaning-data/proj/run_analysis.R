DATADIR <- "./UCI HAR Dataset/"

loadTable <- function(folder) {
   #folder is one of 'test','train'
   
   dir <- paste(DATADIR,'/',folder,'/',sep="")
   
   # load features ---------------------------------------------------------------
   #I can't use fread here due to some bug when column starts with spaces
   dat <- read.table(paste(dir,'X_',folder,'.txt',sep=""),header=F,colClasses='numeric')
   
   #get feature names
   featureNames <- read.table(paste(DATADIR,'features.txt',sep=""))
   featureNames <- featureNames[featureNames[,1],2] #adjust by index of feature names given in first column of features.tx
   colnames(dat) <- featureNames
   
   #extract only features we want, those with mean() and std() in the name
   cols <- grepl('mean()',featureNames,fixed=T) | grepl('std()',featureNames,fixed=T)
   if (sum(cols) != 66) stop("Expecting 66 columns")
   dat <- subset(dat,select=cols)
   
   #rename colnames them to something more readable
   colnames(dat) <- gsub("-mean\\(\\)-?","Mean",colnames(dat))
   colnames(dat) <- gsub("-std\\(\\)-?","Std",colnames(dat))
      
   #load activities -----------------------------------------------------------------
   y <- read.table(paste(dir,'y_',folder,'.txt',sep=""))
   #give activities the proper labels
   actLabels <- read.table(paste(DATADIR,'activity_labels.txt',sep=""))
   dat$activity <- factor(y[,1],levels=actLabels[,1],labels=actLabels[,2])
   
   #load subject ---------------------------------------------------------------------
   subj <- read.table(paste(dir,'subject_',folder,'.txt',sep=""),colClasses='integer')
   dat$subject <- subj[,1]
   
   dat
}

loadAll <- function() {
   train <- loadTable('train')
   test <- loadTable('test')
   
   #make sure they have the same columns for fast merging
   stopifnot(all(colnames(train) == colnames(test)))
   
   rbind(train,test)
   
}

createAverageTables <- function(dat) {
   aggregate(. ~ activity + subject, data=dat, FUN=mean)
}

saveData <- function(tidyDataAll,tidyDataAverages) {
   #i chose csv for maximum compatibility
   write.csv2(tidyDataAll,file="tidyDataAll.csv",row.names=F,)
   write.csv2(tidyDataAverages,file="tidyDataAverages.csv",row.names=F)
}

dat <- loadAll()
dat2 <- createAverageTables(dat)
saveData(dat,dat2)


