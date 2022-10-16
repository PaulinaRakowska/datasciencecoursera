# Getting and Cleaning Data Course Project

## Data source
The data was obtained from the site:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
 
 ## Tidy dataset
 Tidy data (**tidy_data2.csv** file) was obtained from above source as follow:
 - The trainig and the test sets were merged to create one data set.
 - Only features with *mean()* and *std()* components were extracted for each measurement (according to **features.txt** file from the project data)
 - Activities in table were assigned according to **activity_labels.txt** file from project data.
 - Variable names were lebeled as same as features in **features.txt** file.
 - Tide data set was created with the average of each variable for each subject and each activity.

All above steps are described in **data_analysis.R** file. It also contains code required to clean the data.
