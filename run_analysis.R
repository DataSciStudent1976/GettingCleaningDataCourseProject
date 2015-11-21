
# This script does the following - 
# 1. loads the features data (names and indices)
# 2. extracts the indices and names of relevant features (means and stds)
# 3. loads the training and test sets, extracts the relevant columns, and merges the resulting two sets by using rbind
# 4. loads the training and test labels, and merges the two sets by using rbind
# 5. loads the training and test subjects, and merges the two sets by using rbind
# 6. attaches two additional columns (subjects and labels) to the train+test data set
# 7. splits the set, first by subjects and then by labels, and calculates the quantities of interest (means over feature data)
# 8. gives names to colums and deletes the row names
# 9. writes the resulting data set to a file. 

	
	# load the data on feature names
	features = read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")

	print("Feature names loaded...")

	# extract the feature indices and names for mean values only
	mean_names = features[grep("mean[/(/)]",features[,2]),2]
	mean_indices = features[grep("mean[/(/)]",features[,2]),1]

	# extract the feature indices and names for std values only
	std_names = features[grep("std[/(/)]",features[,2]),2]
	std_indices = features[grep("std[/(/)]",features[,2]),1]


	# load the training set data and extract the relevant columns, then delete the full training set data to save space
	training_set_data = read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
	training_set_tidy = cbind(training_set_data[,mean_indices],training_set_data[,std_indices])
	rm(training_set_data)

	print("Training set data loaded and relevant features extracted...")


	# load the test set data and extract the relevant columns, then delete the full test set data to save space
	test_set_data = read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
	test_set_tidy = cbind(test_set_data[,mean_indices],test_set_data[,std_indices])
	rm(test_set_data)

	print("Test set data loaded and relevant features extracted...")


	# merge the two data sets by using rbind on the two dataframes
	merged_set = rbind(training_set_tidy,test_set_tidy)


	print("Training and test sets merged...")


	# load the training set labels
	training_set_labels = read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

	# load the test set labels
	test_set_labels = read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")

	# merge the two sets

	merged_labels = rbind(training_set_labels,test_set_labels,make.row.names=F)
	merged_labels[,1] = as.factor(merged_labels[,1])

	print("Labels merged...")


	# load the training set subjects (use read.table)
	training_set_subjects = read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

	# load the test set subjects (use read.table)
	test_set_subjects = read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

	# merge the two sets

	merged_subjects = rbind(training_set_subjects,test_set_subjects,make.row.names=F)
	merged_subjects[,1] = as.factor(merged_subjects[,1])

	print("Subjects merged...")


	merged_set = cbind(merged_set,merged_subjects,merged_labels)
	unique_subjects = sort(unique(merged_subjects)[,1])
	unique_labels   = sort(unique(merged_labels)[,1])

	all_cols = dim(merged_set)[2]	


	# first, split by merged_subjects, then, for each subject, split by merged labels,
	# calculate the quantities of interest and populate the tidy set

	count = 0
	data_split_by_subjects = split(merged_set,merged_set[,all_cols-1])
	for (subject in unique_subjects) {
		data_obj = data_split_by_subjects[[subject]]	
		subject_data_split_by_labels = split(data_obj,data_obj[,all_cols])
		for (label in unique_labels) {
			count = count + 1
			data_to_analyze = subject_data_split_by_labels[[label]]
			data_to_analyze[,all_cols-1] = as.numeric(data_to_analyze[,all_cols-1])
			data_to_analyze[,all_cols] = as.numeric(data_to_analyze[,all_cols])
			mean_vector = colMeans(data_to_analyze)
			if (!exists("tidy_set")) {
				tidy_set = vector("numeric",all_cols)
				tidy_set = mean_vector
			}
			else {
				tidy_set = rbind(tidy_set,mean_vector)
			}
		}
	}

	rownames(tidy_set)=NULL
	colnames(tidy_set) = c(as.character(mean_names),as.character(std_names),"Subject","Activity")
	
	
	# write to file by using write.table
	write.table(tidy_set,file="tidy_data.txt",row.names=F)

	

			


	