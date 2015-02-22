## setwd("C:/R/Data Science Tracks/GettingAndCleaningData")

## load plyr to use JOIN
library(plyr)
## load dplyr to use the nice functions like mutate, select , arrange,...
library(dplyr)

## read test and training sets
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

## read features
features <- read.table("./UCI HAR Dataset/features.txt")

## filter features which belong to "mean" and "grep"
is_mean <- grepl("mean", features[,2])
is_std  <- grepl("std", features[,2])
is_meanAndStd <- is_mean | is_std ## logical vector is true where mean or std is in féature name

## subset features: only mean and std
features_new <- subset(features, is_meanAndStd == TRUE)

## convert into char
features_new[,2]<- as.character(features_new[,2])

## add a new column with descriptiv column names be using gsub function
Features_new <- mutate(features_new, FeatureName = gsub("\\(|\\)", "",
                                        gsub("^t", "TimeDomain",
                                        gsub("^f", "FourierTransform",
                                        gsub("-mean", "Mean",
                                        gsub("-std", "StandardDeviation",
                                        gsub("Mag",  "Magnittude",
                                        gsub("Acc",  "Acceleration",
                                        gsub("-Y",   "YAxis" ,
                                        gsub("-Z",   "ZAxis",
                                        gsub("-X","XAxis",    V2)  ))))))))))

## generate the mean variables to be used in group by: [Avg]+ featurename
## 
## Features_new <- mutate(Features_new, MeanVariables = 
##                              paste(paste( paste (paste("Avg",FeatureName,sep = ""), "=mean(",sep=""), FeatureName,sep = ""), "),", sep = "" )
##                       )
## use result to build the last stmt which calculates the mean over all features (copy paste manually)
## TempAggFeat <- as.matrix(Features_new[,4],row.name=FALSE)
                                                        
## now we have a dat frame with three columns: 
##     V1 (=RowNumber), 
##     V2 (0ld feature name) and 
##     FeatureName ( new descriptiv feature name)
##     Statment used in summarize stmt to alculate all means

## next step is to eleminate the not needed columns(use column(1))
x_test <-  x_test[ , Features_new[,1] ]
x_train <- x_train[ ,Features_new[,1] ]

## in column 3 we have all descriptiv feature names
names(x_test) <-  Features_new[,3]
names(x_train) <- Features_new[,3]


## read activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## now match the activity labels to y_test dataframe
y_test  <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

## merge the activity labels to y_text
y_test <-  join( y_test, activity_labels, by="V1")
y_train <- join( y_train,activity_labels, by="V1")

## now bind the activity labels to the features
x_test <-  cbind(y_test[,2],  x_test)
x_train <- cbind(y_train[,2], x_train)

## rename first column name
names(x_test) [1] <- "Activity"
names(x_train)[1] <- "Activity"


## bind subjects 
subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subjectsTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## column bind subjects 
x_test <- cbind(subjects, x_test)
names(x_test)[1] <- "Subject"

x_train <- cbind(subjectsTrain, x_train)
names(x_train)[1] <- "Subject"

## rbind tidy test and training sets
combinedSet <- rbind(x_train, x_test)


## use group by and summarize from dplyr library
BySubject <- group_by(combinedSet,Subject,Activity )

