#This is the main application used to obtain, process and write out the data used for this project

#setwd("F:/Dogbert/Coursera/DataScience/03_GettingAndCleaningData/W3/GetCleanDataProject")

############# main program ##############
# main function run to complete all the tasks for this project
# Each section of the project is implemented in it's own function for clarity
# You need to load the entire document before attempting to run main()

# Each step also writes out the transformed data frame to preserve the changes
# so that you can run each function independetly without haveing to 
# run the previous steps
main <-  function() {
  
  # 0 download data
  downloadData()
  
  # 1 merge the training and test data
  # files written to "UCI HAR Dataset/merged"
  mergeTrainAndTestData()
  
  # 2 extract mean and std avtivities from merged records
  # produces file "UCI HAR Dataset/merged/X_merged_std_mean.txt"
  # produces file "UCI HAR Dataset/features_std_mean.txt"
  extractMeanAndStd()
  
  # 3 replace the names with descriptive activity names
  # produces file "UCI HAR Dataset/merged/X_merged_std_mean_activities.txt"
  addActivityNames()
  
}

# quick extension of paste that clears spaces and only takes 2 strings
# useful for combining dir/file names
p <- function(str_1, str_2) {  
  return(paste(str_1, str_2, sep=""))
}

# global file locations
data_dir   <- "UCI HAR Dataset/"

train_dir  <- p(data_dir, "train/")
test_dir   <- p(data_dir, "test/")
merged_dir <- p(data_dir, "merged/")

# local zip data file
data_file_name = "w1_project_data.zip"

# 0. downloads the data we need
downloadData <- function() {
  file_url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  if(!file.exists(data_file_name)) {
    download.file(file_url, destfile=data_file_name, method="curl")
    unzip(data_file_name)
  } else {
    print("zip file already downloaded.")
  }
}

# 1. Merges the training and the test sets to create one data set.
mergeTrainAndTestData < function() {
  
  # merge X train/test data
    X_train_file_name  <- p(train_dir, "X_train.txt")
    X_test_file_name  <- p(test_dir, "X_test.txt")
    
    df_X <- mergeFiles(X_train_file_name, X_test_file_name)
    dim(df_X)
  
  # merge Y train/test data
    Y_train_file_name  <- p(train_dir, "Y_train.txt")
    Y_test_file_name   <- p(test_dir, "Y_test.txt")
    
    df_Y <- mergeFiles(Y_train_file_name, Y_test_file_name)
    dim(df_Y)  
  
  # merge subject train/test data
    subject_train_file_name  <- p(train_dir, "subject_train.txt")
    subject_test_file_name   <- p(test_dir, "subject_test.txt")
    
    df_subject <- mergeFiles(subject_train_file_name, subject_test_file_name)
    dim(df_subject)   
  
  # if the merged data dir doesn't exist, create it
  if (!file.exists(merged_dir)){
    dir.create(merged_dir) 
    print("merged dir created")
  } else {
    print("merged dir already exists")
  }
  
  #Write out merged data so we don't have to re-read/merge again
  
  merged_X_file_name <- p(merged_dir, "X_merged.txt")
  merged_X_file <- write.table(df_X, merged_X_file_name)
  
  merged_Y_file_name <- p(merged_dir, "Y_merged.txt")
  merged_Y_file <- write.table(df_Y, merged_Y_file_name)
  
  merged_subject_file_name <- p(merged_dir, "subject_merged.txt")
  merged_suject_file <- write.table(df_subject, merged_subject_file_name)
}

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
extractMeanAndStd <- function() {

  # build a list of columns that contain only mean() and std()
  # all other columns will be skipped
  features_file_name = "UCI HAR Dataset/features.txt"
  
  df_features <- read.table(features_file_name)
  
  #indexes of mean and std features
  #we use grep() because it can filter on both using regular expression
  mean_std_feature_indexes <- grep("mean\\(\\)|std\\(\\)", df_features[, "V2"])
  
  # 66 columns have mean/std
  length(mean_std_feature_indexes) 
  
  # load our merged X data generated in part 1
  merged_X_file_name <- p(merged_dir, "X_merged.txt")
  merged_X_data <- read.table(merged_X_file_name)
  
  # filter out any non-mean/std values using the indexes from above
  merged_X_mean_std_data <- merged_X_data[, mean_std_feature_indexes]
  
  # we have data for only 66 of the original list of features
  dim(merged_X_mean_std_data)
  
  # write out the merged/mean/std only data so we don't have to do this again
  merged_X_mean_std_file_name <- p(merged_dir_name, "X_merged_std_mean.txt")
  merged_suject_file <- write.table(merged_X_mean_std_data, merged_X_mean_std_file_name) 
  
  # write out the mean/std features list so we can use it in step 3
  df_features_mean_std <- df_features[mean_std_feature_indexes,]
  
  features_mean_std_file_name <- p(data_dir, "features_std_mean.txt")
  features_mean_std_file <- write.table(df_features_mean_std, features_mean_std_file_name) 
}

# 3. Uses descriptive activity names to name the activities in the data set
addActivityNames() <- function() {
  
  # load the data saved in the previous function into a dataframe
  merged_X_mean_std_file_name     <- p(merged_dir_name, "X_merged_std_mean.txt")
  df_merged_X_mean_std_activities <- read.table(merged_X_mean_std_file_name)
  
  # read in the features we wrote out in the previous step
  features_mean_std_file_name <- p(data_dir, "features_std_mean.txt")
  features_mean_std_file <- read.table(features_mean_std_file_name)

    # shows "V1", "V2", "V3", "V4 ...
    names(df_merged_X_mean_std_activities)
  
  # remove "()"
  names(df_merged_X_mean_std_activities) <- gsub("\\(\\)", "",     features_mean_std_file[,"V2"])

  # capitalize M
  names(df_merged_X_mean_std_activities) <- gsub("mean",   "Mean", names(df_merged_X_mean_std_activities))

  # capitalize S
  names(df_merged_X_mean_std_activities) <- gsub("std",    "Std",  names(df_merged_X_mean_std_activities))
  
  # remove "-" in column names   
  names(df_merged_X_mean_std_activities) <- gsub("-",      "",     names(df_merged_X_mean_std_activities))
    
    # shows "tBodyAccMeanX", "tBodyAccMeanY", "tBodyAccMeanZ", "tBodyAccStdX"
    names(df_merged_X_mean_std_activities)
  
  #writ out the data frame with the new activity labels
  merged_X_mean_std_activities_file_name <- p(merged_dir_name, "X_merged_std_mean_activities.txt")
  merged_X_mean_std_activities_file      <- write.table(df_merged_X_mean_std_activities, merged_X_mean_std_activities_file_name)  
}

######## HELPER FUNCTIONS #########

## mereges two files from a data set and returns the merged data frame
## assumes both files can be read by "read.table"
mergeFiles <- function(file1, file2) {
  print(paste("reading in data from ", file1))
  df_1 <- read.table(file1)
  print(dim(df_1))
  
  print(paste("reading in data from ", file2))
  df_2 <- read.table(file2)
  print(dim(df_2))
  
  print("merging data")
  return (rbind(df_1, df_2))
}



## runs the main program
main()
