# Code Book for Getting and Clearning Data - Final Project #

## Study design ##
The goal of this project is to prepare tidy data that can be used for later analysis. The data used in this project was taken from 

[UC Irving Machine Learning Repository - Human Activity Recognition Using Smartphones](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)


<p>Thirty volunteers aged 19-48 were studied. They did six activities while wearing a Samsung Galaxy S II on their waist. The phone sensors were used to collect acceleration and velocity data at 50Hz. The data was split randomly: 70% for training and 30% for testing.</p>

<p>The sensor data was then cleaned and divided it into fixed windows of 2.56 seconds with 50% overlap. Then, the acceleration signals were separated into body and gravity components using a low-pass filter. Finally, the features from each window were extracted for further analysis.

[The original zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) with the data is available for download.</p>


<p>The database features are derived from accelerometer (tAcc-XYZ) and gyroscope (tGyro-XYZ) signals in three axes (X, Y, Z). 
These signals (time domain signals (prefix 't' to denote time)) were captured at a constant rate of 50 Hz and processed to remove noise.</p>
 - Signals were separated into body and gravity acceleration using a low-pass Butterworth filter.
 - Body linear acceleration and angular velocity were used to derive Jerk signals.
 - Magnitude of three-dimensional signals was calculated using the Euclidean norm.
 - Some signals underwent a Fast Fourier Transform (FFT) to convert them into frequency domain signals.



## Script for cleaning the raw data ##

The script [**run_analysis.R**](run_analysis.R) does the following with the raw data described above:

