# Human Activity Recognition Using Smartphones Data Set 

## Data Set Information

This dataset describes accelerometer and gyroscope signal readings from a group of 30 volunteers performing six different activities. The original complete dataset is described in `UCI HAR Dataset/Readme.md` and `UCI HAR Dataset/features_info.txt`, and technical details on feature construction are also given in those files.

## tidyDataAll.csv

This is a modified dataset which contains only those feature associated with mean and standard deviation operations on the time and frequency domain readings of the various signals. For the frequency domain, the weighted averages of the frequency components (`meanFreq()` in the original dataset) is also included. 

Each row in the table contains 79 such features, 1 activity label and 1 subject identifier. Detailed list is given in section `Data Dictionary`

There are 10299 rows obtained by merging the test and train datasets.

The features are specified in CodeBook.md

## tidyDataAverages.csv

This data table contains the averages of the previous features for each subject,activity pair

There are 180 rows, one for each combination of 6 activities and 30 subjects

The features are specified in CodeBook.md

## Running

To generate the two data files first execute

```R
source('grabdata.R')  
```

to download data files. (Otherwise they must be in directory `UCI HAR Dataset` or specified in `DATADIR` variable). Then, execute

```R
source('run_analysis.R')
```

## Details

The script will
* go to the test and train folders
  - read and merge horizontally, X.txt, Y.txt and subject_*.txt
* get feature names from features_info.txt
* select appropriate features
* fix feature names according to the criteria defined in `CodeBook.md`
* get activity names from activity_labels.txt  
* merge test and train sets vertically
* save tabke as comma delimited file `tidyDataAll.txt`

It will then take the averages of each numeric feature for each combination of activities and subjects, and save the result to the comma delimited filed `tidyDataAverages.txt`

