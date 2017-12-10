library(reshape2)

# Load activity labels + features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
featuresVector <- grep(".*mean.*|.*std.*", features[,2])
featuresVector.names <- features[featuresVector,2]
featuresVector.names = gsub('-mean', 'Mean', featuresVector.names)
featuresVector.names = gsub('-std', 'Std', featuresVector.names)
featuresVector.names <- gsub('-|\\(|\\)', '', featuresVector.names)


# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")
train <- train[,featuresVector]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")
test <- test[,featuresVector]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresVector.names)

# turn activities & subjects into factors
allData$activity <- factor(allData$activity, 
                           levels = activityLabels[,1], 
                           labels = activityLabels[,2])

allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
