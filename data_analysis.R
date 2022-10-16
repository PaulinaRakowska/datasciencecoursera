# 1. Merges the training and the test sets to create one data set.

#### Read all necessary train files and check new data sets (use your own files paths)
subject_train <- read.table("getdata_projectfiles/Dataset/train/subject_train.txt")
str(subject_train)

y_train <- read.table("getdata_projectfiles/Dataset/train/y_train.txt")
str(y_train)

X_train <- read.table("getdata_projectfiles/Dataset/train/X_train.txt")
str(X_train)

### Rename columns in subject_train and y_train to avoid duplicates after merging
subject_train <- subject_train %>% rename(subject = V1)
y_train <- y_train %>% rename(y = V1)

### Bind all train data and check data frame
train <- cbind(subject_train, y_train, X_train)
str(train)

### Read all necessary test files and check new data sets (use your own files paths)
subject_test <- read.table("getdata_projectfiles/Dataset/test/subject_test.txt")
str(subject_test)

y_test <- read.table("getdata_projectfiles/Dataset/test/y_test.txt")
str(y_test)

X_test <- read.table("getdata_projectfiles/Dataset/test/X_test.txt")
str(X_test)

### Rename columns in subject_test and y_test to avoid duplicates after binding
subject_test <- subject_test %>% rename(subject = V1)
y_test <- y_test %>% rename(y = V1)

### Bind all test data and check data frame
test <- cbind(subject_test, y_test, X_test)
str(test)

### Bind train and test data sets and check new data frame
total <- rbind(train, test)
str(total)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

### Read features names form features.txt
features <- read.table("getdata_projectfiles/Dataset/features.txt")
features <- features %>% select(V2)

### Select features containing mean() and std() components
selected_feat <- grep("mean\\(+\\)+|std\\(+\\)+", features$V2)

### "total" data frame includes two additional columns at the beginning 
### so it's necessary to add 2 to every index received from grep() function 
### to select correct features in next step
selected_feat2 <- selected_feat + 2

### Select required variables from total data frame and check it
tidy_data <- total %>% select(1:2, all_of(selected_feat2))
str(tidy_data)

### Check y column to compare it to column receive in the next step
table(tidy_data$y)

# 3, Uses descriptive activity names to name the activities in the data set (y column)

### Read activities from activity_labels.txt file
activity <- read.table("getdata_projectfiles/Dataset/activity_labels.txt")
activity <- activity %>% select(V2)

### Create activity_labels variable
activity_labels <- activity$V2

### Assign activity labels to y column in tidy_data data set
tidy_data$y <- activity_labels[tidy_data$y]

### Check new data frame
str(tidy_data)

### Create table with activities to compare with table created above 
### (with indexes instead of activity labels)
table(tidy_data$y)

# 4. Appropriately labels the data set with descriptive variable names.

### Create new labels for variables by selecting it ("select_feat") from all "features" table
### select_feat and features variables were created above
col_names <- features[selected_feat, "V2"]

### Change existing names using sub() and gsub() functions
col_names <- gsub("-", ".", col_names)
col_names <- sub("\\(\\)", "", col_names)

### Create vector with all variable names
all_names <- c('subject', 'activity', col_names)

### Use colnames() function to name the variables and check new data frame
colnames(tidy_data) <- col_names
str(tidy_data)

# 5. From the above data set creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### First group tidy_data by subject and activity, then summarize all 
### variables with mean value for each subject-activity pair
tidy_data2 <- tidy_data %>% group_by(subject, activity) %>% summarise_all(mean, na.rm = TRUE)
str(tidy_data2)
head(tidy_data2)

### write tidy_data2 as txt file
write.table(tidy_data2, "tidy_data2.txt", row.names = FALSE)