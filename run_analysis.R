######################################################################
# Step1. Merges the training and the test sets to create one data set.
######################################################################

#Set working directory
#setwd("/Users/VivianLu/Desktop/Data Science Reference/CourseEra Getting and Cleaning Data/Course Project/")

#read in training set data 
train_data <- read.table("./data/train/X_train.txt")
#dim(train_data) # 7352*561
#head(train_data)
train_label <- read.table("./data/train/y_train.txt")
#head(train_label)
table(train_label)
train_subject <- read.table("./data/train/subject_train.txt")

#reading in test set data
test_data <- read.table("./data/test/X_test.txt")
#dim(test_data) # 2947*561
test_label <- read.table("./data/test/y_test.txt") 
table(test_label) 
test_subject <- read.table("./data/test/subject_test.txt")

#Merging the 2 sets
joinData <- rbind(train_data, test_data)
dim(joinData) # 10299*561
joinLabel <- rbind(train_label, test_label)
dim(joinLabel) # 10299*1
joinSubject <- rbind(train_subject, test_subject)
dim(joinSubject) # 10299*1

################################################################
# Step2. Extracts only the measurements on the mean and standard 
# deviation for each measurement. 
################################################################
features <- read.table("./data/features.txt")
#dim(features)  # 561*2
#head(features)
mean_StdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
#length(mean_StdIndices) # 66
joinData <- joinData[, mean_StdIndices]
#dim(joinData) # 10299*66
names(joinData) <- gsub("\\(\\)", "", features[mean_StdIndices, 2]) # remove parentheses "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove the dash in column names 
#head(joinData)

####################################################################
# Step3. Uses descriptive activity names to name the activities in 
# the data set
####################################################################
activity <- read.table("./data/activity_labels.txt")
#head(activity)
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) #change to lower case, and replace _ with space for consistency
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) #for "walking upstairs": keeping everything lowercase, but second word with first letter as uppercase
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) #for "walking downstairs": keeping everything lowercase, but second word with first letter as uppercase
activity_label <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activity_label
names(joinLabel) <- "activity"

#####################################################################
# Step4. Appropriately labels the data set with descriptive activity 
# names. 
#####################################################################
names(joinSubject) <- "subject"
clean_data <- cbind(joinSubject, joinLabel, joinData) #merging all 3 together
#dim(clean_data) # 10299*68
write.table(clean_data, "mergeddata.txt") # write out the first dataset

#######################################################################
# Step5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 
######################################################################
subject_Len <- length(table(joinSubject)) # 30
activity_Len <- dim(activity)[1] # 6
column_Len <- dim(clean_data)[2]
result <- matrix(NA, nrow=subject_Len*activity_Len, ncol=column_Len) 
result <- as.data.frame(result) #force into dataframe
colnames(result) <- colnames(clean_data) #take on the same column names as from the cleaned data set
row <- 1
for(i in 1:subject_Len) {
  for(j in 1:activity_Len) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    boolean1 <- i == clean_data$subject
    boolean2 <- activity[j, 2] == clean_data$activity
    result[row, 3:column_Len] <- colMeans(clean_data[boolean1&boolean2, 3:column_Len])
    row <- row + 1
  }
}
head(result)
write.table(result, "data_means.txt") # write out the 2nd dataset

###reading in the data table 
final_data<-read.table("data_means.txt")
