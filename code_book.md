# Code book
*This is a code book for created tidy data set in tidydataset.txt, for course project "Getting and Cleaning Data"*
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

## Data set information 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Obtaining tidy data set
In order to obtain tidy Data Set for a project following actions should be performed: 
1. Downloading  sourse data for the project from the following [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
Full discription on source data  is located on the following [website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 
2. Performing R script, which can be found in a repository under name *run_analysis.R*

## Actions performed on data:
1. This code requires installation of following packages: *data.table* and *dplyr*
 For this reason in the first lines of the code it is checked if these packages are installed and in case they are missing, they are installed:
`if (!require("data.table")) install.packages("data.table")`
`if (!require("dplyr")) install.packages("dplyr")`
2. Reads feature vector, that contains names of variables, used in data set and "cleans" these names
   * Removing parentheses
   * Modifying names of the variables to make them "readable"
3. Reads lable data frame, that contains following activity labels: 
`WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING`
4. Reads vector y_test and with command `left_join` joins it with activity label data frame, using number of activity as a key and creating new data frame y_test_labels
5. Reads vector subject_test
6. Reads table x_test and assigns column names from feature vector
7. Merges data from subject_test, y_test_labels and x_test into one data set *test* and removes from it columb "numbers"
`test <- cbind(subject_test, y_test_labels, x_test)`
`test <- select(test, -number)`
8. Repeating steps 4 to 5 with training data sets and creating one data set *train*
9. Merging the training and the test sets to create one data set "tidy"
`tidy <- rbind(train, test)`
10. Extracting only the measurements on the mean and standard deviation for each measurement
`tidy <- select(tidy, subject, activity, contains("Mean"), contains("Std"))`
11. Tidying variable names by removing "." and making them more "readable"
12. Creating another tidy data "tidy_mean" set with the average of each variable for each activity and each subject. First grouping data set by subject and by activity and then applying mean to each group. 
`tidy_mean <- tidy %>%`
  `group_by(subject, activity) %>%`
  `summarize_all(funs(mean))`
13. Writing tidy_mean data set in txt file

## Data set variables
**ID**
subject - ID of a subject that is performing activity
activity - name of the activity
**Measurments**
tBodyAccMeanX
tBodyAccMeanY
tBodyAccMeanZ
tGravityAccMeanX
tGravityAccMeanY
tGravityAccMeanZ
tBodyAccJerkMeanX
tBodyAccJerkMeanY
tBodyAccJerkMeanZ
tBodyGyroMeanX
tBodyGyroMeanY
tBodyGyroMeanZ
tBodyGyroJerkMeanX
tBodyGyroJerkMeanY
tBodyGyroJerkMeanZ
tBodyAccMagMean
tGravityAccMagMean
tBodyAccJerkMagMean
tBodyGyroMagMean
tBodyGyroJerkMagMean
fBodyAccMeanX
fBodyAccMeanY
fBodyAccMeanZ
fBodyAccMeanFreqX
fBodyAccMeanFreqY
fBodyAccMeanFreqZ
fBodyAccJerkMeanX
fBodyAccJerkMeanY
fBodyAccJerkMeanZ
fBodyAccJerkMeanFreqX
fBodyAccJerkMeanFreqY
fBodyAccJerkMeanFreqZ
fBodyGyroMeanX
fBodyGyroMeanY
fBodyGyroMeanZ
fBodyGyroMeanFreqX
fBodyGyroMeanFreqY
fBodyGyroMeanFreqZ
fBodyAccMagMean
fBodyAccMagMeanFreq
fBodyBodyAccJerkMagMean
fBodyBodyAccJerkMagMeanFreq
fBodyBodyGyroMagMean
fBodyBodyGyroMagMeanFreq
fBodyBodyGyroJerkMagMean
fBodyBodyGyroJerkMagMeanFreq
angletBodyAccMeangravity
angletBodyAccJerkMeangravityMean
angletBodyGyroMeangravityMean
angletBodyGyroJerkMeangravityMean
angleXgravityMean
angleYgravityMean
angleZgravityMean
tBodyAccStdX
tBodyAccStdY
tBodyAccStdZ
tGravityAccStdX
tGravityAccStdY
tGravityAccStdZ
tBodyAccJerkStdX
tBodyAccJerkStdY
tBodyAccJerkStdZ
tBodyGyroStdX
tBodyGyroStdY
tBodyGyroStdZ
tBodyGyroJerkStdX
tBodyGyroJerkStdY
tBodyGyroJerkStdZ
tBodyAccMagStd
tGravityAccMagStd
tBodyAccJerkMagStd
tBodyGyroMagStd
tBodyGyroJerkMagStd
fBodyAccStdX
fBodyAccStdY
fBodyAccStdZ
fBodyAccJerkStdX
fBodyAccJerkStdY
fBodyAccJerkStdZ
fBodyGyroStdX
fBodyGyroStdY
fBodyGyroStdZ
fBodyAccMagStd
fBodyBodyAccJerkMagStd
fBodyBodyGyroMagStd
fBodyBodyGyroJerkMagStd