AggregatedDS <-summarize(BySubject, 
                         
                         AvgTimeDomainBodyAccelerationMeanXAxis=mean(TimeDomainBodyAccelerationMeanXAxis),
                         AvgTimeDomainBodyAccelerationMeanYAxis=mean(TimeDomainBodyAccelerationMeanYAxis),
                         AvgTimeDomainBodyAccelerationMeanZAxis=mean(TimeDomainBodyAccelerationMeanZAxis),
                         AvgTimeDomainBodyAccelerationStandardDeviationXAxis=mean(TimeDomainBodyAccelerationStandardDeviationXAxis),
                         AvgTimeDomainBodyAccelerationStandardDeviationYAxis=mean(TimeDomainBodyAccelerationStandardDeviationYAxis),
                         AvgTimeDomainBodyAccelerationStandardDeviationZAxis=mean(TimeDomainBodyAccelerationStandardDeviationZAxis),
                         AvgTimeDomainGravityAccelerationMeanXAxis=mean(TimeDomainGravityAccelerationMeanXAxis),
                         AvgTimeDomainGravityAccelerationMeanYAxis=mean(TimeDomainGravityAccelerationMeanYAxis),
                         AvgTimeDomainGravityAccelerationMeanZAxis=mean(TimeDomainGravityAccelerationMeanZAxis),
                         AvgTimeDomainGravityAccelerationStandardDeviationXAxis=mean(TimeDomainGravityAccelerationStandardDeviationXAxis),
                         AvgTimeDomainGravityAccelerationStandardDeviationYAxis=mean(TimeDomainGravityAccelerationStandardDeviationYAxis),
                         AvgTimeDomainGravityAccelerationStandardDeviationZAxis=mean(TimeDomainGravityAccelerationStandardDeviationZAxis),
                         AvgTimeDomainBodyAccelerationJerkMeanXAxis=mean(TimeDomainBodyAccelerationJerkMeanXAxis),
                         AvgTimeDomainBodyAccelerationJerkMeanYAxis=mean(TimeDomainBodyAccelerationJerkMeanYAxis),
                         AvgTimeDomainBodyAccelerationJerkMeanZAxis=mean(TimeDomainBodyAccelerationJerkMeanZAxis),
                         AvgTimeDomainBodyAccelerationJerkStandardDeviationXAxis=mean(TimeDomainBodyAccelerationJerkStandardDeviationXAxis),
                         AvgTimeDomainBodyAccelerationJerkStandardDeviationYAxis=mean(TimeDomainBodyAccelerationJerkStandardDeviationYAxis),
                         AvgTimeDomainBodyAccelerationJerkStandardDeviationZAxis=mean(TimeDomainBodyAccelerationJerkStandardDeviationZAxis),
                         AvgTimeDomainBodyGyroMeanXAxis=mean(TimeDomainBodyGyroMeanXAxis),
                         AvgTimeDomainBodyGyroMeanYAxis=mean(TimeDomainBodyGyroMeanYAxis),
                         AvgTimeDomainBodyGyroMeanZAxis=mean(TimeDomainBodyGyroMeanZAxis),
                         AvgTimeDomainBodyGyroStandardDeviationXAxis=mean(TimeDomainBodyGyroStandardDeviationXAxis),
                         AvgTimeDomainBodyGyroStandardDeviationYAxis=mean(TimeDomainBodyGyroStandardDeviationYAxis),
                         AvgTimeDomainBodyGyroStandardDeviationZAxis=mean(TimeDomainBodyGyroStandardDeviationZAxis),
                         AvgTimeDomainBodyGyroJerkMeanXAxis=mean(TimeDomainBodyGyroJerkMeanXAxis),
                         AvgTimeDomainBodyGyroJerkMeanYAxis=mean(TimeDomainBodyGyroJerkMeanYAxis),
                         AvgTimeDomainBodyGyroJerkMeanZAxis=mean(TimeDomainBodyGyroJerkMeanZAxis),
                         AvgTimeDomainBodyGyroJerkStandardDeviationXAxis=mean(TimeDomainBodyGyroJerkStandardDeviationXAxis),
                         AvgTimeDomainBodyGyroJerkStandardDeviationYAxis=mean(TimeDomainBodyGyroJerkStandardDeviationYAxis),
                         AvgTimeDomainBodyGyroJerkStandardDeviationZAxis=mean(TimeDomainBodyGyroJerkStandardDeviationZAxis),
                         AvgTimeDomainBodyAccelerationMagnittudeMean=mean(TimeDomainBodyAccelerationMagnittudeMean),
                         AvgTimeDomainBodyAccelerationMagnittudeStandardDeviation=mean(TimeDomainBodyAccelerationMagnittudeStandardDeviation),
                         AvgTimeDomainGravityAccelerationMagnittudeMean=mean(TimeDomainGravityAccelerationMagnittudeMean),
                         AvgTimeDomainGravityAccelerationMagnittudeStandardDeviation=mean(TimeDomainGravityAccelerationMagnittudeStandardDeviation),
                         AvgTimeDomainBodyAccelerationJerkMagnittudeMean=mean(TimeDomainBodyAccelerationJerkMagnittudeMean),
                         AvgTimeDomainBodyAccelerationJerkMagnittudeStandardDeviation=mean(TimeDomainBodyAccelerationJerkMagnittudeStandardDeviation),
                         AvgTimeDomainBodyGyroMagnittudeMean=mean(TimeDomainBodyGyroMagnittudeMean),
                         AvgTimeDomainBodyGyroMagnittudeStandardDeviation=mean(TimeDomainBodyGyroMagnittudeStandardDeviation),
                         AvgTimeDomainBodyGyroJerkMagnittudeMean=mean(TimeDomainBodyGyroJerkMagnittudeMean),
                         AvgTimeDomainBodyGyroJerkMagnittudeStandardDeviation=mean(TimeDomainBodyGyroJerkMagnittudeStandardDeviation),
                         AvgFourierTransformBodyAccelerationMeanXAxis=mean(FourierTransformBodyAccelerationMeanXAxis),
                         AvgFourierTransformBodyAccelerationMeanYAxis=mean(FourierTransformBodyAccelerationMeanYAxis),
                         AvgFourierTransformBodyAccelerationMeanZAxis=mean(FourierTransformBodyAccelerationMeanZAxis),
                         AvgFourierTransformBodyAccelerationStandardDeviationXAxis=mean(FourierTransformBodyAccelerationStandardDeviationXAxis),
                         AvgFourierTransformBodyAccelerationStandardDeviationYAxis=mean(FourierTransformBodyAccelerationStandardDeviationYAxis),
                         AvgFourierTransformBodyAccelerationStandardDeviationZAxis=mean(FourierTransformBodyAccelerationStandardDeviationZAxis),
                         AvgFourierTransformBodyAccelerationMeanFreqXAxis=mean(FourierTransformBodyAccelerationMeanFreqXAxis),
                         AvgFourierTransformBodyAccelerationMeanFreqYAxis=mean(FourierTransformBodyAccelerationMeanFreqYAxis),
                         AvgFourierTransformBodyAccelerationMeanFreqZAxis=mean(FourierTransformBodyAccelerationMeanFreqZAxis),
                         AvgFourierTransformBodyAccelerationJerkMeanXAxis=mean(FourierTransformBodyAccelerationJerkMeanXAxis),
                         AvgFourierTransformBodyAccelerationJerkMeanYAxis=mean(FourierTransformBodyAccelerationJerkMeanYAxis),
                         AvgFourierTransformBodyAccelerationJerkMeanZAxis=mean(FourierTransformBodyAccelerationJerkMeanZAxis),
                         AvgFourierTransformBodyAccelerationJerkStandardDeviationXAxis=mean(FourierTransformBodyAccelerationJerkStandardDeviationXAxis),
                         AvgFourierTransformBodyAccelerationJerkStandardDeviationYAxis=mean(FourierTransformBodyAccelerationJerkStandardDeviationYAxis),
                         AvgFourierTransformBodyAccelerationJerkStandardDeviationZAxis=mean(FourierTransformBodyAccelerationJerkStandardDeviationZAxis),
                         AvgFourierTransformBodyAccelerationJerkMeanFreqXAxis=mean(FourierTransformBodyAccelerationJerkMeanFreqXAxis),
                         AvgFourierTransformBodyAccelerationJerkMeanFreqYAxis=mean(FourierTransformBodyAccelerationJerkMeanFreqYAxis),
                         AvgFourierTransformBodyAccelerationJerkMeanFreqZAxis=mean(FourierTransformBodyAccelerationJerkMeanFreqZAxis),
                         AvgFourierTransformBodyGyroMeanXAxis=mean(FourierTransformBodyGyroMeanXAxis),
                         AvgFourierTransformBodyGyroMeanYAxis=mean(FourierTransformBodyGyroMeanYAxis),
                         AvgFourierTransformBodyGyroMeanZAxis=mean(FourierTransformBodyGyroMeanZAxis),##
                         AvgFourierTransformBodyGyroStandardDeviationXAxis=mean(FourierTransformBodyGyroStandardDeviationXAxis),
                         AvgFourierTransformBodyGyroStandardDeviationYAxis=mean(FourierTransformBodyGyroStandardDeviationYAxis),
                         AvgFourierTransformBodyGyroStandardDeviationZAxis=mean(FourierTransformBodyGyroStandardDeviationZAxis),
                         AvgFourierTransformBodyGyroMeanFreqXAxis=mean(FourierTransformBodyGyroMeanFreqXAxis),
                         AvgFourierTransformBodyGyroMeanFreqYAxis=mean(FourierTransformBodyGyroMeanFreqYAxis),
                         AvgFourierTransformBodyGyroMeanFreqZAxis=mean(FourierTransformBodyGyroMeanFreqZAxis),
                         AvgFourierTransformBodyAccelerationMagnittudeMean=mean(FourierTransformBodyAccelerationMagnittudeMean),
                         AvgFourierTransformBodyAccelerationMagnittudeStandardDeviation=mean(FourierTransformBodyAccelerationMagnittudeStandardDeviation),
                         AvgFourierTransformBodyAccelerationMagnittudeMeanFreq=mean(FourierTransformBodyAccelerationMagnittudeMeanFreq),
                         AvgFourierTransformBodyBodyAccelerationJerkMagnittudeMean=mean(FourierTransformBodyBodyAccelerationJerkMagnittudeMean),
                         AvgFourierTransformBodyBodyAccelerationJerkMagnittudeStandardDeviation=mean(FourierTransformBodyBodyAccelerationJerkMagnittudeStandardDeviation),
                         AvgFourierTransformBodyBodyAccelerationJerkMagnittudeMeanFreq=mean(FourierTransformBodyBodyAccelerationJerkMagnittudeMeanFreq),
                         AvgFourierTransformBodyBodyGyroMagnittudeMean=mean(FourierTransformBodyBodyGyroMagnittudeMean),
                         AvgFourierTransformBodyBodyGyroMagnittudeStandardDeviation=mean(FourierTransformBodyBodyGyroMagnittudeStandardDeviation),
                         AvgFourierTransformBodyBodyGyroMagnittudeMeanFreq=mean(FourierTransformBodyBodyGyroMagnittudeMeanFreq),
                         AvgFourierTransformBodyBodyGyroJerkMagnittudeMean=mean(FourierTransformBodyBodyGyroJerkMagnittudeMean),
                         AvgFourierTransformBodyBodyGyroJerkMagnittudeStandardDeviation=mean(FourierTransformBodyBodyGyroJerkMagnittudeStandardDeviation),
                         AvgFourierTransformBodyBodyGyroJerkMagnittudeMeanFreq=mean(FourierTransformBodyBodyGyroJerkMagnittudeMeanFreq)
)
## save the result in working directory
write.table(x=AggregatedDS, file="tidy.txt", row.name=FALSE)