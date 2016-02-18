library(caret)

# ----------------------------------- Column Processing Utility Functions -----------------------------------------
nval <- function(chars, char) {
	rv <- 0
	if(char != "") {
		i <- 1
		while(!is.element(substr(chars, i, i), c("", char))) {i <- i + 1}
		if(substr(chars, i, i) == char) {rv <- i} else {rv <- NA}
	}
	rv
}

decode_col <- function(col.str) {
	rv <- col.str
	if(is.character(col.str)) {
		i <- 1; total <- 0
		v <- c()
		while(substr(col.str, i, i) != "") {
			v[i] <- substr(col.str, i, i)
			i <- i + 1
		}
		v <- rev(v)
		i <- 0
		while(i < length(v)) {
			total <- total + (nval("abcdefghijklmnopqrstuvwxyz", tolower(v[i + 1])) * (26 ^ i))
			i <- i + 1
		}
		rv <- total
	}
	rv
}

# Takes in a vector of Excel-style columns and gets numbers. Some can be ranges ("AA-AC" means 27-30).
decode <- function(colcodes) {
	nums <- c()
	for(code in colcodes) {
		rng <- strsplit(code,"-")[[1]]
		nums <- append(nums, decode_col(rng[1]):decode_col(rng[length(rng)]))
	}
	nums
}

# ------------------------------------------- Get Dataset ---------------------------------------------------------
#message(paste("Output Filename Specified: ", output.file))
message("Reading Data...")
raw_csv <- read.csv("pml-training.csv")
dataset <- raw_csv[decode(c("G-K", "AK-AW", "BH-BP", "CF-CH", "CX", "DI-DT", "EJ", "EU-FD"))]
message("Done!")
# ------------------------------------------- Data Exploration ----------------------------------------------------
nsv <- nearZeroVar(dataset,saveMetrics=TRUE)

# ------------------------------------------- Do Machine Learning -------------------------------------------------

library(caret)#; library(kernlab)#; data(spam)
set.seed(32343)
#subset_size <- nrow(dataset) #10000
#data_subset <- sample(1:nrow(dataset), subset_size)
trainp <- 0.7
inTrain <- createDataPartition(y = dataset$classe, p = trainp, list = FALSE)
training <- dataset[inTrain,]
testing <- dataset[-inTrain,]


message("Training and Test Dimension:")
print(dim(training))

message("Model Fitting...")
start.time <- Sys.time()
modelFit <- train(classe ~.,data=training, method="rf")
end.time <- Sys.time()
message("Done!")

predictions <- predict(modelFit,newdata=testing)

print(confusionMatrix(predictions,testing$classe))
message(paste("All Done! Starting and ending times:", start.time, end.time))

# ------------------------------------------- Do a little more testing --------------------------------------------
# Compare to all data not in training set
# fulltest <- dataset[setdiff(1:nrow(dataset), inTrain),]
# predictions2 <- predict(modelFit,newdata=fulltest)
# confusionMatrix(predictions2, fulltest$classe)

# ------------------------------------------- Build the Real Predictions ------------------------------------------
prediction.data <- read.csv("pml-testing.csv")
real.predictions <- predict(modelFit, newdata=prediction.data)
pred.table <- data.frame(predictions = real.predictions)
#write.csv(pred.table, "table-10000.csv")
for(i in 1:length(real.predictions)) {
	write(as.character(real.predictions[i]), paste("output/p",i,".txt",sep=""))
}





