## Create one R script called run_analysis.R that does the following. ##

## Merges the training and the test sets to create one data set.##
## Extracts only the measurements on the mean and standard deviation for each measurement.##
## Uses descriptive activity names to name the activities in the data set. ##
## Appropriately label the data set with descriptive variable names. ##
## Include a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.##
## You should also include a README.md in the repo with your scripts.##

if (!require("data.table")) {
        install.packages("data.table")
}

if (!require("reshape2")) {
        install.packages("reshape2")
}

if (!require("dplyr")) {
        install.packages("dplyr")
}

require("data.table")
require("reshape2")
require("dplyr")

library(data.table)
library(reshape2)
library(dplyr)

# Data column names
features <- read.table("./features.txt")[,2]

# Activity labels
activity_Labels <- read.table("./activity_labels.txt")[,2]

# Extract only the measurements on the mean and standard deviation for each measurement.
extract_features <- grepl("mean|std", features)

# Load and process X_test & y_test data.
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_Test <- read.table("./test/subject_test.txt")

names(X_test) = features

# Extract the measurements on the mean and standard deviation for each measurement.
X_test = X_test[,extract_features]

# Load activity labels
y_test[,2] = activity_Labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_Test) = "subject"

# Bind data
test_data <- cbind(as.data.table(subject_Test), y_test, X_test)

# Load and process X_train & y_train data.
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")

subject_Train <- read.table("./train/subject_train.txt")

names(X_train) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = X_train[,extract_features]

# Load activity data
y_train[,2] = activity_Labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_Train) = "subject"

# Bind data
train_data <- cbind(as.data.table(subject_Train), y_train, X_train)

# Merge test and train data
data = rbind(test_data, train_data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

write.table(tidy_data, file = "./tidy.txt", row.name=FALSE)