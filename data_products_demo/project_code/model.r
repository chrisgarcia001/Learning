library(Ecdat)

# If x is 0, return 0, otherwise return 1.
to.binary <- function(x) {
	val <- 0
	if(x > 0) {val <- 1}
	val
}

data(Fair)

had.affair <- sapply(Fair$nbaffairs, to.binary)
dataset <- Fair[setdiff(colnames(Fair), c("nbaffairs"))]
dataset <- cbind(dataset, had.affair)
# print(head(dataset))

model1 <- lm(nbaffairs ~ ., data = Fair)
model2 <- glm(had.affair ~ ., data = dataset, family = "binomial")

predicted.affairs <- function(input.data) {
	as.vector(predict(model1, newdata = input.data, type = "response"))
}

affair.prob <- function(input.data) {
	as.vector(predict(model2, newdata = input.data, type = "response"))
}
	