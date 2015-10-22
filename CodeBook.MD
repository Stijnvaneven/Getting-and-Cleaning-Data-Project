
FOR BIG PICTURE INFO, PLEASE SEE:
# https://rstudio-pubs-static.s3.amazonaws.com/37290_8e5a126a3a044b95881ae8df530da583.html
# Reference link: https://class.coursera.org/getdata-008/forum/thread?thread_id=24

VARIABLES:
Variables to store the data from the training sets
- x_train
- y_train

Variables to store the data from the test sets
- x_test
- y_test

Variable for the subject sets
- subject_test
- subject_train

Combine the X and Y data; 
- Combine the X data and call X data the features_data
- Combine the Y data and call Y data the activity_data
- Combine the subject sets into subject_data

Assign proper activity name to activity_data
  - activityLabels

dataFeaturesNames: 
- stores the info from features.txt

Variable Data
  - contains combination of all data

selectedNames
- contains the means and averages columns and  "subject", "activity" columns.
- Use this to subset the Data set

Then obtain averages and create tidy set


