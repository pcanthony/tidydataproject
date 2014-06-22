Welcome to Peter's Getting and Cleaning Data Course Project!

This repo contains the following files:

1. README.md: this read-me file.
2. run_analysis.R: an R script that reads the UCI HCI data and outputs two tidy data sets.
3. mytidydataset.txt: a comma-delimited text file containing a tidy data set. 
4. mytidydataset_avg.txt: like mytidydataset.txt, but with the data averaged for subject-activity pairs.
5. CodeBook.md: a markdown file that describes the data in the repo.  

PLEASE REFER TO CODEBOOK.MD FOR MORE INFORMATION ABOUT THIS PROJECT.


To re-produce the tidy data sets, do the following:

1. Download the UCI data here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the downloaded file.
3. Set your working directory in R to the directory containing the unzipped files.  This directory is called "UCI HAR Dataset" by default.
4. Load and source the run_analysis.R file in R.
5. Run the doit() function in R.


The data transformations carried out in run_analysis.R are documented in the code book and comments in the R script.


Thanks for reading!

--Peter