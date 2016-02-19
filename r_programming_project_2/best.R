member <- function(value, elements) {
	ret <- FALSE;
	for(i in elements) {
		if(value == i) {ret <- TRUE;}
	}
	ret;
}

best <- function(state, outcome) {
	## Read outcome data
	curr.data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	
	## Check that state and outcome are valid
	states <- unique(curr.data$State)
	outcomes <- c("heart attack", "heart failure", "pneumonia")
	if(!member(state, states)) {stop("invalid state");}
	if(!member(outcome, outcomes)) {stop("invalid outcome");}
	
	curr.data <- subset(curr.data, State == state)
	
	# Transform columns of interest to numeric and remove rows with NA values
	curr.data <- transform(curr.data, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
	curr.data <- transform(curr.data, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
	curr.data <- transform(curr.data, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
	
	# Get appropriate data.
	return.val <- NULL
	if(outcome == "heart attack") {
		bestval <- min(curr.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, na.rm=TRUE)
		top <- subset(curr.data, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack == bestval)
		return.val <- top[with(top, order(Hospital.Name)), ]$Hospital.Name[1]
	}
	else if(outcome == "heart failure") {
		bestval <- min(curr.data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, na.rm=TRUE)
		top <- subset(curr.data, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure == bestval)
		return.val <- top[with(top, order(Hospital.Name)), ]$Hospital.Name[1]
	}
	else {
		bestval <- min(curr.data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, na.rm=TRUE)
		top <- subset(curr.data, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia == bestval)
		return.val <- top[with(top, order(Hospital.Name)), ]$Hospital.Name[1]
	}
	
	## Return hospital name in that state with lowest 30-day death rate
	return.val
}
