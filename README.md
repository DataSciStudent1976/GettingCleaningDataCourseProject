# The following was performed to solve the problem - 
## 1. The two data sets (training and test) were merged by using the rbind() function.
## 2. The training and test labels were merged by using the rbind() function.
## 3. The training and test subjects were merged by using the rbind() function.
## 4. The relevant feature names and indices (for means and standard deviations) were extracted.
## 5. The relevant features were used to construct the data set that contained data only on the features of interest. 
## 6. The merged labels and subjects vectors were added as new columns to the merged data set, by using the cbind() function.
## 7. The merged data set was split, first on the subjects and then on the labels, and the means were calculated to obtain the tidy set.
## 8. The tidy set was saved to a file by using the write.table() function.

