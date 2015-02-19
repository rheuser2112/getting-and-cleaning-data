##Processing
The run_analysis.R script expects the data from this location unzipped in the working directory. The toplevel directory that should appear is called "UCI HAR Dataset"

The script reads the subjects from the test/subject_test.txt and train/subject_test.txt and concatenates them. It does the same for activities in test/y_test.txt and train/y_train.txt. It renames the activities to be factors according to activity_labels.txt.

After that, the script reads the test/X_test.txt and train/X_train.txt files and only picks the measurements of mean and standard deviations from them. Using dpylr, it groups the data by subject and activity and takes the mean of all measurements in each group. Those are written in the file tidy.txt in the root directory of the project.

##Code book
see seperate txt file in this repro

