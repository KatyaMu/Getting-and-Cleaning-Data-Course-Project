Repository for Data Science project in "Getting and Cleaning data" course, contains R script run_analysis.R, README.md file, result dataset tidydataset.txt and code book. 
## Files, listed in repository
* **code_book.md** - 	Code book contains R script descriptin and list of variables
* **README.md**  - Readme file, that contains description of all listed in repository files
* **run_analysis.R** - script that is made to obtain, modify existing data set and create a tidy data set.
* **tidydataset.txt** - result of *run_analysis.R* script, contains ID variables (subject ID and activity name) and average of each variable for each activity and each subject.

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