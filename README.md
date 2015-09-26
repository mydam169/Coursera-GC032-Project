# Coursera-GC032-Project
Course project for the Getting and Cleaning Data course on Coursera

This file describes the steps involved in the R script, `run_analysis.R`.

1. Download the dataset from the URL to the working directory and unzip in a specified folder
2. Load the activity labels, features, train and test datasets
3. Merging all the three train files and the three test files to create seprate train and test data before merging the big train and set data together into just one dataset called "df".
4. Extract only the 79 measurements on the mean and standard deviation from the features data and combine this information to create a new dataset called "dfNew".
5. Merging the new dataset with the activity labels and rename variables with descriptive names
6. Tidying up the dataset by melting the data and casting the melt data with a mean function, the result is the data called `tidyData.txt` with the average of each variable for each activity and each subject.