- reads the test and training data sets from **/raw-data/** into R
    + `activities` - contains the activity labels from the file "activity_labels.txt"
    + `features` - contains the original feature names from the file "features_info.txt"
    + the rest of the required data was read in under the same name as each of the file names (undrescores were removed for the R object names)
- creates easy to read labels for the variables
    + all of the text from the data was cleaned to remove non-alphabetic characters, and words were expanded from abbreviations to make more sense to someone not familiar with the data
- merges and cleans up the data sets
    + the *test* and *train* data sets were combined by combining the respective counterparts - subject, activity and data information, by using the *rbind()* function
    + a new object called **filteredData** was created by using the *cbind()* function and assigning the cleaned up text as column headers for the data
- extracts only the information related to the *mean* and *standard deviation* variables 
    + only variables mentioning the *mean* and *standard deviation* were kept resulting in the updated **filteredData** object that consists of 10,299 observations across 88 variables
    + the first 2 variables are factors (see description of "SubjectID" and "Activity" below)
    + the rest are numerical values that each range from -1 to 1 
- next, it groups the data by *SubjectID* and *Activity* and averages each of the variables from the previous data set resulting in an object called **tidyData** that consists of 180 observations across 88 variables - one for each feature average per Subject-Activity pair
- both resulting data sets are also saved as .csv files **filteredData.csv** for the first data set **tidyData.csv** and **tidyData.txt** for the second data set


## Variable names in cleaned data ##

<p> The variable names in the cleaned data represent the measurements that were taken and processed during the study. The list is for the variables in the **filteredData** data set. The variable names are identical in the **tidyData** data set, but they add the prefix "Avg" to all variables, except for the SubjectID and Activity variables. "Avg" signifies that these are averages of the measurements listed.</p>


* `SubjectID` - A factor of the number identifying the subject tested (there are a total of 30 subjects identified by numbers 1-30)
* `Activity` - A factor of the activities performed by the subject
  + `Walking` - The subject was walking on a flat surface
  + `Walking upstairs` - The subject was walking upstairs
  + `Walking downstairs` - The subject was walking downstairs
  + `Sitting` - The subject was sitting 
  + `Standing` - The subject was standing 
  + `Laying` - The subject was laying down 
* `BodyAccelerationMeanX` - 	Body acceleration mean along the X-axis
* `BodyAccelerationMeanY` - 	Body acceleration mean along the Y-axis
* `BodyAccelerationMeanZ` - 	Body acceleration mean along the Z-axis
* `BodyAccelerationStdDeviationX` - 	Body acceleration standard deviation along the X-axis
* `BodyAccelerationStdDeviationY` - 	Body acceleration standard deviation along the Y-axis
* `BodyAccelerationStdDeviationZ` - 	Body acceleration standard deviation along the Z-axis
* `GravityAccelerationMeanX` - 	Gravity acceleration mean along the X-axis
* `GravityAccelerationMeanY` - 	Gravity acceleration mean along the Y-axis
* `GravityAccelerationMeanZ` - 	Gravity acceleration mean along the Z-axis
* `GravityAccelerationStdDeviationX` - 	Gravity acceleration standard deviation along the X-axis
* `GravityAccelerationStdDeviationY` - 	Gravity acceleration standard deviation along the Y-axis
* `GravityAccelerationStdDeviationZ` - 	Gravity acceleration standard deviation along the Z-axis
* `BodyAccelerationJerkMeanX` - 	Body acceleration jerk mean along the X-axis
* `BodyAccelerationJerkMeanY` - 	Body acceleration jerk mean along the Y-axis
* `BodyAccelerationJerkMeanZ` - 	Body acceleration jerk mean along the Z-axis
* `BodyAccelerationJerkStdDeviationX` - 	Body acceleration jerk standard deviation along the X-axis
* `BodyAccelerationJerkStdDeviationY` - 	Body acceleration jerk standard deviation along the Y-axis
* `BodyAccelerationJerkStdDeviationZ` - 	Body acceleration jerk standard deviation along the Z-axis
* `BodyAngularVelocityMeanX` - 	Body angular velocity mean along the X-axis
* `BodyAngularVelocityMeanY` - 	Body angular velocity mean along the Y-axis
* `BodyAngularVelocityMeanZ` - 	Body angular velocity mean along the Z-axis
* `BodyAngularVelocityStdDeviationX` - 	Body angular velocity standard deviation along the X-axis
* `BodyAngularVelocityStdDeviationY` - 	Body angular velocity standard deviation along the Y-axis
* `BodyAngularVelocityStdDeviationZ` - 	Body angular velocity standard deviation along the Z-axis
* `BodyAngularVelocityJerkMeanX` - 	Body angular velocity jerk mean along the X-axis
* `BodyAngularVelocityJerkMeanY` - 	Body angular velocity jerk mean along the Y-axis
* `BodyAngularVelocityJerkMeanZ` - 	Body angular velocity jerk mean along the Z-axis
* `BodyAngularVelocityJerkStdDeviationX` - 	Body angular velocity jerk standard deviation along the X-axis
* `BodyAngularVelocityJerkStdDeviationY` - 	Body angular velocity jerk standard deviation along the Y-axis
* `BodyAngularVelocityJerkStdDeviationZ` - 	Body angular velocity jerk standard deviation along the Z-axis
* `BodyAccelerationMagnitudeMean` - 	Body acceleration magnitude mean
* `BodyAccelerationMagnitudeStdDeviation` - 	Body acceleration magnitude standard deviation
* `GravityAccelerationMagnitudeMean` - 	Gravity acceleration magnitude mean
* `GravityAccelerationMagnitudeStdDeviation` - 	Gravity acceleration magnitude standard deviation
* `BodyAccelerationJerkMagnitudeMean` - 	Body acceleration jerk magnitude mean
* `BodyAccelerationJerkMagnitudeStdDeviation` - 	Body acceleration jerk magnitude standard deviation
* `BodyAngularVelocityMagnitudeMean` - 	Body angular velocity magnitude mean
* `BodyAngularVelocityMagnitudeStdDeviation` - 	Body angular velocity magnitude standard deviation
* `BodyAngularVelocityJerkMagnitudeMean` - 	Body angular velocity jerk magnitude mean
* `BodyAngularVelocityJerkMagnitudeStdDeviation` - 	Body angular velocity jerk magnitude standard deviation
* `FrequencyBodyAccelerationMeanX` - 	Body acceleration mean in frequency domain (X-axis)
* `FrequencyBodyAccelerationMeanY` - 	Body acceleration mean in frequency domain (Y-axis)
* `FrequencyBodyAccelerationMeanZ` - 	Body acceleration mean in frequency domain (Z-axis)
* `FrequencyBodyAccelerationStdDeviationX` - 	Body acceleration standard deviation in frequency domain (X-axis)
* `FrequencyBodyAccelerationStdDeviationY` - 	Body acceleration standard deviation in frequency domain (Y-axis)
* `FrequencyBodyAccelerationStdDeviationZ` - 	Body acceleration standard deviation in frequency domain (Z-axis)
* `FrequencyBodyAccelerationMeanFrequencyX` - 	Body acceleration mean frequency (X-axis)
* `FrequencyBodyAccelerationMeanFrequencyY` - 	Body acceleration mean frequency (Y-axis)
* `FrequencyBodyAccelerationMeanFrequencyZ` - 	Body acceleration mean frequency (Z-axis)
* `FrequencyBodyAccelerationJerkMeanX` - 	Body acceleration jerk mean in frequency domain (X-axis)
* `FrequencyBodyAccelerationJerkMeanY` - 	Body acceleration jerk mean in frequency domain (Y-axis)
* `FrequencyBodyAccelerationJerkMeanZ` - 	Body acceleration jerk mean in frequency domain (Z-axis)
* `FrequencyBodyAccelerationJerkStdDeviationX` - 	Body acceleration jerk standard deviation in frequency domain (X-axis)
* `FrequencyBodyAccelerationJerkStdDeviationY` - 	Body acceleration jerk standard deviation in frequency domain (Y-axis)
* `FrequencyBodyAccelerationJerkStdDeviationZ` - 	Body acceleration jerk standard deviation in frequency domain (Z-axis)
* `FrequencyBodyAccelerationJerkMeanFrequencyX` - 	Body acceleration jerk mean frequency (X-axis)
* `FrequencyBodyAccelerationJerkMeanFrequencyY` - 	Body acceleration jerk mean frequency (Y-axis)
* `FrequencyBodyAccelerationJerkMeanFrequencyZ` - 	Body acceleration jerk mean frequency (Z-axis)
* `FrequencyBodyAngularVelocityMeanX` - 	Body angular velocity mean in frequency domain (X-axis)
* `FrequencyBodyAngularVelocityMeanY` - 	Body angular velocity mean in frequency domain (Y-axis)
* `FrequencyBodyAngularVelocityMeanZ` - 	Body angular velocity mean in frequency domain (Z-axis)
* `FrequencyBodyAngularVelocityStdDeviationX` - 	Body angular velocity standard deviation in frequency domain (X-axis)
* `FrequencyBodyAngularVelocityStdDeviationY` - 	Body angular velocity standard deviation in frequency domain (Y-axis)
* `FrequencyBodyAngularVelocityStdDeviationZ` - 	Body angular velocity standard deviation in frequency domain (Z-axis)
* `FrequencyBodyAngularVelocityMeanFrequencyX` - 	Body angular velocity mean frequency (X-axis)
* `FrequencyBodyAngularVelocityMeanFrequencyY` - 	Body angular velocity mean frequency (Y-axis)
* `FrequencyBodyAngularVelocityMeanFrequencyZ` - 	Body angular velocity mean frequency (Z-axis)
* `FrequencyBodyAccelerationMagnitudeMean` - 	Body acceleration magnitude mean in frequency domain
* `FrequencyBodyAccelerationMagnitudeStdDeviation` - 	Body acceleration magnitude standard deviation in frequency domain
* `FrequencyBodyAccelerationMagnitudeMeanFrequency` - 	Body acceleration magnitude mean frequency
* `FrequencyBodyAccelerationJerkMagnitudeMean` - 	Body acceleration jerk magnitude mean in frequency domain
* `FrequencyBodyAccelerationJerkMagnitudeStdDeviation` - 	Body acceleration jerk magnitude standard deviation in frequency domain
* `FrequencyBodyAccelerationJerkMagnitudeMeanFrequency` - 	Body acceleration jerk magnitude mean frequency
* `FrequencyBodyAngularVelocityMagnitudeMean` - 	Body angular velocity magnitude mean in frequency domain
* `FrequencyBodyAngularVelocityMagnitudeStdDeviation` - 	Body angular velocity magnitude standard deviation in frequency domain
* `FrequencyBodyAngularVelocityMagnitudeMeanFrequency` - 	Body angular velocity magnitude mean frequency
* `FrequencyBodyAngularVelocityJerkMagnitudeMean` - 	Body angular velocity jerk magnitude mean in frequency domain
* `FrequencyBodyAngularVelocityJerkMagnitudeStdDeviation` - 	Body angular velocity jerk magnitude standard deviation in frequency domain
* `FrequencyBodyAngularVelocityJerkMagnitudeMeanFrequency` - 	Body angular velocity jerk magnitude mean frequency
* `AngleBodyAccelerationMeanAndGravity` - 	Angle between mean body acceleration and gravity
* `AngleBodyAccelerationJerkMeanAndGravityMean` - 	Angle between mean body acceleration jerk and mean gravity
* `AngleBodyAngularVelocityMeanAndGravityMean` - 	Angle between mean body angular velocity and mean gravity
* `AngleBodyAngularVelocityJerkMeanAndGravityMean` - 	Angle between mean body angular velocity jerk and mean gravity
* `AngleXAndGravityMean` - 	Angle between X-axis and mean gravity
* `AngleYAndGravityMean` - 	Angle between Y-axis and mean gravity
* `AngleZAndGravityMean` - 	Angle between Z-axis and mean gravity
