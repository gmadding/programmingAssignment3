setwd("~/R/Coursera/week3/project")
###
# Define Libraries Needed
###
library(data.table)
library(dplyr)

###
# 1. Merge training and test sets to create 1 data set
# 2. Extracts only the measurements on the mean and stdev
###

# Load info that applies to all sets
setwd("~/R/Coursera/week3/project/UCI HAR Dataset")
features <- fread('features.txt')
# Rename columns with descriptive names (Item 4 in assignemnt steps)
colnames(features)[1] <- "featureID"
colnames(features)[2] <- "featureName"

activityLabels <- fread('activity_labels.txt')
# Rename columns with descriptive names (Item 4 in assignemnt steps)
colnames(activityLabels)[1] <- "activityID"
colnames(activityLabels)[2] <- "activityName"

# First, test data
setwd("~/R/Coursera/week3/project/UCI HAR Dataset/test")
xTest<-fread('X_test.txt')
# Rename columns with descriptive names, by looping through feature name vector
# These will be used to identify std() and mean() items
colnames(xTest) <- features$featureName

yTest<-fread('y_test.txt')
# Rename columns with descriptive names (Item 4 in assignemnt steps)
colnames(yTest)[1] <- "activityID"

subjectTest<-fread('subject_test.txt')
# Rename columns with descriptive names (Item 4 in assignemnt steps)
colnames(subjectTest)[1] <- "subjectID"

# Scan column names for std() and mean()
stdCols<-grepl('std()',colnames(xTest))
meanCols<-grepl('mean()',colnames(xTest))
# vector with TRUE where name contains mean() or std()
keepCols<-stdCols | meanCols

# Combine data sets while filtering out columns not needed
testData<-cbind(xTest[,keepCols,with=FALSE],yTest,subjectTest)

# Next, train data [same steps as above]
setwd("~/R/Coursera/week3/project/UCI HAR Dataset/train")
xTrain<-fread('X_train.txt')
colnames(xTrain) <- features$featureName

yTrain<-fread('y_train.txt')
colnames(yTrain)[1] <- "activityID"

subjectTrain<-fread('subject_train.txt')
colnames(subjectTrain)[1] <- "subjectID"

stdCols<-grepl('std()',colnames(xTrain))
meanCols<-grepl('mean()',colnames(xTrain))
keepCols<-stdCols | meanCols

trainData<-cbind(xTrain[,keepCols,with=FALSE],yTrain,subjectTrain)

# Now combine test and train data, creating new column for Test/Train
testData$dataType <- 'test'
trainData$dataType <- 'train'

# Combine data sets
combinedData <- rbind(testData,trainData)

###
# 3. create new column with descriptive activity name
###
combinedData$activityName <- activityLabels$activityName[combinedData$activityID]

# Remove unnecessary data items
rm(activityLabels,features,subjectTest,subjectTrain,xTest,xTrain,yTest,yTrain,testData,trainData)
rm(keepCols,meanCols,stdCols)

###
# 5. Create a second, independant tidy data set with the average of each variable for
# each activity and each subject
###
# This average will ignore data Type (Test or Train) and drops Activity ID (not needed)
averageData <- summarize_each(group_by(combinedData[,-c('activityID','dataType')], activityName,subjectID),funs(mean))
# export table
setwd("~/R/Coursera/week3/project")
write.table(averageData,row.name=FALSE, file='averageData.txt')
