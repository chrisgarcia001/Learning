# ------------------------------------------------------------------------------------
# @author: chrisgarcia001
# NOTES: This assumes the working directory contains the exact same structure
#        and format as the original data folder when downloaded.
# ------------------------------------------------------------------------------------

# Get features.
features <- read.table("features.txt")
key.feature.inds <- grep("mean[(][)]|std[(][)]", features$V2)
key.feature.names <- features[key.feature.inds,]$V2
key.feature.names <- sapply(key.feature.names, function(x) gsub("mean[(][)]", "mean", x))
key.feature.names <- sapply(key.feature.names, function(x) gsub("std[(][)]", "standard-dev", x))

# Get activity-related R variables.
act.label.keys <- read.table("activity_labels.txt")
train.act.inds <- read.table("train/y_train.txt")
test.act.inds <- read.table("test/y_test.txt")
all.act.inds <- rbind(train.act.inds, test.act.inds)
# NOTE: all.act.labels are the final ordered labels for the combined data set.
all.act.labels <- sapply(all.act.inds$V1, function(i) act.label.keys[i, 2])

# Get subject-related R variables.
train.subj.inds <- read.table("train/subject_train.txt")
test.subj.inds <- read.table("test/subject_test.txt")
# NOTE: all.act.labels are the final ordered labels for the combined data set.
all.subj.inds <- rbind(train.subj.inds, test.subj.inds)$V1

# Read in core training & test data.
train <- read.table("train/X_train.txt")
test <- read.table("test/X_test.txt")
# NOTE: all.data is the core data in the combined set.
all.data <- rbind(train, test)[key.feature.inds]
colnames(all.data) <- key.feature.names

# NOTE: all.unsummarized.data takes us through step 4.
all.unsummarized.data <- cbind(Subject=all.subj.inds, Activity=all.act.labels, all.data)

# Summarize data by subject/activity.
unique.subjs <- sort(unique(all.subj.inds))
tidy.data <- data.frame()

for(i in unique.subjs) {
	for(j in act.label.keys$V2) {
		curr.data <- subset(all.unsummarized.data, Subject == i & Activity == j);
		means <- colMeans(all.unsummarized.data[3:ncol(all.unsummarized.data)]);
		next.row <- cbind(curr.data[1,1:2], as.list(means));
		tidy.data <- rbind(tidy.data, next.row);
	}
}
colnames(tidy.data) <- colnames(all.unsummarized.data)
write.table(tidy.data, "tidy_data.txt", row.names=FALSE, quote=FALSE)






