###############################################################################
## Project: Getting and Cleaning Data Course Project
## Script purpose: The purpose of this project is to demonstrate the author's 
##                 ability to collect, work with, and clean a data set. This is
##                 the assignment of the Getting and Cleaning Data course part
##                 of the Johns Hopkins Data Science Specialization curriculum.
## Date: 22 July 2021
## Author: Nicolas Alouf
###############################################################################

###############################################################################
# Main Function
###############################################################################
run_analysis <- function() {
    library(dplyr)
    # step 1: merge data sets
    merged_data_set <- merge_data_sets()
    # step 2: extract means and standard deviations
    means_stds <- extract_data(merged_data_set)
    # step 3: add activity and variable names and group by activity and subject
    tidy_mean_stds <- means_stds %>% replace_activity_names %>% 
        rename_variables %>% group_by(Activity, Subject)
    # step 4: create separate summary data set
    summary <- summarize_all(tidy_mean_stds, mean)
    View(summary)
}

###############################################################################
# Supporting Functions
###############################################################################
merge_data_sets <- function() {
    # merge each data set (train and test) individually and then merge result
    merged_train <- merge_data_set("train")
    merged_test <- merge_data_set("test")
    merged_data_set <- union_all(merged_train, merged_test)
}

merge_data_set <- function(x) {
    # read data from respective files
    x_data <- read.table(paste0("UCI HAR Dataset/",x,"/X_",x,".txt"))
    y_data <- read.table(paste0("UCI HAR Dataset/",x,"/y_",x,".txt"))
    subject_data <- read.table(paste0("UCI HAR Dataset/",x,"/subject_",x,".txt"))
    
    # merge data from files into single data set
    merged_set <- subject_data %>% rename("Subject"="V1") %>% 
        mutate(y_data) %>% rename("Activity"="V1") %>% mutate(x_data)
}

extract_data <- function(merged_data_set) {
    # identify mean and standard deviation columns in features file
    features <<- read.table("UCI HAR Dataset/features.txt")
    means_stds_cols <<- sort(c(grep("\\bmean()\\b", features[[2]]), 
                        grep("\\bstd()\\b", features[[2]])))
    # select variables from data set matching with identified columns
    means_stds <- merged_data_set %>% 
                    select(Subject, Activity, means_stds_cols + 2)
}

replace_activity_names <- function(means_stds) {
    # read activity labels from file
    activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
    # for each activity index, match and replace with activity label
    for(i in 1:6){
        means_stds <- means_stds %>% mutate(Activity = 
                        ifelse(Activity == i, activity_labels[i,2], Activity))
    }
    return(means_stds)
}

rename_variables <- function(means_stds) {
    # extract all means and standard deviation variables
    means_stds_vars <- features[means_stds_cols,2]
    # for each column of data set, apply identified variable name
    for(i in 1:length(means_stds_vars)){
        means_stds <- means_stds %>% 
            rename(!!means_stds_vars[i] := names(means_stds)[i+2])
    }
    return(means_stds)
}
###############################################################################
# End of Script
###############################################################################
