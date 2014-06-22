#This R is the main application used to obtain, process and write out the data used for this project

# 0. Downloads and upzipps the data
file_url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(file_url, destfile=data_file_name, method="curl")
unzip(data_file_name)

setwd("F:/Dogbert/Coursera/DataScience/03_GettingAndCleaningData/W3/GetCleanDataProject/UCI HAR Dataset")

# 1. Merges the training and the test sets to create one data set.
  
  # subjects
  sub_train <- read.table("train/subject_train.txt")
  sub_test <- read.table("test/subject_test.txt")
  df_sub <- rbind(sub_train, sub_test)
  names(df_sub) <- "subject"
  str(df_sub) # 10299x1
  
  # activity labels
  y_Train_fn <- read.table("train/y_train.txt")
  y_Test_fn <- read.table("test/y_test.txt")
  df_y <- rbind(y_Train_fn, y_Test_fn)
  names(df_y) <- "activity"
  str(df_y) # 10299x1
  
  # observation
  X_train <- read.table("train/X_train.txt")
  X_test <- read.table("test/X_test.txt")
  df_X <- rbind(X_train, X_test)
  dim(df_X) # 10299x561
  
  # don't combine them yet, do that after stripping out the features

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

  features <- read.table("features.txt")
  indices_mean_std_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
  df_X <- df_X[, indices_mean_std_features]
  names(df_X) <- features[indices_mean_std_features, 2]
  names(df_X) <- gsub("\\(|\\)", "", names(df_X))
  dim(df_X) # 10299x66

# 3. Uses descriptive activity names to name the activities in the data set

  activities <- read.table("activity_labels.txt")
  activities[, 2] = gsub("_", " ", as.character(activities[, 2]))
  df_y[,1] = activities[df_y[,1], 2]
  str(df_y)

# 4 Appropriately labels the data set with descriptive variable names. 

  #append on subject and activity data
  df_all_clean <- cbind(df_sub, df_y, df_X)
  str(df_all_clean)
  write.table(df_all_tidy, "X_y_sub_combined_clean_data.txt")
  dim(df_all_clean)

# 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


