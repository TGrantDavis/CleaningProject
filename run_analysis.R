library (dplyr)

### Download the data file
setwd("C:/Users/Grant/Documents/classes/Cleaning Data")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <- "course_project_data.zip"

if (!file.exists(file)) {
    download.file(url, destfile=file)
}


### Read the common lists for descriptive names
### "activity_labels" is a map of the activity labels from activity codes...
activity_labels <- read.table(unz(file, "UCI HAR Dataset/activity_labels.txt"))
   colnames(activity_labels) <- c("code","label")

### "features" is a map of data column index to feature names...
features <- read.table(unz(file, "UCI HAR Dataset/features.txt"), col.names=c("index","feature"))


### Read and annotate the training data set ("train")
train <- read.table(unz(file, "UCI HAR Dataset/train/X_train.txt"))
   colnames(train) <- features[,"feature"]
set <- vector(length=nrow(train))
   set <- "train"
train_subjects <- read.table(unz(file, "UCI HAR Dataset/train/subject_train.txt"))
   colnames(train_subjects) <- "subject"
### 3) Use descriptive activity names to name the activities in the data set
###   Note: this step is done early, because there are separate label files for the two data sets
train_labels <- read.table(unz(file, "UCI HAR Dataset/train/y_train.txt"))
   colnames(train_labels) <- "activity"
train <- cbind(set,train_subjects,train_labels,train)


### Read and annotate the test data set ("test"), the same way as training
test <- read.table(unz(file, "UCI HAR Dataset/test/X_test.txt"))
   colnames(test) <- features[,2]
set <- vector(length=nrow(train))
   set <- "test"
test_subjects <- read.table(unz(file, "UCI HAR Dataset/test/subject_test.txt"))
   colnames(test_subjects) <- "subject"
### 3) Use descriptive activity names to name the activities in the data set
test_labels <- read.table(unz(file, "UCI HAR Dataset/test/y_test.txt"))
   colnames(test_labels) <- "activity"
test <- cbind(set,test_subjects,test_labels,test)


### 1) Merge the training and the test sets to create one data set, called "all"
all <- rbind(train, test)


### 2) Extract only the measurements on the mean and standard deviation for each measurement. 
selected_cols <- sort( unique( c(
                    grep("subject",  colnames(all)), 
                    grep("activity", colnames(all)),
                    grep("-mean",    colnames(all)), 
                    grep("-std",     colnames(all))  
                 )))
mean_std <- all[,selected_cols]


### 4) Appropriately label the data set with descriptive variable names. 
mean_std[,"activity"] <- activity_labels[match(mean_std[,"activity"], activity_labels[,"code"]),"label"]


### 5) From the data set in step 4, create a second, independent tidy data set 
###    with the average of each variable for each activity and each subject.
averages <- mean_std %>% group_by(activity,subject) %>% summarise_each(funs(mean))
   ### examine the result
   #averages[1:5,1:5]
write.table(averages, file="run_analysis_tidy_data.txt", row.name=FALSE)
