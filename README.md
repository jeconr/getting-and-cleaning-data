# getting-and-cleaning-data

The runAnalysis.R file was created using R version 3.2.0

It creates the project output data using the following sequence of tasks:

1. Assuming the Samusung data has been downloaded localy and are available at the following subfolders of the present working directory:
	.\UCI HAR Dataset\			The path of the activity labels, readme.txt and features
	.\UCI HAR Dataset\train\	The path of the training data set
	.\UCI HAR Dataset\test\		The path of the test data set

2. Training and Testing data on 
	Subjects, Activity (y_train and y_test) and Observations (X_train and X_test) are loaded into variables from their respective folders (train and test folders mentioned above)

3. Activity Labels and Features are loaded from the ".\UCI HAR Dataset\" folder

4. Data on Subjects, Activity and Observations have their respective training and testing data sets merged (resulting in  subject_merged, y_merged, X_merged)

5. Descriptive columns titles are applied to the subject_id, activity labels and Observations data set(X_merged); Observation labels were extracted from the feature list

6. Column-names containing the term "mean()" or "std()"  were identified and used to subset the Observation data-set (X_subset)

7.  The Activity data-set (y_merged), subject data (subject_merged) and observations (X_subset) were all joined column-wise to create the final data-set to be processed (X_final)

8.  Finally the X_final data-set was aggregated by activity and subject, and the mean of all other numeric variables output.  This aggregated data was written to the "project_output.txt" file
