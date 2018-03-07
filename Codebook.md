Activity and Subject
In the file, the first column contains the identifier of the user of the device, the second column contains one of 6 types of human activity. "LAYING" "SITTING" "STANDING" "WALKING" "WALKING_DOWNSTAIRS" or "WALKING_UPSTAIRS" (activity)

how the script works
Load both test and train data and unzip data
Load the features and activity labels.
Extract the mean and standard deviation column names and data.
Process the data. There are two parts processing test and train data respectively.
Merge data set.
P.S. Features are normalized and bounded within [-1,1]. Each feature vector is a row on the text file.
