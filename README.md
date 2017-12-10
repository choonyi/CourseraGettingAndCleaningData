# CourseraGettingAndCleaningData
This is a programming assignment submission

The R script, run_analysis.R, does the following:

1. Read the activity label and feature info
2. Convert the activity label and feature name to become character class
3. Derive Feature Vector to keep only those columns which are mean or standard deviation.
4. Read both train and test datasets with Activity and Subject
5. Read both Activity and Subject of test and train datasets, merge the 3 to form new train and test datasets.
6. Merge Train and Test datasets to form a complete full data.
7. Rename the column names of full data.
8. Convert the activity and subject columns to become factor.
9. Create tidy dataset with the mean value of each variable for each subject and activity pair.

The end result is output to the file "tidy.txt".
