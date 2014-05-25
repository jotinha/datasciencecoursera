# Modified "Human Activity Recognition Using Smartphones Data Set"

## Data Set Information

This dataset describes accelerometer and gyroscope signal readings from a group of 30 volunteers performing six different activities. The original complete dataset can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Technical details on the measured signals and feature construction are also given in that reference.

This repository generates [tidy data](https://github.com/jotinha/datasharing) with a subset of the original features.

## Running

To generate the data files first execute

```R
source('grabdata.R')  
```

to download the original data (otherwise they must be in directory `UCI HAR Dataset` or wherever `DATADIR` variable points to). Then  run the analysis file

```R
source('run_analysis.R')
```

Two files will be generated

## tidyDataAll.txt

This is a modified dataset which contains only those feature associated with mean and standard deviation operations on the time and frequency domain readings of the various signals. For the frequency domain, the weighted averages of the frequency components is also included. 

Each row in the table contains 79 such features, 1 activity label and 1 subject identifier.

There are 10299 rows obtained by merging the test and train datasets from the source.

The features are specified in `CodeBook.md`.

## tidyDataAverages.txt

This data table contains the averages of the features for each subject,activity pair

There are 180 rows, one for each combination of 6 activities and 30 subjects

The features are specified in `CodeBook.md`

## Details

The script will
* go to the test and train folders
  - read and merge horizontally:`X_*.txt`, `Y_*.txt` and `subject_*.txt`
* get feature names from `features_info.txt`
* select appropriate features
* fix feature names according to the criteria defined in `CodeBook.md`
* get activity names from `activity_labels.txt`
* merge test and train sets vertically
* save table as comma delimited file `tidyDataAll.txt`

It will then take the averages of each numeric feature for each combination of activities and subjects, and save the result to the comma delimited file `tidyDataAverages.txt`

