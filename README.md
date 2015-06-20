Coursera: Getting and Cleaning Data Course Project

Project Goal:
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. 
This "tidy data" is prepared to be potentially used in later analyses. 
The UC Irvine 'Human Activity Recognition Using Smartphones Data Set' being used in this project is described below.

UCI HAR Dataset:
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Number of Instances: 10,299
Number of Attributes: 561

Dataset Hyperlink:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Repository Files Described Below:
README.md
CodeBook.md
run_analysis.R

README.md:
This file explains how all of the scripts work and how they are connected.
This is the file that you are reading right now.

CodeBook.md:
The code book describes the variables, the data, and any transformations or work that you performed to clean up the data.

run_analysis.R:
This R script does the following. 

Assumptions:
*The script assumes that the files from the UCI HAR Dataset have been downloaded and unzipped into the current working directory
*All of the folders and files have the same name and hierarchy as in the .zip file
*Working internet connection to download 'dplyr' and 'reshape2' R packages if they are not already downloaded
*The measurement columns in the ultimate dataset selected are those which contain "Mean", "mean", "Std", or "std" in any part of their name

Script Steps:
1) Merges the 'training' and the 'test' data to create one data set.

2) Extracts only the measurements on the mean and standard deviation for each measurement. 

3) Uses descriptive activity names to name the activities in the data set

4) Appropriately labels the data set with descriptive measurement variable names. 

5) From the data set in step 4, creates a second, independent tidy data set with the average of each measurement variable for each activity and each subject.

Script Steps Notes:

1) Merges the training and the test sets to create one data set.

Install the 'dplyr' & 'reshape2' if they are not currently installed
Load these packages within R for later on in the code
Read in the test data files from the working directory and respective folder ('subject_test','X_test','y_test')
Combine the test data by column (cbind) such that each row represents a subject, an activity, & its measurements
Label these columns for later parts of the code by Subject # & Activity #
Read in the train data files from the working directory and respective folder ('subject_train','X_train','y_train')
Combine the train data by column (cbind) such that each row represents a subject, an activity, & its measurements
Label these columns for later parts of the code by Subject # & Activity #
Combine the 'test' and 'train' datasets, rbind them together as their dimensions match in this respect to get an aggregate dataset

2) Extracts only the measurements on the mean and standard deviation for each measurement variable. 

Read in the features that correspond to the different measurement variables in the X_train & X_test datasets
Select only the columns pertaining to activity, subject, and those which represent a mean or standard deviation as a new dataset

3) Uses descriptive activity names to name the activities in the data set

Read in the "Activity" labels dataset that correspond to the different activities & # on which measurements are recorded by subject
Join the two datasets along the common “ActIndex” # column
Label the values of the combined tables with the activity

4) Appropriately labels the data set with descriptive variable names

Remove all the extraneous characters and typographical errors in the measurement variable names
Make the "Subject" column a factor variable to be able to summarize information later
Sort all of the data in alphabetical order by "Subject" & "Activity" columns

5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Create a narrow form of the data by subject & each activity, along with their measurements by rows
Summarize the new narrow form of the data by the mean for each measurement, going by "Subject" & "Activity" in wide format
Write the newly created 'tidy data' table as a text file (.txt) to the working directory
