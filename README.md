Getting and Cleaning Data : Course Project

Introduction : This repository contains my work for the course project for the Coursera course "Getting and Cleaning data", part of the Data Science specialization. What follows first are my notes on the original data.

About the raw data : All datasets are in one zip file. The measurements (561 of them) are unlabeled and can be found in the X_train.txt. The labels of measurements are in the features.txt file. The activity id are in the y_train.txt file and the activity labels are in the activity_labels.txt. The train subjects are in the subject_train.txt file. The same holds for the testing set.

About the script and the tidy dataset : I created a script called run_analysis.R which download, unzip and load raw data. After the script will fitness (labels) the test and training set then merge the test and training sets together. After merging testing and training, only columns that have to do with mean and standard deviation are kept. Lastly, the script will create a tidy data set containing the means of all the columns per subject and per activity. This tidy dataset will be written to a delimited file called tidydata.txt, which can also be found in this repository.

About the Code Book : The CodeBook.md file explains the transformations performed and the resulting data and variables.
