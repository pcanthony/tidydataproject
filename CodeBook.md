##INTRODUCTION
This repo is submitted as a project for the Coursera Getting and Cleaning Data course.  The data sets in this repo are cleaned-up versions of the UCI HCI data set, which is described here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The UCI data set can be downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The UCI data set contains a large number of variables measured using Samsung Galaxy II smartphones.  Descriptions of the variables included in the tidy data sets in this repo are reproduced below under "Feature Selection" from the UCI documentation.  The variables were measured for 30 human subjects, each carrying one of six activities (e.g., sitting or walking) at a given time and for a given measurement.  Some of subjects were part of a 'test' data set, and the rest were part of a 'training' data set.  In the present tidy data sets, the 'test' and 'training' data sets are combined, and all 30 subjects are represented.   


##Transformations
This section summarizes the transformations that were made to the UCI data to make the tidy data sets in this repo.  For a detailed view of the transformations, please see the R script entitled "run_analysis.R" and the comments therein.  

1. Data from the 'test' data set were loaded from the "X_test.txt" file into a data frame.
2. Variable names from the "features.txt" file were assigned to the columns of the data frame.
3. Variables (columns) with names not ending in "-mean()" or "-std()" were removed.
4. Subject numbers, activity numbers, and activity names were pre-pended to the data frame using the data in the "subject_test.txt", "Y_test.txt" and "activity_labels.txt" files, respectively.
5. Steps 1-4 were repeated with data from the 'training' data set.  To do this, the files named "X_train.txt", "subject_train.txt", and "Y_train.txt" were used in place of the files with "test" in the name.
6. The data frames for 'test' and 'training' data were combined by stacking one on top of the other.
7. The combined data frame was sorted first by subject and then by activity number.
8. The sorted combined data frame was saved as "mytidydataset.txt".
9. A new data frame was constructed by averaging data in the combined data frame for each subject-activity pair.
10. The new data frame was saved as "mytidydataset_avg.txt".


##Variables identifying measurement context

The tidy data sets included in this repo have three variables as the left-most columns:

1. 'subject': the number of the subject (person) for whom the measurements were made	
2. 'activity num': a number representing the activity the subject was carrying out when the measurement was made.	
3. 'activity': a description of the activity the subject was carrying out when the measurement was made. 


##Tidy data sets

There are two tidy data sets included in this repo:

1. mytidydataset.txt
2. mytidydataset_avg.txt

The data sets are comma-delimited text files.

'mytidydataset.txt' includes data sorted first by subject and then by activity number.  There are multiple measurements made for each subject carrying out each activity.  For example, there are 95 measurements made of subject 1 carrying out activity 1, which is walking.  Each measurement occurs in one row of the data set.  

'mytidydataset_avg.txt' includes data sorted the same way, but the data are averaged by subject-activity pair.  So the 95 measurements of subject 1 walking are averaged together, and the averages appear in one row of the data set.


##Feature Selection (reproduced from UCI documentation)

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
