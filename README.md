# Readme to explain data extraction and tidy choices

The code
1. gets labels from the activity_labels.txt and features.txt files
2. reads the measurements selecting only the mean and standard deviations
3. combines the measurements into a single dataframe
4. calculates the mean using ddply (outputing into the long format option)

The code expects the user to extract the zip of data into the directory 'UCI HAR Dataset. Automating this seemed outside the scope of the assignment and unimportant.

The mean and standard deviations are taken to be from the mean() and std() strings from the original data.

The long format is used for the mean results because this is easier to verify both as a writer of the script and to mark.

In the codetable I've assumed that the reader can map the variables given the textual explanation, as it's a bit obsessive to explain every single variable - there being quite a few.