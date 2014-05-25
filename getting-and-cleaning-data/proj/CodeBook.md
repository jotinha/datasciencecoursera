# Human Activity Recognition Using Smartphones Data Set 

## Data Set Information

This dataset describes accelerometer and gyroscope signal readings from a group of 30 volunteers performing six different activities. The original complete dataset is described in `UCI HAR Dataset/Readme.md` and `UCI HAR Dataset/features_info.txt`.

The modified dataset in this repository contains only those feature associated with mean and standard deviation operations on the time and frequency domain readings of the various signals. For the frequency domain, the weighted averages of the frequency components (`meanFreq()` in the original dataset) is also included. 

Each row in the table contains 79 such features, 1 activity label and 1 subject identifier. Detailed list is given in section `Data Dictionary`

There are 10299 rows obtained by merging the test and train datasets.

## Variable name cleanup

With respect to the feature names of the original dataset, the following changes were made for clarity

* Removed -, spaces and ()
* Dropped `t` prefix in time signal variables
* `f` prefix is now `freq`
* Fixed `fBodyBody...` to `freqBody...` (only one body)
* Mean and Std are uppercase
* Changed meanFreq() to WeightedMean
* X,Y,Z and Mag appear before Mean/Std

Camel case was used due to the long feature names

## Data Dictionary

In the following variable list, {X,Y,Z,Mag} is a shorthand notation meant to denote  
four different variables corresponding to independent measurements in each spatial direction (X,Y and Z) and the magnitude of resulting vector (Mag) for a particular measured signal. Likewise {Mean,Std} indicates that both the mean and standard deviation, respectively, are taken. 

E.g.: tBodyAcc{X,Y,Z,Mag}{Mean,Std} corresponds to 8 different features of the Body acceleration signal, a mean and a standard deviation of the measured signal in each direction and that of the vector magnitude: tBodyAccXMean,tBodyAccYMean,tBodyAccZMean, tBodyAccMagMean,tBodyAccXStd,tBodyAccYStd,tBodyAccZStd, tBodyAccMagStd

For the frequency domain (indicated by prefix `freq`), an additional  `WeightedMean`, a weighted frequency average, is used instead, as explained in previous sections

Each row of the table contains

* BodyAcc{X,Y,Z,Mag}{Mean,Std}: Body linear acceleration

* BodyGyro{X,Y,Z,Mag}{Mean,Std}: Body angular acceleration 

* BodyAccJerk{X,Y,Z,Mag}{Mean,Std}: Linear jerk signal

* BodyGyroJerk{X,Y,Z,Mag}{Mean,Std}: Angular jerk signal

* GravityAcc{X,Y,Z,Mag}{Mean,Std}: Gravity acceleration signal

* freqBodyAcc{X,Y,Z,Mag}{Mean,WeightedMean,Std}: Body linear acceleration signal frequencies

* freqBodyGyro{X,Y,Z,Mag}{Mean,WeightedMean,Std}: Angular acceleration frequencies

* freqBodyAccJerk{X,Y,Z,Mag}{Mean,WeightedMean,Std}: Linear jerk signal frequencies

* freqBodyGyroJerk{Mag}{Mean,WeightedMean,Std}: Magnitude of angular jerk signal frequencies

* activity: one of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

* subject: an integer from 1 to 30, identifying the test subject

All numeric features are normalized to [-1,1] range
