# Getting-and-Cleaning-Data-Project

The files contained in this repository are the scripts and data about to run getting and cleaning data to obtain a data set to analisys. 

The untidy input to the project are datasets found in: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip/

The output is a tidy data set called tidy.txt  

The R script, run_analysis.R, generates tidy.txt from the input data by: 


* Downloading and unzipping the file containing the untidy data.
* Obtaining the identifiers for each experimental trial/record-the Activity and Subject for both trial and testing datasets.
* Extracting the measurement variables that are means or standard deviations from the 561 feature variables for both trial and testing observations. 
* Incorporating the activity and subject identifiers with the appropriate measurement values for both trial and testing observations.
* Merging the trial and test observations to create one dataset.
* Converting the Activity and Subject columns to factors with descriptive label names.
* Creating a new tidy dataset that.
* Finaly the read.table funcion open de tidy.txt and store your values in 'dados' variable. The View(dados) plot a table with de values of data tidy.
