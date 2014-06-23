Average Features by Subject and Activity
=========================================
This project contains a single R script that acts upon a public data set containing smartphone data.

Here is some more background on the original project that was used to collect the data:

   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data that was used in the project: 

   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The result of utilizing the run_analysis.R file is a single file written using the write.table() R function and contains the average for all mean and standard deviation based readings grouped by subject and activity. 

Application Flow
=================
This application is contained inside a single .R file and was originally architected by detailing each of the 5 steps in a separate function with a save/load procedure to preserve each of the data transformation steps.

However after the code got too cumbersome, it was re-done in line to take advantage of already loaded memory strucutres. 

The code is comprised of 5 stages:

1. Merges the training and the test sets to create one data set.

In this stage, we read in the training and test data sets, binding them using rbind to create a larger complete data set. 

Files Read:

\UCI HAR Dataset\train\X_train.txt
\UCI HAR Dataset\test\X_test.txt

\UCI HAR Dataset\train\y_train.txt
\UCI HAR Dataset\test\y_test.txt

\UCI HAR Dataset\train\subject_train.txt
\UCI HAR Dataset\test\subject_test.txt

*NOTE* I chose to NOT combine the three datasets here. instead electing to do it in step 4 down below due to the challenges of the filtering in step 2.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

The original data set contained 561 features, but in this step we eliminate all non-mean and non-std features resulting in a preservation of 66 total features.

3. Uses descriptive activity names to name the activities in the data set

In this third step, we extract and clean up the names in the existing activity list file located here:

\UCI HAR Dataset\activity_labels.txt

We then populate our combined data set with these labels instead of the numeric keys originally provided.

4. Appropriately labels the data set with descriptive variable names. 

This stage was originally meant to only include the activity labels, but was expanded in to include the addition of the subject data and the more descriptive activity labels.

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

In this final step, we utilize the existing combined and cleaned data set so that the data shows the average for each factor grouped by subject and activity.

I chose to use the data.table package with lapply because it was the most concise way of accomplishing it. 

There is a single file produced which is located here upon creation:

\UCI HAR Dataset\df_all_clean_tidy.txt

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.