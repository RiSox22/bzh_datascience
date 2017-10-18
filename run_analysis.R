Sys.info()
# FRANCE . Windows 7 x64 build 7601 SP1 with R version 3.3.0 (2016-05-03)

# Workspace
getwd()
if (!file.exists("R")) {dir.create("R")}
setwd("./R")

# Load packages
library(dplyr)
library(reshape2)

# Download and unzip data
fileurl<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="dataset.zip")
unzip("dataset.zip")

# labels of 561 variables
features<-data.table::fread("./UCI HAR Dataset/features.txt")
# labels of 6 activities
activity_labels<-data.table::fread("./UCI HAR Dataset/activity_labels.txt")

# Train Measurements
x_train<-data.table::fread("./UCI HAR Dataset/train/X_train.txt")
# id of 6 train activities
y_train<-data.table::fread("./UCI HAR Dataset/train/y_train.txt")	
# id of train people
subject_train<-data.table::fread("./UCI HAR Dataset/train/subject_train.txt")	

# Train Measurements
x_test<-data.table::fread("./UCI HAR Dataset/test/X_test.txt")
# id of 6 train activities
y_test<-data.table::fread("./UCI HAR Dataset/test/y_test.txt")
# id of train people
subject_test<-data.table::fread("./UCI HAR Dataset/test/subject_test.txt")

names(activity_labels)<-c("id_activity","label_activity")

# load & recode train echantillon
# Warning : names of 561 variables contains specials characters "-,()" and contains both lower/upper
# Be careful with names of 561 variables or change that with gsub/grep but there are 561...
names(x_train)<-t(features[,2])
names(subject_train)<-"subject"
names(y_train)<-"id_activity"
activity_train<-merge(y_train,activity_labels,by="id_activity",all=T,sort=FALSE)
train<-bind_cols(subject_train,activity_train,x_train)
train[,echantillon:="train"]
train<-train[,c(565,1:564)]

# load & recode test echantillon
# Warning : names of 561 variables contains specials characters "-,()" and contains both lower/upper
# Be careful with names of 561 variables or change that with gsub/grep but there are 561...
names(x_test)<-t(features[,2])
names(subject_test)<-"subject"
names(y_test)<-"id_activity"
activity_test<-merge(y_test,activity_labels,by="id_activity",all=T,sort=FALSE)
test<-bind_cols(subject_test,activity_test,x_test)
test[,echantillon:="test"]
test<-test[,c(565,1:564)]

# concatenate train data & test data to one dataset
data<-bind_rows(train,test)
data<-as.data.frame(data)
data$echantillon<-factor(data$echantillon)
data$label_activity<-factor(data$label_activity)
dim(data)

# extraction variables mean() et std()
labels<-names(data)[grep("echantillon|subject|id_activity|label_activity|mean()|std()",names(data))]
data<-select(data,labels)
names(data)

# Aggregate variables to the mean by subject & activity
# it's possibly with aggregate function or dmelt/dcast function of reshape2
data2<-aggregate(data[, 5:83], list(data$subject, data$label_activity), mean)
names(data2)[1:2]<-c("subject","label_activity")
data2<-arrange(data2,subject,label_activity)

# Data vizualisation of subject 1 & 2 on the 6 activities
data2[data2$subject==1 | data2$subject==2,c(1:5)]

# Export tidy data to analyze
# Warning : names of 561 variables contains specials characters "-,()" and contains both lower/upper
# First choice
data.table::fwrite(data2,file="./UCI HAR Dataset/tidydata_eric.txt",append=FALSE,quote=FALSE,sep=";")
# Choice of MOOC
write.table(data2, file = "./UCI HAR Dataset/tidydata.txt",row.names=FALSE, col.names=TRUE, sep=";")
# Size of file exported in octets
file.size("./UCI HAR Dataset/tidydata.txt")


	
