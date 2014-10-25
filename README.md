Getting Cleaning Data Project
=============================
This project tries to achieve the following goals using run_analysis.R script

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data for the above is located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

How To
1. Copy the script to the working directory
2. Also download the data set from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to the working directory
3. At the R prompt (R Studio) execute command - source("./run_analysis.R") 
4. On executing one should see following output on the screen
	[1] "Loading Train data...."
	[1] "Completed Loading Train data"
	[1] "Loading Test data...."
	[1] " Completed Loading Test data"
	[1] " Merging Train and Test data...."
	[1] " COMPLETED Merging Train and Test data"
	[1] "Writing Final Tidy dataset to TidyDataSet.txt file"