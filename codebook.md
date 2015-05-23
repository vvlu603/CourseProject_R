#Getting and Cleaning Data - CodeBook for Final Course Project 

This file is a codebook that provides a description about the variables and the data that was used for this project. This codebook will also mention any changes ot the data/transformations that were utilized to clean data. 

* The actual site where the data was obtained can be accessed here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* The data for the project can be accessed here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Below are the outlined steps behind run_analysis.R: 

* (optional) Set the working directory
* Read in the training set data: X_train.txt as train_Data, y_train.txt as train_label, and subject_train.txt as train_subject.
* Read in the test set data: X_test.txt as test_data, y_test.txt as test_label, and subject_test.txt as test_subject. 
* Merge the test and training set data by using rbind() to join the _data variables (resulting in a 10299*561 dataframe named joinData), _label variables (resulting in a 10299*1 dataframe named joinLabel), and subject variables (resulting in a 10299*1 dataframe named joinSubject). 
* Read in the features.txt file as features. Obtain the observations with columns that have "Mean" or "Std" in the names, and use them to subset joinData.
* Cleanup the names of the joinData dataframe subset with regular expressions (i.e. removing unnecessary parentheses and dashes). 
* Read in the activity_labels.txt and store as a dataframe named activity. Clean up the names of the activity dataframe to transform the values of joinLabel. 
* Merge all joinSubject, joinLabel, and joinData together as one large dataframe named clean_data. Dimensions should be 10299*68. 
* Use write.table() to create a mergeddata.txt table of the merged data. 
* A second dataset is to be created with the average of each measurement for each activity and each subject. As mentioned from the dataset, there are 30 individuals with 6 activities each, therefore resulting in 180 combinations. For each combination, we calculate the mean of the measurements from a particular combination. The resulting dataframe has a dimension of 180*68. 
* Use write.table() again to write out the second data set as data_means.txt. 
