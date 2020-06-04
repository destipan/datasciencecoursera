library(dplyr)
library(data.table)
library(tidyr)

## download the dataset 
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')) {
  download.file(fileurl, './UCI HAR Dataset.zip', mode = 'wb')
  unzip('UCI HAR Dataset.zip', exdir = getwd())
}

## reading data and converting

features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

train.x <- read.table('./UCI HAR Dataset/train/X_train.txt')
train.activity <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
train.subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

train <-  data.frame(train.subject, train.activity, train.x)
names(train) <- c(c('subject', 'activity'), features)

test.x <- read.table('./UCI HAR Dataset/test/X_test.txt')
test.activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
test.subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

test <-  data.frame(test.subject, test.activity, test.x)
names(test) <- c(c('subject', 'activity'), features)

## Merges the training and the test sets to create one data set.
all.data <- rbind(train, test)

## Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std.select <- grep('mean|std', features)
sub <- all.data[,c(1,2,mean_std.select + 2)]

## Uses descriptive activity names to name the activities in the data set
activity.labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity.labels <- as.character(activity.labels[,2])
sub$activity <- activity.labels[sub$activity]

## Appropriately labels the data set with descriptive variable names.
new <- names(sub)
new <- gsub("[(][)]", "", new)
new <- gsub("^t", "TimeDomain_", new)
new <- gsub("^f", "FrequencyDomain_", new)
new <- gsub("Acc", "Accelerometer", new)
new <- gsub("Gyro", "Gyroscope", new)
new <- gsub("Mag", "Magnitude", new)
new <- gsub("-mean-", "_Mean_", new)
new <- gsub("-std-", "_StandardDeviation_", new)
new <- gsub("-", "_", new)
names(sub) <- new

## From the data set in step 4, creates a second, independent tidy 
## data set with the average of each variable for each activity and each subject.
data.tidy <- aggregate(sub[,3:81], by = list(activity = sub$activity, subject = sub$subject),FUN = mean)
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)





