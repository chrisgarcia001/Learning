
# ------------------- Utility Functions for Data Formatting ---------------------------

# This function takes a data frame as input and gets the total steps
# for each unique date. 
total_steps_by_date <- function(dataset) {
	dates <- unique(dataset$date)
	steps.date <- c()
	for(i in 1:length(dates)) {
		total <- 0
		curr <- as.numeric(subset(dataset, date == dates[i])$steps)
		for(j in 1:length(curr)) { total <- total + curr[j]}
		steps.date[i] <- total
	}
	steps.date
}

# Take in a data frame and get the corresponding avg. steps by unique 5-minute interval.
avg_steps_by_interval <- function(dataset) {
	intervals <- sort(unique(as.numeric(dataset$interval)))
	step.avg <- c()
	for(i in 1:length(intervals)) {
		curr <- as.numeric(subset(dataset, as.numeric(interval) == intervals[i])$steps)
		step.avg[i] <- mean(curr, na.rm=TRUE)
	}
	index <- 1:length(intervals)
	data.frame(cbind(interval = intervals, steps = step.avg, index))
}

# Take in a date in text format and return a factor of either Weekend or Weekday.
day.classification <- function(raw.date) {
	classif <- "Weekday" 
	if(is.element(weekdays(as.Date(raw.date)), c("Saturday", "Sunday"))) {	
		classif <- "Weekend" 
	}
	classif
}

# ------------------- Main Portion ---------------------------------------------------

# STEP 1: Load and process data.
unzip("activity.zip", overwrite = TRUE)
raw.data <- read.csv("activity.csv")

# STEP 2: Construct histogram and show mean/median steps (missing values ignored here).
steps.by.date <- total_steps_by_date(raw.data)
hist(steps.by.date, col="blue", xlab = "Total Daily Steps", main = "Total Daily Steps")
message(paste("Mean steps per day (missing values ignored):", 
               mean(steps.by.date, na.rm = TRUE)))
message(paste("Median steps per day (missing values ignored):", 
               median(steps.by.date, na.rm = TRUE)))

# STEP 3: Get steps organized by 5-minute interval and find interval with max average daily steps.
step.avg.by.interval <- avg_steps_by_interval(raw.data)
plot(step.avg.by.interval$interval, step.avg.by.interval$steps, type = "l", 
     xlab = "Interval", ylab = "Avg. Steps", 
     main = "Mean Steps by 5-Min. Interval", col = "blue")
max.avg.steps <- max(step.avg.by.interval$steps)
max.steps.interval <- 0
for(i in 1:nrow(step.avg.by.interval)) { 
	if(step.avg.by.interval[i,2] == max.avg.steps) { 
		max.steps.interval <- step.avg.by.interval[i,1] 
	}
}
message(paste("5-Minute interval with most steps on average:", max.steps.interval))

# STEP 4: Impute missing values using mean for 5-minute intervals.
imputed <- c()
for(i in 1:nrow(raw.data)) {
	val <- raw.data[i,1]
	interval.index <- (i %% nrow(step.avg.by.interval)) + 1
	if(is.na(val)) { val <- step.avg.by.interval[interval.index, 2] }
	imputed[i] <- val
}
raw.data$steps <- imputed

# Re-compute steps.by.date using imputed values and show histogram.
steps.by.date <- total_steps_by_date(raw.data)
hist(steps.by.date, col="orange", xlab = "Total Daily Steps", 
     main = "Total Daily Steps (Missing Values Imputed)")
message(paste("Mean steps per day (imputed missing values):", 
        mean(steps.by.date, na.rm = TRUE)))
message(paste("Median steps per day (imputed missing values):", 
        median(steps.by.date, na.rm = TRUE)))

# STEP 5: Compare weekday versus weekend steps.
# Get day classifications for each day in dataset and build into a new dataframe:
day.classifs <- sapply(raw.data$date, function(x) day.classification(x))
steps.by.day.classif <- data.frame(cbind(day.class = day.classifs, 
                               interval = raw.data$interval, steps = imputed))
							   
# Separate out weekdays and weekends into two different sets:
wend <- avg_steps_by_interval(subset(steps.by.day.classif, day.class == "Weekend"))$steps
wday <- avg_steps_by_interval(subset(steps.by.day.classif, day.class == "Weekday"))$steps

# Plot
par(mfrow = c(2, 1))
plot(seq(1, 2355, length.out = 288), wend, type = "l", xlab = "Interval", 
     ylab = "Avg. Steps", main="Weekend", col="blue")
plot(seq(1, 2355, length.out = 288), wday, type = "l", xlab = "Interval", 
     ylab = "Avg. Steps", main="Weekday", col="blue")

