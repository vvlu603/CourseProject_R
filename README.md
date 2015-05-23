# CourseProject_R

# Course Project for Coursera's Getting and Cleaning Data

This file describes how to use the R script to perform the end goals of Coursera's Getting and Cleaning Data course Project. 

1. Download the .zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip files into your working directory. After unzipping, please rename the unzipped file as "data" for the R script to work. 
2. Save run_analysis.R into the same working directory as the "data" file containing all the unzipped files. 
3. Open RStudio, and use source("run_analysis.R") after setting your working directory. 
4. Two final .txt files will be generated from run_analysis.R. 
  * mergeddata.txt: a textfile that was generated from the merging of the test and training sets into a data frame called "clean_data" (dimensions: 10299 observations of 68 variables). 
  * data_means.txt: A textfile that was generated from clean_data with the averages of each variables for each activity and each subject (dimesnions: 180 observations of 68 variables). 
5. To read in data_means.txt, simply use read.table("data_means.txt"). 


