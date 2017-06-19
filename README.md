---
title: "README"
author: "Gordon Madding"
date: "June 18, 2017"
output: html_document
---

## R Markdown

### How to run the file

* Place entire folder UCI HAR Dataset in working directory along with run_analysis.R
* Run the file

### Methodology

The run_analysis.R script works as follows:

* Set working directory and load libraries needed
* Process data files (assumes UCI HAR Dataset folder is copied into working directory)
* Load in Feature/Activity data to be used to enrich data set
* For Test data then Train Data do the following:
    + Load each data set (X, y, subject) and update column names
    + Remove columns from X set that do not contain mean or std
    + Combine data sets into Test/Train data
* Then, add new column to each data set for Type (test or train) and combine the two sets using rbind
* Add new column to combined data set with descriptive name for Activity type
* Remove items from workspace that are no longer needed
* Use summarize each function to average data by activity/subject
* Write averageData to file

### Variable names

Data Tales:

* combinedData
    + This is the combined Data set
* averageData
    + This is the average data, grouped by Activity type then subject ID
    
Variables:

The following variable names were created in script

* featureID
    + Numeric Code for the feature
    + Found in first column of features.txt
* featureName
    + Description of feature
    + Found in second column of features.txt
* activityID
    + Numeric code for activity
    + Found in first column of activity_labels.txt
* activityName
    + Description of activity
    + Found in second column of activity_labels.txt
* subjectID
    + Numeric ID (1-30) for the subject
* dataType
    + test for data from the test data set
    + train for data that comes from the train data set

