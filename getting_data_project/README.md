Getting & Cleaning Data Project
====================

This project contains an R program titled "run_analysis.R" which summarizes the Human Activity Recognition Using Smartphones Dataset. This dataset can be obtained at the following URL:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Upon downloading this data, you will find it unzips into a directory titled "UCI HAR Dataset" which contains files and sub-directories. The "run_analysis.R" script assumes this directory structure.

To run the script "run_analysis.R", please do the following:

* Step 1: Download and unzip the dataset above (if not done already)
* Step 2: Place the file "run_analysis.R" inside the top-level directory (UCI HAR Dataset) or make sure your directory containing the "run_analysis.R" script also contains all files and sub-directories in this dataset
* Step 3: Inside R, set your working directory to wherever you placed the files in step 2 above.
* Step 4: Enter the following R command at the prompt: > source("run_analysis.R")
* Step 5: The summarized data will be outputted to a file titled "tidy_data.txt" in your working directory. This file is may be read into an R data frame by simply using the read.table function.

These instructions detail how to run the "run_analysis.R" script.