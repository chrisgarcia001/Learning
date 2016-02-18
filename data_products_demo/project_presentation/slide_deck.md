Predicting  Extramarital Affairs
========================================================
author: C. Garcia
date:   11/22/2014

The Problem
========================================================
Extramarital affairs occur with great frequency. It is estimated that 30-60% of
men and 20-50% of women have affairs over the course of their marriage according to
[Buss and Shackleford](http://www.toddkshackelford.com/downloads/Buss-Shackelford-JRP-1997.pdf).
There are many factors that impact the likelihood of an affair, including:
- Happiness of the marriage
- Educational attainment
- Level of religious devotion

What are the chances that you've had one or more affairs over the past 12 months? This application will provide an estimate based on the "Fair" dataset, taken from the "Ecdat" R package.

The Web Application
========================================================
- Web application [found here](https://chrisgarcia.shinyapps.io/project_code/) 
- Simply asks you to input several parameters including age, years married, gender, education, happiness of marriage, 
and a few others
- Provides an estimated probability that you've had one or more affairs over the past few months.


Methodology
========================================================
This application uses logistic regression on a modified version of the "Fair" dataset from the "Ecdat" R package. This dataset contains 601 observations with variables for age, years married, education, rating of marriage, degree of religious devotion, and several others. The original dataset uses a response variable "nbaffairs". In this application, the "nbaffairs" was converted into a binary variable "had.affair" (1 if nbaffairs > 0, and 0 otherwise) and logistic regression is used to obtain an estimated probability


Model and Example
========================================================
The model is quite simple and is accessed through a predict function.  A simple example is shown below.



```r
model <- glm(had.affair ~ ., data = dataset, family = "binomial")
predicted.affairs <- function(input.data) {
  as.vector(predict(model, newdata = input.data, type = "response"))
}
test.data <- data.frame(sex="male", age=30, ym=10, child="no", religious=4, education=18, occupation=7, rate=4)
predicted.affairs(test.data)
```

```
[1] 0.2142
```


