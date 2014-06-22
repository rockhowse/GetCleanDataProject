#This R is the main application used to obtain, process and write out the data used for this project

# 0. Downloads and upzipps the data
file_url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(file_url, destfile=data_file_name, method="curl")
unzip(data_file_name)

setwd("F:/Dogbert/Coursera/DataScience/03_GettingAndCleaningData/W3/GetCleanDataProject/UCI HAR Dataset")

# 1. Merges the training and the test sets to create one data set.
X_train_fn <- read.table("train/X_train.txt")
X_test_fn <- read.table("test/X_test.txt")
df_X <- rbind(X_train_fn, X_test_fn)
str(df_X)

sub_train_fn <- read.table("train/subject_train.txt")
sub_train_fn <- read.table("test/subject_test.txt")
df_sub <- rbind(sub_train_fn, sub_train_fn)
str(df_sub)

y_Train_fn <- read.table("train/y_train.txt")
y_Test_fn <- read.table("test/y_test.txt")
df_y <- rbind(y_Train_fn, y_Test_fn)

