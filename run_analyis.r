## big picture: 
## https://rstudio-pubs-static.s3.amazonaws.com/37290_8e5a126a3a044b95881ae8df530da583.html
## Reference link: https://class.coursera.org/getdata-008/forum/thread?thread_id=24
## I browsed on multiple locoations to understand the problem better and get coding ideas.

library(plyr)
#library(dplyr)

filename <- "getdata-projectfiles-UCI HAR Dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename)
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Step 1
# Merge the training and test sets to create one data set
###############################################################################


x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
#str(x_train)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
#str(y_train)

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
#str(subject_train)

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# create 'x' data set: combine the rows
features_data <- rbind(x_train, x_test)
# create 'y' data set: combine the rows
activity_data <- rbind(y_train, y_test)
# create 'subject' data set: combine the rows
subject_data <- rbind(subject_train, subject_test)

# Step #3 read the proper activity names (table of 2 colums: digits and their meaning as activity names)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", head=FALSE)
# update values with correct activity names
activity_data[, 1] <- activity_labels[activity_data[, 1], 2]

# now do Step 2 ...
## Load features names
data_features_names <- read.table("UCI HAR Dataset/features.txt",head=FALSE)

names(features_data)<- data_features_names$V2
names(activity_data)<- c("activity")
names(subject_data)<-c("subject")

## Final part of Step 1: 
## as part of Merge columns to get the data frame Data for all data
subject_activity_data <- cbind(subject_data, activity_data)
Data <- cbind(features_data, subject_activity_data)

## Step 4: extract only mean and standard deviation
meanstd_features_names<-data_features_names$V2[grep("mean\\(\\)|std\\(\\)", data_features_names$V2)]
##Subset the data frame Data by seleted names of Features
selected_names<-c(as.character(meanstd_features_names), "subject", "activity" )

Data<-subset(Data,select=selected_names)
##Check the structures of the data frame Data
#str(Data)

# Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data <- ddply(Data, c("subject","activity"), numcolwise(mean))
write.table(tidy_data, file = "tidydata.txt")
