# getting-and-cleaning-data

Project work for getting and cleaning data class

### Project consists of 3 parts 

1. This readme.md document
2. The R script which must be sourced from your WD 
3. Codebook in a text format

Train and Test data is given from  [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)



### R script in a nutshell
 
1. Main purpose is to merge training and test data set
2. Add subjects and activities (descriptive)
3. Cleaning feature names 
4. Average features by subjects and activities 


  
### R Script in detail

The script reads the subjects from the test/subject_test.txt and train/subject_test.txt and concatenates them. It does the same for activities in test/y_test.txt and train/y_train.txt. It renames the activities to be factors according to activity_labels.txt.

After that, the script reads the test/X_test.txt and train/X_train.txt files and only picks the measurements of mean and standard deviations from them. Using dpylr, it groups the data by subject and activity and takes the mean of all measurements in each group. Those are written in the file tidy.txt in the root directory of the project.

Steps in more detail:

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


### Code book
see seperate txt file in this repro