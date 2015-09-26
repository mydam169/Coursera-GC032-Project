library(dplyr)
library(reshape2)

##Download the zipped file from the URL and name it GCdat.zip in the working directory
setwd("C:/Users/Lenovo/Downloads")
fileURL <- 
  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "GCdat.zip")

##Unzip the file into a folder called GCdat
unzip("GCdat.zip", exdir = "GCdat")
setwd("C:/Users/Lenovo/Downloads/GCdat")


##Loading datasets 
activityLabels <- read.table("activity_labels.txt")
features <- read.table("features.txt", stringsAsFactors = F)

test <- read.table("test/X_test.txt")
testSubject <-read.table("test/subject_test.txt")
testAct <- read.table("test/y_test.txt")

train <- read.table("train/X_train.txt")
trainSubject <-read.table("train/subject_train.txt")
trainAct <- read.table("train/y_train.txt")

#Step 1: Merging test and train data
dftest <- cbind(testSubject, testAct, test)
dftrain <- cbind(trainSubject, trainAct, train)
df <- rbind(dftest, dftrain)
colnames(df)[c(1,2)] <- c("ID", "Activity")

##Step 2: Extract only mean and SD measurement
featuresID <- grep(".*mean.*|.*std.*", features$V2) #Extract only mean and std measurements
featuresNames <- features$V2[featuresID]            #Feature names associated with the wanted measurements
featuresID <- featuresID + 2                        #shift the index of relevant features to the right by 2 columns
dfNew <- df[c(1,2,featuresID)]                      #Select only the relevant columns

##Step 3+4: Name activities  and label dataset with descriptive names
colnames(activityLabels) <- c("Activity", "ActivityName")
dfNew <- merge(activityLabels, dfNew, by = "Activity")
dfNew <- select(dfNew, -Activity)
colnames(dfNew) <- c("Activity", "Subject", featuresNames)

##Step 5: Tidying up the dataset by making the wide data long
mdf <- melt(dfNew, id = c("Activity", "Subject"))
dfTidy <- cast(mdf, Activity + Subject ~ variable, mean)
#Save the tidy dataset in text format
write.table(dfTidy, "tidyData.txt", row.names = FALSE)






