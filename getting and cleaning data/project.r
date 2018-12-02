library(dplyr)
library(zip)

targetFile <- "data.csv"

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
data <- download.file(url, targetFile, method = "curl")
data <- unzip(targetFile)

#load unzipped files

features <- read.table("./UCI HAR Dataset/features.txt")

labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

x1 <- read.table("./UCI HAR Dataset/train/X_train.txt")
y1 <- read.table("./UCI HAR Dataset/train/Y_train.txt")
s1 <- read.table("./UCI HAR Dataset/train/subject_train.txt")

x2 <- read.table("./UCI HAR Dataset/test/X_test.txt")
y2 <- read.table("./UCI HAR Dataset/test/Y_test.txt")
s2 <- read.table("./UCI HAR Dataset/test/subject_test.txt")

colnames(x1) <- features[ , 2]
colnames(y1) <- paste("activityID")
colnames(s1) <- paste("subjectID")

colnames(x2) <- features[ , 2]
colnames(y2) <- paste("activityID")
colnames(s2) <- paste("subjectID")

colnames(labels) <- paste(c("activityID", "activityType"))

train <- cbind(x1, y1, s1)
test <- cbind(x2, y2, s2)
data <- rbind(train, test)

#segment for measurements
x_labels <- colnames(data)

u_sd <- (grepl("activityID", x_labels) |
         grepl("subjectID", x_labels)  |
         grepl("mean", x_labels)       |
         grepl("std", x_labels)
)

set_u_sd <- data[ , u_sd == TRUE]

#define columns
set_labels <- merge(set_u_sd, labels,
                    by = "activityID",
                    all.x = TRUE)

tidyData <- aggregate(.~ subjectID + activityID, set_labels, mean)

#write data file
write.table(tidyData, "tidyData.txt")
