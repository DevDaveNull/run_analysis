#load datasets.zip
if(!file.exists("./data")){dir.create("./data")}
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles
%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data/Dataset.zip")
#unzip datasets
zipF<- "./data/Dataset.zip"
outDir<-"./data/"
unzip(zipF,exdir="./data")

#read data 
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt") 
features <- read.table("./data/UCI HAR Dataset/features.txt")

#test
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
testData <- cbind(y_test,subject_test,X_test)
#train
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
trainData <- cbind(y_train,subject_train,x_train)


#Merges the training and the test sets to create one data set
Df <- rbind(trainData,testData)

#Use descriptive activities names for activity measurements


allNames <- c("subject", "activity", as.character(features$V2))
meanStdColumns <- grep("subject|activity|[Mm]ean|std", allNames, value = FALSE)
reducedSet <- Df[ ,meanStdColumns]
#Appropriately Label the Dataset with Descriptive Variable Names

names(activity_labels) <- c("activityNumber", "activityName")
reducedSet$V1.1 <- activity_labels$activityName[reducedSet$V1.1]

#add descriptive names

reducedNames <- allNames[meanStdColumns]    # Names after subsetting
reducedNames <- gsub("mean", "Mean", reducedNames)
reducedNames <- gsub("std", "Std", reducedNames)
reducedNames <- gsub("gravity", "Gravity", reducedNames)
reducedNames <- gsub("[[:punct:]]", "", reducedNames)
reducedNames <- gsub("^t", "time", reducedNames)
reducedNames <- gsub("^f", "frequency", reducedNames)
reducedNames <- gsub("^anglet", "angleTime", reducedNames)
names(reducedSet) <- reducedNames 

#Create tidy data set with average of each variable, by activity, by subject
library(plyr)
tidydata<- ddply(reducedSet, c("subject","activity"), numcolwise(mean))

#Write tidy data to ouput file
write.table(tidydata,file="tidydata.txt",row.names=FALSE)

