#Checking and installing required data packages

if (!require("data.table")) install.packages("data.table")
if (!require("dplyr")) install.packages("dplyr")

#reading fatures(column names) from .txt file and creating list of features
features <- as.data.table(read.table("features.txt", col.names = c("index", "fname")))
features <- as.character(features$fname)

#Creating "clean" names of the variables
features <- gsub("\\()", "", features)
features <- gsub("\\(", "-", features)
features <- gsub("\\)", "", features)
features <- gsub("-mean", "Mean", features)
features <- gsub("-std-", "Std", features)

#WORKING WITH LABELS
#reading activity labels into table
labels <- read.table("activity_labels.txt", col.names = c("number", "activity"))
labels$activity <- as.character(labels$activity)

#Working with test data
y_test <- read.table("./test/y_test.txt", col.names = "number")

#creating a data table from labels and y_test
y_test_labels <- as.data.table(left_join(y_test, labels, by = "number"))
subject_test <- read.table("./test/subject_test.txt", col.names = c("subject"))
x_test <- read.table("./test/x_test.txt", col.names = features)

#merging 3 data tables together with cbind (by column)
test <- cbind(subject_test, y_test_labels, x_test)
test <- select(test, -number)


#Working with train data
y_train <- read.table("./train/y_train.txt", col.names = "number")

#creating a data table from labels and y_train
y_train_labels <- as.data.table(left_join(y_train, labels, by = "number"))
subject_train <- read.table("./train/subject_train.txt", col.names = c("subject"))
x_train <- read.table("./train/X_train.txt", col.names = features)

#merging 3 data tables together with cbind (by column)
train <- cbind(subject_train, y_train_labels, x_train)
train <- select(train, -number)

#merging the training and the test sets to create one data set "tidy"
tidy <- rbind(train, test)

#extracting only the measurements on the mean and standard deviation for each measurement
tidy <- select(tidy, subject, activity, contains("Mean"), contains("Std"))

#making variable names to look even better
colnames(tidy) <- gsub("\\.", "", colnames(tidy))
colnames(tidy) <- gsub("std", "Std", colnames(tidy))
tidynames <- colnames(tidy)

#creating another tidy data "tidy_mean" set with the average of each variable for each activity and each subject
tidy_mean <- tidy %>%
  group_by(subject, activity) %>%
  summarize_all(funs(mean))

#writing tidy dataset in a file
write.table(tidy_mean, "tidydataset.txt", row.names = FALSE, quote = FALSE)
