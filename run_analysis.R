## Getting Cleaning Data Project
##
##
##


## Load Library
library(reshape2)

## Load data from the source
datalocation <- "./UCI HAR Dataset"

## Load features/Columns
cols <- read.table(paste(datalocation,"/features.txt", sep=""), sep="", stringsAsFactors=FALSE)[,2]


## Load Train data
print("Loading Train data....")
xtrain <- read.table(paste(datalocation,"/train/X_train.txt", sep = ""), sep="", stringsAsFactors=FALSE)
xtrainsub <- read.table(paste(datalocation,"/train/subject_train.txt", sep = ""), sep="", stringsAsFactors=FALSE)
ytrain <- read.table(paste(datalocation,"/train/y_train.txt", sep = ""), sep="", stringsAsFactors=FALSE)

## Replace xtrain data's columns with columns loaded into cols varaiable
names(xtrain) <- cols

## Replace xtrainsub data's column name as Subject
names(xtrainsub) <- c("Subject")

## Replace ytrain data's column name as Activity
names(ytrain) <- c("Activity")

#Merge Train data
newTrainData <- cbind(xtrainsub,ytrain,xtrain)
print("Completed Loading Train data")

## Load Test data
print("Loading Test data....")
xtest <- read.table(paste(datalocation,"/test/X_test.txt", sep = ""), sep="", stringsAsFactors=FALSE)
xtestsub <- read.table(paste(datalocation,"/test/subject_test.txt", sep = ""), sep="", stringsAsFactors=FALSE)
ytest <- read.table(paste(datalocation,"/test/y_test.txt", sep = ""), sep="", stringsAsFactors=FALSE)

## Replace xtrain data's columns with columns loaded into cols varaiable
names(xtest) <- cols

## Replace xtestsub data's column name as Subject
names(xtestsub) <- c("Subject")

## Replace ytest data's column name as Activity
names(ytest) <- c("Activity")

##Merge Test data
newTestData <- cbind(xtestsub,ytest,xtest)
print(" Completed Loading Test data")

print(" Merging Train and Test data....")
##Merged Train and Test Data
TestTrainData <- rbind(newTrainData,newTestData)
print(" COMPLETED Merging Train and Test data")


## Replace Activity Id with Activity Label
ActLabels <- read.table(paste(datalocation,"/activity_labels.txt", sep = ""), sep="", stringsAsFactors=FALSE)

for (l in 1:nrow(ActLabels)) {
  TestTrainData$Activity[TestTrainData$Activity==l] <- ActLabels$V2[l]
  }


##Filter merged data set for mean and std columns
StdMeanData <- data.frame(Subject=TestTrainData$Subject,Activity=TestTrainData$Activity)
allCols <- names(TestTrainData)
StdMeanData <- cbind(StdMeanData,TestTrainData[,c(grep("mean|std",tolower(allCols)))])

## Average of each variable for each activity and each subject
mStdMeanData <- melt(StdMeanData, id=c("Subject","Activity"))
dcStdMeanData <- dcast(mStdMeanData, Subject+Activity ~ variable,mean)

# Descriptive variable names
names(dcStdMeanData) <- sub("()","",names(dcStdMeanData),fixed=TRUE)
names(dcStdMeanData) <- sub(",","_",names(dcStdMeanData),fixed=TRUE)
names(dcStdMeanData) <- sub("(","_",names(dcStdMeanData),fixed=TRUE)
names(dcStdMeanData) <- sub(")","",names(dcStdMeanData),fixed=TRUE)
names(dcStdMeanData) <- sub(")","",names(dcStdMeanData),fixed=TRUE)

print("Writing Final Tidy dataset to TidyDataSet.txt file")
#print(dcStdMeanData)

write.table(dcStdMeanData,"./TidyDataSet.txt",row.name=FALSE,quote = FALSE)

