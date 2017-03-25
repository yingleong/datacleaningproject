# datacleaningproject
Coursera John Hopkins University - Data Cleaning Project

Assumptions;
1. The code assume that the raw data files are stored in the same folder structure as per downloaded. All the test and train data shall reside in the folder called "UCI HAR Dataset".

Code flow;
1. The code basically reads out the individual X, Y, and subject raw file from both test and train folder, and stored them according to the specific data structure independently using lapply
2. It then combined all three independent data frame using cbind command
3. It then cleans up the column names based on the features.txt file, in addition to hard coded subject and activity column names
4. The code then remove all the irrelevant columns from the cleaned up data frame.
5. It then performs a merge to substitute the activity name so that it provides a more descriptive information about the activity in each row.
6. It then perform summarize function to summarize the data based on activity and subject
7. The code finally writes the output to summarize_dataset.txt

Output file is summarize_dataset.txt


Column(s) 	Names 	Description
1	Subject	The independent participant who takes part in the survey
2	Activity	The activity performed by the user
3..	All the individual metrics 	The mean computed for individual metrics based on the grouping of Subject and Activity  
