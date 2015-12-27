# Code to extract tidy data
# the code assumes you have downloaded the data and placed into a directory "UCI HAR Dataset"
# it seems a bit over the top to include a script to also download the zip and unpack this

# setup code
setwd("Z:/docs/work/datasci/3getdata/proj")
library(plyr)
library(reshape2)
#library(dplyr)
setwd("UCI HAR Dataset")


# read measurements and activity labels
activities <- read.table("./activity_labels.txt", stringsAsFactors = F)
activity_index<-activities[,1]
activity_names<-activities[,2]
features<-read.table("./features.txt", stringsAsFactors = F)[,2]
# the features index is also the line number in the file, which is cheap but it works
# (only extracting the measurments on mean and standard deviation)
measurements_index  <- grep(".*mean\\(\\).*|.*std\\(\\).*", features)
measurements_names<-features[measurements_index]


# read measurements based on index 
# converts (activities to factors using activity label)
train<-read.table("./train/X_train.txt")[measurements_index]
train_activities <- read.table("./train/Y_train.txt")[,1]
train_activities<-factor(train_activities, levels = activity_index, labels = activity_names)# as factors
train_subjects <- read.table("./train/subject_train.txt")[,1]
train <- cbind(subject=train_subjects, activity=train_activities, train)
test <- read.table("./test/X_test.txt")[measurements_index]
test_activities<- read.table("./test/Y_test.txt")[,1]
test_activities<-factor(test_activities, levels = activity_index, labels = activity_names)# as factors
test_subjects <- read.table("./test/subject_test.txt")[,1]
test <- cbind(subject=test_subjects, activity=test_activities, test)


# combine data in a long format: subject, activity, variable, value
data <- rbind(train, test)
colnames(data) <- c("subject", "activity", measurements_names)
data_normal <- melt(data, id = c("subject", "activity"))


# calculate means and result for step 5
# I've used the long version as it's easy to verify on the screen
data_means<-plyr::ddply(data_normal, .(subject, activity,variable),summarise,mean=mean(value))
setwd("..")
write.table(data_means, "means.csv", row.names = FALSE, quote = FALSE)
