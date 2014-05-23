DATADIR <- "./UCI HAR Dataset/"

loadTable <- function(folder) {
   #folder is one of 'test','train'
   
   dir <- paste(DATADIR,'/',folder,'/',sep="")
   
   # load features ---------------------------------------------------------------
   #I can't use fread here due to some bug when column starts with spaces
   dat <- read.table(paste(dir,'X_',folder,'.txt',sep=""),header=F,colClasses='numeric')
   
   #get feature names
   featureNames <- read.table(paste(datadir,'features.txt',sep=""))
   featureNames <- featureNames[featureNames[,1],2] #adjust by index of feature names given in first column of features.tx
   colnames(dat) <- featureNames
   
   #extract only features we want, those with mean() and std() in the name
   cols <- grepl('mean()',featureNames,fixed=T) | grepl('std()',featureNames,fixed=T)
   if (sum(cols) != 66) stop("Expecting 66 columns")
   dat <- subset(dat,select=cols)
      
   #load activities -----------------------------------------------------------------
   y <- read.table(paste(dir,'y_',folder,'.txt',sep=""))
   #give activities the proper labels
   actLabels <- read.table(paste(datadir,'activity_labels.txt',sep=""))
   dat$Activity <- factor(y[,1],levels=actLabels[,1],labels=actLabels[,2])
   
   #load subject ---------------------------------------------------------------------
   subj <- read.table(paste(dir,'subject_',folder,'.txt',sep=""),colClasses='factor')
   dat$Subject <- subj[,1]
   
   dat
}

train <- loadTable('train')
test <- loadTable('test')

#make sure they have the same columns for fast merging
stopifnot(all(colnames(train) == colnames(test)))

all <- rbind(train,test)
