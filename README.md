# CleaningProject
This code is for the course project for week 3 of Coursera class "Getting and Cleaning Data"
by Grant Davis 2/21/15


## Project Requirements: (https://class.coursera.org/getdata-011/human_grading/view/courses/973498/assessments/3/submissions)
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following. 
    1) Merges the training and the test sets to create one data set.
    2) Extracts only the measurements on the mean and standard deviation for each measurement. 
    3) Uses descriptive activity names to name the activities in the data set
    4) Appropriately labels the data set with descriptive variable names. 
    5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Code methods and notes:
### Step 0)  "Download and read the data files"
I chose to leave the file download and all of the data loading in the script.  
To save a bit of runtime, the download is skipped when the zip file already exists.
The "Inertial Data" data is not used here.
The "set" designations (train/test) and the "train_subjects" files are added to the data on the left side of the data frame.
The resulting tables are:
- activity_labels
- features
- train
- test

### Step 3)  "Use descriptive activity names to name the activities in the data set"
The given activity_labels from the separate file are nicely descriptive.
The activity codes in the original data are mapped to those activity labels.
This step is done early (on each of the "train" and "test" sets), because there are separate label files for each of the two data sets.
The results are in:
- train
- test
and they transfer to the subsequent processed data frames.


### Step 1)  "Merge the training and the test sets to create one data set"
The result is:  all


### Step 2)  "Extract only the measurements on the mean and standard deviation for each measurement."
It is not clear in the instructions exactly which columns are desired.
I chose to grep with preceeding dash.  It gives more results than some other methods.  For example, this also includes ones like "-meanFreq".
Maybe in subsequent work, there will be some unneeded varibles with this choice.  The criteria can be easily modified in the script and re-run.
The "subject" and "activity" variables are kept, but "set" is dropped here.
The result is: mean_std


### Step 4)  "Appropriately label the data set with descriptive variable names. "
The variable names come from the given "features" file.
I chose not to modify these names.
They are rather complex and cryptic names, but they are meaningful and concise (and not accidentally corrupted).  
They could be applied to the train and test frames earlier, if that is useful.
They were applied here to more closely follow the order of the instructions.


### Step 5) "From the data set in step 4, create a second, independent tidy data set 
       with the average of each variable for each activity and each subject."
No missing or corrupted data values were encountered, so there is no handling code.
The result is the data frame "averages", and the data file "run_analysis_tidy_data.csv".

## What makes this data set tidy?
- Each variable (representing averages of the means and standard deviations) is in an individual column.
- Each observation (activity + subject) is in an individual row.
- There are many variables in this table. That might be considered not tidy.  They could be put into separate tables.  I consider this single table format to be easy to use for this result.
- Column names indicate the variable names.
- The "activity" codes have been converted to more readable labels.
- The data is written to a single file (per table, since it is a single table).


