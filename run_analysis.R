#This is the main application used to obtain, process and write out the data used for this project

#setwd("c:/Dogbert/Coursera/DataScientistTrack/03_GettingCleaningData/W1/GetCleanDataProject")

data_file_name = "w1_project_data.zip"

# downloads the data we need
downloadData <- function() {
  file_url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  if(!file.exists(data_file_name)) {
    download.file(file_url, destfile=data_file_name, method="curl")
    unzip(data_file_name)
  } else {
    print("zip file already downloaded.")
  }
}

# main program
downloadData()