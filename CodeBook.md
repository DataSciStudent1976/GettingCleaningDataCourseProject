# The script run_analysis.R does the following:
## 1. Loads the features data (names and indices).
## 2. Extracts the indices and names of relevant features (means and standard deviations).
## 3. Loads the training and test sets, extracts the relevant columns, and merges the resulting two sets by using the rbind function.
## 4. Loads the training and test labels, and merges the two sets by using the rbind function.
## 5. Loads the training and test subjects, and merges the two sets by using the rbind function.
## 6. Attaches two additional columns (subjects and labels) to the train+test data set.
## 7. Splits the set, first by subjects and then by labels, and calculates the quantities of interest (means over feature data).
## 8. Gives names to columns and deletes the row names.
## 9. Writes the resulting data set to a file.

# The following data structures are used in the script (and are in the workspace after the script completes)
## 1. features  - contains the features
## 2. mean_names - contains the names of the means of different quantities
## 3. mean_indices - contains the indices of the means in the mean_names
## 4. std_names - contains the names of the stds of different quantities
## 5. std_indices - contains the indices of the stds in the std_names
## 6. tidy_set - contains the tidy set (with means of different features)
