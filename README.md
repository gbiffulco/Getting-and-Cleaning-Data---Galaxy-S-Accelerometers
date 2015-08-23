# Getting-and-Cleaning-Data Samsung Galaxy S Accelerometers

## R Script

run_analysis.R is a script that does the following:

- Merges the training and the test sets from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to create one data set
- Extracts only the measurements on the mean and standard deviation for each measurement
- Renames the activity names in the data set using descriptive activity names
- Labels the data set with descriptive variable names

## Steps taken on this project

1. Downloaded and extracted the data
2. Modified working directory
3. Created run_analysis.R file
4. Generated a subset of the data using script to produce a tidy data file (tidy.txt)
5. Created README and CodeBook markup 
6. Copied key files of working directory to the synced folder with GitHub repository

## Dependencies

dplyr
reshape2
data.table
