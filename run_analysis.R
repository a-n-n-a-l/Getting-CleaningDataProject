# This is the file run_analysis.R. It:
#    - reads the test and training data sets into R
#    - combines and cleans up the data sets
#    - creates easy to read labels for the variables
#    - extracts only the information related to the mean and standard deviation variables
#
#    - next, it groups the data by SubjectID and Activity 
#      and averages each of the variables from the previous data set
#    
#    - both data sets are also saved as .csv files
#      filteredData.csv for the first data set
#      tidyData.csv for the second data set


#
#check for and load the needed packages - dplyr and stringr
#

if (!require("dplyr", character.only = TRUE)) {
        #check if dplyr is loaded, if not, install/load it
        install.packages("dplyr")
        library("dplyr")
}

if (!require("stringr", character.only = TRUE)) {
        #check if stringr is loaded, if not, install/load it
        install.packages("stringr")
        library("stringr")
}

#
# Set the location for the data sets
#

allurl <- c("raw-data")                               #directory for all of the data
testurl <- c("/test")                                 #directory for test data
trainurl <- c("/train")                               #directory for train data
originalurl <- getwd()                                #original directory to return to
testlocation <- paste0(allurl, testurl)               #full test data location
trainlocation <- paste0(allurl, trainurl)             #full train data location
alldirectories <- c(testlocation, trainlocation)

features <- read.table(paste0(allurl, "\\features.txt"))         # read in the variable names


#
# process the variable names to be more readable and easier to understand
#

features <- as.character(features$V2)
features <- gsub(pattern = "^f", "Frequency ", features)
features <- gsub(pattern = "^t", "", features)
features <- gsub(pattern = "tBody|BodyBody", "Body ", features)
features <- gsub(pattern = "Acc", " Acceleration ", features)
features <- gsub(pattern = "Gyro", " Angular Velocity ", features)
features <- gsub(pattern = "Mag", " Magnitude", features)
features <- gsub(pattern = "gravityMean", " gravity mean ", features, ignore.case = TRUE)
features <- gsub(pattern = "meanFreq", " mean frequency ", features, ignore.case = TRUE)
features <- gsub(pattern = "jerkmean", " jerk mean", features, ignore.case = TRUE)
features <- gsub(pattern = "\\,", " and ", features)
features <- gsub(pattern = "std", " std Deviation", features)
features <- str_to_title(features)
features <- gsub(pattern = "[^[:alpha:]]", "", features)     # leave only alpha characters in the name
features <- c("SubjectID", "Activity", features)             # create column headers


#
# Read in and process activity labels
#

activities <- read.table(paste0(allurl, "\\activity_labels.txt"))         # read in activity labels
activityNumbers <- activities$V1
activityNames <- activities$V2
activityNames <- str_to_sentence(activityNames)                           # change case for readability
activityNames <- gsub(pattern = "[^[:alpha:]]", " ", activityNames)       # remove underscores


#
# Read in the data sets by looping through the directories defined above
#

for (i in alldirectories) {

        currentdir <- getwd()                         # check to see if the working directory has the files you're looking for
        if (!grepl(pattern = i, currentdir)) {
                setwd (originalurl)                   # if not, change the working directory
                setwd(i)
        }
        
        allfiles <- list.files()                      # loop through all the files in the directory to import them into R
        allfiles <- grep(".txt", allfiles, value = TRUE)
        for (j in allfiles) {
                variablename <- gsub("_", "", strsplit(j, split = ".txt"))       # extract the file name as a variable name for the R object
                assign(variablename, read.table(j))                              # create new data frames with the file contents
                variablename <- as.data.frame(variablename)
         }
}

setwd (originalurl)                                 #return to the original directory



#
# combine all the data
#

yall <- rbind (ytest, ytrain)                        # combine all label information into one object
yall <- as.numeric(yall$V1)                          # change the labels information to a vector 

for (k in activityNumbers){                          # substitute activity names for numbers
        yall <- sub(k, activityNames[k], yall)
}

yall <- as.data.frame(as.factor(yall))               # change the labels back to a data frame as factors
xall <- rbind(Xtest, Xtrain)                         # combine all the data into one object
subjectall <- rbind(subjecttest, subjecttrain)       # combine all the subjects into one object
subjectall$V1 <- as.factor(subjectall$V1)            # convert subjects to factors
alldata <- cbind(subjectall, yall)                   # combine the labels and subjects
alldata <- cbind(alldata, xall)                      # add data to the object with labels and subjects
colnames(alldata) <- features                        # add column names from the variables read in earlier



#
# Extract only the columns with the information on the mean and the standard deviation
#

keepColumns <- grep("Mean|std", colnames(alldata), ignore.case=TRUE)
keepColumns <- c(1, 2, keepColumns)
filteredData <- alldata %>% select(all_of(keepColumns))     # create the object for the clean, filtered data
write.csv(filteredData, file="filteredData.csv")            # copy the object to a .csv file

View(filteredData)                                          # display the filtered data set


#
# Use the filtered data set to group it by Subject and Activity and calculate the mean for every variable
#

tidyData <- filteredData %>% group_by(SubjectID, Activity) %>% summarize(across(everything(), mean))


newColumnNames <- colnames(tidyData)                        # add Avg" to differentiate column names for the new data set
for (m in 3:length(newColumnNames)) {
        newColumnNames[m] <- paste0("Avg",newColumnNames[m])
}
colnames(tidyData) <- newColumnNames
 
write.csv(tidyData, file="tidyData.csv")                    # copy the new data set to a .csv file


View(tidyData)                                              # display the data set with averages for the filtered data set

#
# Clean up counter variables
#

rm(variablename, i, j, k, m)