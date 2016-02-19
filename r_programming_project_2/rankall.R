member <- function(value, elements) {
	ret <- FALSE;
	for(i in elements) {
		if(value == i) {ret <- TRUE;}
	}
	ret;
}

get.hosp <- function(data.set, state, num) {
	curr.data <- subset(data.set, State == state)
	return.val <- NULL
	if(num == "worst") {return.val <- curr.data[nrow(curr.data),]$Hospital.Name[1];}
	else if(num == "best") {return.val <- curr.data[1,]$Hospital.Name[1];}
	else if(num > nrow(curr.data)){return.val <- NA;}
	else {return.val <- curr.data[num,]$Hospital.Name[1];}
	return.val
}

rankall <- function(outcome, num = "best") {
	## Read outcome data
	curr.data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
	
	## Check that state and outcome are valid
	states <- sort(unique(curr.data$State))
	outcomes <- c("heart attack", "heart failure", "pneumonia")
	if(!member(outcome, outcomes)) {stop("invalid outcome");}

	# Transform columns of interest to numeric and remove rows with NA values
	curr.data <- transform(curr.data, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
	curr.data <- transform(curr.data, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
	curr.data <- transform(curr.data, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia = as.numeric(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
	
	# Get appropriate data.
	return.val <- NULL
	if(outcome == "heart attack") {
		curr.data <- subset(curr.data, !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
		curr.data <- curr.data[with(curr.data, order(State, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, Hospital.Name)), ]
		return.val <- data.frame(hospital=sapply(states, function(x) get.hosp(curr.data, x, num)), state=states)		
	}
	else if(outcome == "heart failure") {
		curr.data <- subset(curr.data, !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
		curr.data <- curr.data[with(curr.data, order(State, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, Hospital.Name)), ]
		return.val <- data.frame(hospital=sapply(states, function(x) get.hosp(curr.data, x, num)), state=states)
	}
	else {
		curr.data <- subset(curr.data, !is.na(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
		curr.data <- curr.data[with(curr.data, order(State, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, Hospital.Name)), ]
		return.val <- data.frame(hospital=sapply(states, function(x) get.hosp(curr.data, x, num)), state=states)
	}
	## Return hospital name in that state with the given rank
	## 30-day death rate
	return.val
}