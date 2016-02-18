CodeBook
====================

## Study Design

This purpose of this project is to provide a particular summarization of the Human Activity Recognition Using Smartphones Dataset (Version 1.0). This dataset can be found at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Original Experiment Design (taken from original dataset README.txt)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### Data Summarization

In this project we summarize the original dataset above by aggregating a particular subset of features for each unique (Volunteer, Activity) pair. Aggregation is accomplished by simply taking the average of each selected feature for each unique (Volunteer, Activity) pair. The specific subset of features selected are only those that are directly mean or standard deviation measurement columns inside the original data. This excludes mean frequency columns (i.e. any that contain the substring "meanFreq()"). Furthermore, it is assumed that this analysis is only for the data contained immediately under the "train"" and "test" directories found in the original dataset. Accordingly, files found inside "Inertial Signals" sub-directories are not included in this summarization.

## Code Book

This project takes a subset of the original UCI HAR Dataset and provides a summarization. It assumes the same directory structure of the original dataset (at above URL). The data is transformed as follows:

STEP 1: The rows in files train/X_train.txt and test/X_test.txt are joined together in this order into a new data frame

STEP 2: The corresponding activity codes from rows in train/y_train.txt and test/y_test.txt are appended to the left column of the data frame. This new column is given the name "Activity".

STEP 3: The activity codes in "Activity" column are replaced by their corresponding names found in the file "activity_labels.txt"

STEP 4: The volunteers corresponding to each row are fetched (in the same order as in step 1) from train/subject_train.txt and test/subject_test.txt. These are added into the data frame as a new leftmost column called "Subject".

STEP 5: A new data frame (referred to as D2) is created with only the columns of interest. Specifically, columns this includes only columns which contain the "mean()" or "std()" as substrings.

STEP 6: Column names in D2 are renamed to be more human readable. Specifically, the string "mean()" is substituted with "mean" and the string "std()" is substituted with "standard-dev" in all column names.

STEP 7: For each unique (Subject, Activity) pair, all matching rows in D2 are grouped together and averaged. A new data frame D3 is constructed containing the averages for each column in D2 for each unique (Subject, Activity).

STEP 8: D3 is saved to the file "tidy_data.txt" using R's write.table function with the following options: quote=FALSE, row.names=FALSE.

### Variables and Corresponding Units

The data is aggregated by unique (Subject, Activity) pairs. The "Subject" units are numbers ranging from 1-30 and represent the unique volunteers. The "Activity" units are the textual name/descriptions of the activity. Each of the remaining variables represent an average for a unique (Subject, Activity) pair based on the correspondingly-named  measurement in the original data set. The units for these measurements in the original data set are described in detail in the file "features_info.txt".

The final summarized variables in the tidy data set (in left-right order) are as follows:

* Subject
* Activity
* tBodyAcc-mean-X
* tBodyAcc-mean-Y
* tBodyAcc-mean-Z
* tBodyAcc-standard-dev-X
* tBodyAcc-standard-dev-Y
* tBodyAcc-standard-dev-Z
* tGravityAcc-mean-X
* tGravityAcc-mean-Y
* tGravityAcc-mean-Z
* tGravityAcc-standard-dev-X
* tGravityAcc-standard-dev-Y
* tGravityAcc-standard-dev-Z
* tBodyAccJerk-mean-X
* tBodyAccJerk-mean-Y
* tBodyAccJerk-mean-Z
* tBodyAccJerk-standard-dev-X
* tBodyAccJerk-standard-dev-Y
* tBodyAccJerk-standard-dev-Z
* tBodyGyro-mean-X
* tBodyGyro-mean-Y
* tBodyGyro-mean-Z
* tBodyGyro-standard-dev-X
* tBodyGyro-standard-dev-Y
* tBodyGyro-standard-dev-Z
* tBodyGyroJerk-mean-X
* tBodyGyroJerk-mean-Y
* tBodyGyroJerk-mean-Z
* tBodyGyroJerk-standard-dev-X
* tBodyGyroJerk-standard-dev-Y
* tBodyGyroJerk-standard-dev-Z
* tBodyAccMag-mean
* tBodyAccMag-standard-dev
* tGravityAccMag-mean
* tGravityAccMag-standard-dev
* tBodyAccJerkMag-mean
* tBodyAccJerkMag-standard-dev
* tBodyGyroMag-mean
* tBodyGyroMag-standard-dev
* tBodyGyroJerkMag-mean
* tBodyGyroJerkMag-standard-dev
* fBodyAcc-mean-X
* fBodyAcc-mean-Y
* fBodyAcc-mean-Z
* fBodyAcc-standard-dev-X
* fBodyAcc-standard-dev-Y
* fBodyAcc-standard-dev-Z
* fBodyAccJerk-mean-X
* fBodyAccJerk-mean-Y
* fBodyAccJerk-mean-Z
* fBodyAccJerk-standard-dev-X
* fBodyAccJerk-standard-dev-Y
* fBodyAccJerk-standard-dev-Z
* fBodyGyro-mean-X
* fBodyGyro-mean-Y
* fBodyGyro-mean-Z
* fBodyGyro-standard-dev-X
* fBodyGyro-standard-dev-Y
* fBodyGyro-standard-dev-Z
* fBodyAccMag-mean
* fBodyAccMag-standard-dev
* fBodyBodyAccJerkMag-mean
* fBodyBodyAccJerkMag-standard-dev
* fBodyBodyGyroMag-mean
* fBodyBodyGyroMag-standard-dev
* fBodyBodyGyroJerkMag-mean
* fBodyBodyGyroJerkMag-standard-dev