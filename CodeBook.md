#CodeBook: Getting and Cleaning Data Project
(part of the coursera assessment for course "Getting and Cleaning Data")

Original data sets for this study:

 - 'features_info.txt': Shows information about the variables used on the feature vector.

 - 'features.txt': List of all features.

 - 'activity_labels.txt': Links the class labels with their activity name.

 - 'train/X_train.txt': Training set.

 - 'train/y_train.txt': Training labels.

 - 'test/X_test.txt': Test set.

 - 'test/y_test.txt': Test labels.

 - 'train/subject_train.txt':   Each row identifies the subject who performed the activity for each window sample.
        
 - 'test/subject_test.txt':  Each row identifies the subject who performed the activity for each window sample.
      
The resolutin output the data in tidy.txt stored in UCI HAR "Dataset" folder.      
  
The tidied data set is contained within the file tidy.txt in table format. This can be easily read with R function read.table(path, sep=" ", fill=FALSE, strip.white=TRUE, header = TRUE).

It has this table like structure:

row structure

180 rows resulting from 30 test subjects during 6 tested activities.

column structure
col 1: subject id
value range 1 .. 30
col 2: activity label
value range LAYING SITTING STANDING WALKING WALKING_DOWNSTAIRS WALKING_UPSTAIRS
col 3 ... col 68: original measurements aggregated as
either the mean value of the measured means
or the mean value of the measured standard deviations
The original measurements have these, hopefully descriptive enough, names:

'data.frame':	180 obs. of  68 variables:


		 $ activity                 : chr  
		 $ subject                  : int  
		 $ tbodyacc.mean.x          : num 
		 $ tbodyacc.mean.y          : num  
		 $ tbodyacc.mean.z          : num  
		 $ tbodyacc.std.x           : num  
		 $ tbodyacc.std.y           : num 
 		 $ tbodyacc.std.z           : num  
		 $ tgravityacc.mean.x       : num   
		 $ tgravityacc.mean.y       : num  
		 $ tgravityacc.mean.z       : num   
		 $ tgravityacc.std.x        : num  
		 $ tgravityacc.std.y        : num  
		 $ tgravityacc.std.z        : num  
		 $ tbodyaccjerk.mean.x      : num  
		 $ tbodyaccjerk.mean.y      : num 
 		 $ tbodyaccjerk.mean.z      : num  
		 $ tbodyaccjerk.std.x       : num  
		 $ tbodyaccjerk.std.y       : num  
		 $ tbodyaccjerk.std.z       : num  
		 $ tbodygyro.mean.x         : num  
		 $ tbodygyro.mean.y         : num  
		 $ tbodygyro.mean.z         : num  
		 $ tbodygyro.std.x          : num  
		 $ tbodygyro.std.y          : num  
		 $ tbodygyro.std.z          : num  	 
		 $ tbodygyrojerk.mean.x     : num  
		 $ tbodygyrojerk.mean.y     : num  
		 $ tbodygyrojerk.mean.z     : num  
		 $ tbodygyrojerk.std.x      : num  
		 $ tbodygyrojerk.std.y      : num  
		 $ tbodygyrojerk.std.z      : num  
		 $ tbodyaccmag.mean         : num  
		 $ tbodyaccmag.std          : num  
		 $ tgravityaccmag.mean      : num  
		 $ tgravityaccmag.std       : num  
		 $ tbodyaccjerkmag.mean     : num  
 		 $ tbodyaccjerkmag.std      : num  
 		 $ tbodygyromag.mean        : num  
		 $ tbodygyromag.std         : num  
		 $ tbodygyrojerkmag.mean    : num  
		 $ tbodygyrojerkmag.std     : num  
		 $ fbodyacc.mean.x          : num   
		 $ fbodyacc.mean.y          : num  
		 $ fbodyacc.mean.z          : num  
		 $ fbodyacc.std.x           : num  
		 $ fbodyacc.std.y           : num  
		 $ fbodyacc.std.z           : num  
		 $ fbodyaccjerk.mean.x      : num  
		 $ fbodyaccjerk.mean.y      : num  
		 $ fbodyaccjerk.mean.z      : num  
		 $ fbodyaccjerk.std.x       : num  
		 $ fbodyaccjerk.std.y       : num  
 		 $ fbodyaccjerk.std.z       : num  
		 $ fbodygyro.mean.x         : num  
		 $ fbodygyro.mean.y         : num  
		 $ fbodygyro.mean.z         : num  
		 $ fbodygyro.std.x          : num  
		 $ fbodygyro.std.y          : num  
		 $ fbodygyro.std.z          : num  
		 $ fbodyaccmag.mean         : num  
		 $ fbodyaccmag.std          : num  
		 $ fbodybodyaccjerkmag.mean : num  
		 $ fbodybodyaccjerkmag.std  : num  
		 $ fbodybodygyromag.mean    : num  
		 $ fbodybodygyromag.std     : num  
		 $ fbodybodygyrojerkmag.mean: num  
		 $ fbodybodygyrojerkmag.std : num  