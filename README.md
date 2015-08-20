README
======

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis
------------

This happens via:

R < run_analysis.R --no-save

which creates a dataset called tidydata.txt.

For improved code clarity, I do not do not follow that order. For example, you should have done step 3 to do step 2.

I start out loading the features.txt and activity_labels.txt for descriptive variable names and descriptive activity names.
Then I load the values, subject, and activity for the testing data.  I map the integer activity values to activity names and bind those 3 data frames together into a single data frame.
I then repeat that for the training data and then bind the training and testing data together into a single dataset.

At this point I subset the mean and standard deviation measurements using grep for std & mean. I assume that std, and mean are keywords for the relevant data.
Establishing unique activities and subjects, I allocate a new data frame for results and iterate through the columns, take the mean and populate the result data frame.

This data frame is written to 'tidydata.txt'.
