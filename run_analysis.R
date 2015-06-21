#Load dataset 

#Load subject files(person performing each observation)
subject_train <- read.table(file = ".\\UCI HAR Dataset\\train\\subject_train.txt",header = FALSE)
subject_test  <- read.table(file = ".\\UCI HAR Dataset\\test\\subject_test.txt",header = FALSE)

#Load activity for each observation
y_train <- read.table(file = ".\\UCI HAR Dataset\\train\\y_train.txt",header = FALSE)
y_test  <- read.table(file = ".\\UCI HAR Dataset\\test\\y_test.txt",header = FALSE)

#Load activity Labels
activity_labels <- read.table(file = ".\\UCI HAR Dataset\\activity_labels.txt",header = FALSE)

#Load feature List
features <- read.table(file = ".\\UCI HAR Dataset\\features.txt",header = FALSE)
features_transposed <- t(features) #Transpose rows to columns and vice versa

#Load data files
X_train <- read.table(file = ".\\UCI HAR Dataset\\train\\X_train.txt",header = FALSE, colClasses = "numeric")
X_test  <- read.table(file = ".\\UCI HAR Dataset\\test\\X_test.txt", header = FALSE, colClasses = "numeric")



#Merge the training and the test sets to create one data set.
X_merged       <- rbind(X_train, X_test)
subject_merged <- rbind(subject_train, subject_test)
y_merged       <- rbind(y_train, y_test)


#Uses descriptive activity names to name the activities in the data set
colnames(activity_labels) <- c("activity_label_id", "activity_label_desc")
colnames(y_merged)        <- "activity_label_id"


#Appropriately labels the data set with descriptive variable names. 
colnames(X_merged)        <- features_transposed[2,]
colnames(subject_merged)  <- "subject_id"
y_final <- merge(x=y_merged, y=activity_labels, all=TRUE, sorted=FALSE )



#Extract only the measurements on the mean and standard deviation for each measurement. 
    #a.find features containing the terms "mean" and "std" 
features_mean <- grep(pattern="mean()", x=features_transposed[2,] )
features_std  <- grep(pattern="std()",  x=features_transposed[2,] )

    #b. merge and sort the required column IDs
features_required <- sort(x = c(features_mean, features_std))

    #c. Extract required measurements
X_subset <- X_merged[,features_required]
X_final  <- cbind(y_merged, subject_merged, X_subset)


#Create a second, independent tidy data set with the average of each variable for each activity and each subject.
z <- aggregate(x=X_final[,4:length(X_final)], by=list(activity=X_final[,"activity_label_id"], subject=X_final[,"subject_id"]), FUN = "mean")

#Write final output "z" to a text file
write.table(x = z, file = "project_output.txt", row.name=FALSE)
