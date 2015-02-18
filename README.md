# getting-and-cleaning-data
Project work for getting and cleaning data class

# Project consists of 3 parts 
## This readme.md document
## The R script which must be sourced from your WD 
## Codebook in a text format

# Train and Test data is given from
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 
## 1. Main purpose is to merge training and test data set
## 2. Add subjects and activities (descriptive)
## 3. Cleaning feature names 

# Working directory must look like that

├── UCI HAR Dataset
  │   ├── README.txt
  │   ├── activity_labels.txt
  │   ├── features.txt
  │   ├── features_info.txt
  │   ├── test
  │   └── train
  └── run_analysis.R
  
# R Script 

* depends on libraries plyr and dplyr
* reads test and training data into data frames
* reads features
* filter features based on mean and std into logical vector
* rename feature name into more descriptive name (by using gsub())
* update data sets by filtering only the remaining features 
* update names with descriptive names

* read test and train activity labels 
* merge activity labels to data sets

* c(olumn) bind activity labels to test and train data sets
* rename activity column

* bind subjects to train and test data sets
* r(bind) test and train data set

* group by subject and Activity
* summarize all features by mean
* write result as tidy.txt file in working directory


