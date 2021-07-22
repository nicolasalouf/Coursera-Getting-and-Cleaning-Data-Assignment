# Getting and Cleaning Data Assignment

Author: Nicolas Alouf  
Date: 22 July 2021

## Contents

This repo contains four files:

1.  codebook.md presents all variables of the resulting summary tidy set
2.  README.md describes the work involved in the analysis of the raw data and the synthesis of the summary tidy set
3.  run_analysis.R contains the script used to transform the raw data into the summary tidy set
4.  summary_tidy_set.csv is the resulting summarized and cleaned data set from the analysis

## Requirements

The following files are required to run the run_analysis.R script:

    .
    +-- UCI HAR Dataset
    |   +-- activity_labels.txt
    |   +-- features.txt
    |   +-- test
    |       +-- subject_test.txt
    |       +-- X_test.txt
    |       +-- y_test.txt
    |   +-- train
    |       +-- subject_train.txt
    |       +-- X_train.txt
    |       +-- y_train.txt

Installation of the "dplyr" package is required to run the script.
