#RUN THE DOIT() FUNCTION TO PRODUCE TWO TIDY DATA SETS.

doit <- function () {
	#load the data sets using the functions provided below
	loadtest("./test")
	loadtrain("./train")
	loadFeaturesAndLabels("./")
	
	#assign column names to the test and training data sets	using the features vector
	names(testX) <- myfeatures$V2
	names(trainX) <- myfeatures$V2
	
	#identify the column names representing means and standard deviations
	meannames <- myfeatures[grep("*mean\\(\\)", myfeatures$V2), ]
	stdnames <- myfeatures[grep("*std\\(\\)", myfeatures$V2), ]
	goodnames <- c(meannames$V2, stdnames$V2)
	
	#subset the test and training data sets using the column names identified in the previous step
	testX_good <- testX[, (names(testX) %in% goodnames)]
	trainX_good <- trainX[, (names(trainX) %in% goodnames)]
	
	#make character vectors with activity names to parallel the numeric activity vectors (testY, trainY)
	actnames_testY <- testY
	for (i in 1:nrow(testY)) {
		actnames_testY[i, ] <- mylabels$V2[testY[i, ]]
	}
	actnames_trainY <- trainY
	for (i in 1:nrow(trainY)) {
		actnames_trainY[i, ] <- mylabels$V2[trainY[i, ]]
	}

	names(testsubj) <- "subject"
	names(testY) <- "activity num"
	names(actnames_testY) <- "activity"

	names(trainsubj) <- "subject"
	names(trainY) <- "activity num"
	names(actnames_trainY) <- "activity"

	#assemble data frames for the test and training data sets
	#with the subject numbers, activity numbers, and activity names as the left-most columns
	subj_act_testX <- cbind(testsubj, testY, actnames_testY, testX_good)
	print(dim(subj_act_testX))
	
	subj_act_trainX <- cbind(trainsubj, trainY, actnames_trainY, trainX_good)	
	print(dim(subj_act_trainX))
	
	#merge the test and training data frames by stacking them one on top of the other
	allsubj <- rbind(subj_act_testX, subj_act_trainX)#, stringsAsFactors = FALSE)
	print(dim(allsubj))
	
	#sort the merged data frame by subject and then by activity number
	sortallsubj <<- allsubj[order(allsubj$"subject", allsubj$"activity num"), ]
	
	#save the merged frame to a file
	write.csv(sortallsubj, "./mytidyset.txt", row.names = FALSE)
	
	#make a new data frame to hold the data averaged by subject-activity pair
	avgallsubj <<- data.frame(replicate(ncol(sortallsubj), numeric(0), simplify = FALSE), stringsAsFactors = FALSE)
	
	#loop over the sorted data frame, calculate means by column, and rbind the means to the new frame
	for (i in 1:max(sortallsubj$subject)) {
		for (j in 1:max(sortallsubj$"activity num")) {
			temp <- colMeans(sortallsubj[(sortallsubj$subject == i & sortallsubj$"activity num" == j), 4:ncol(sortallsubj)])
			tobind <- c(i, j, j, temp)#as.character(temp))#mylabels$V2[j], as.character(temp))
			avgallsubj <- rbind(avgallsubj, tobind)
		}
	}
	
	#add names to the new data frame; add activity names
	names(avgallsubj) <- names(sortallsubj)
	for (i in 1:nrow(avgallsubj)) {
		avgallsubj$activity[i] <- mylabels$V2[avgallsubj$"activity num"[i]]
	}
	
	#save the new data frame with data averaged by subject-activity pair to a file.
	write.csv(avgallsubj, "./mytidyset_avg.txt", row.names = FALSE)
	
}

#load the test data from text files
loadtest <- function(testdir) {

	mywd <- getwd()
	setwd(testdir)
	
	testX <<- read.table("X_test.txt", sep="", header = FALSE, stringsAsFactors = FALSE)
	testY <<- read.table("y_test.txt", sep="", header = FALSE, stringsAsFactors = FALSE) 
	testsubj <<- read.table("subject_test.txt", sep="", header = FALSE, stringsAsFactors = FALSE) 
	
	setwd(mywd)
}

#load the training data from text files
loadtrain <- function(traindir) {

	mywd <- getwd()
	setwd(traindir)
	
	trainX <<- read.table("X_train.txt", sep="", header = FALSE, stringsAsFactors = FALSE)
	trainY <<- read.table("y_train.txt", sep="", header = FALSE, stringsAsFactors = FALSE) 
	trainsubj <<- read.table("subject_train.txt", sep="", header = FALSE, stringsAsFactors = FALSE) 
	
	setwd(mywd)
}

#load the features and labels from text files
loadFeaturesAndLabels <- function(featdir) {

	mywd <- getwd()
	setwd(featdir)
	
	myfeatures <<- read.table("features.txt", sep="", header = FALSE, stringsAsFactors = FALSE)
	mylabels <<- read.table("activity_labels.txt", sep="", header = FALSE, stringsAsFactors = FALSE) 
	
	setwd(mywd)
}