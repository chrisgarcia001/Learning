source("model.r")

calculate.prob <- function(sex, age, ym, child, religious, education, occupation, rate) {
	input.data <- data.frame(sex=as.factor(sex),
								 age=as.numeric(age),
								 ym=as.numeric(ym),
								 child=as.factor(child),
								 religious=as.numeric(religious),
								 education=as.numeric(education),
								 occupation=as.numeric(occupation),
								 rate=as.numeric(rate))
	affair.prob(input.data)
}

comments <- function(sex, age, ym, child, religious, education, occupation, rate) {
	score <- calculate.prob(sex, age, ym, child, religious, education, occupation, rate)
	comments <- "There is a fairly low likelihood that you had an affair in past 12 months." 
	if(score >= 0.35) {
		comments <- "There is a moderate likelihood that you had an affair in past 12 months." 
	}
	if(score >= 0.5) {
		comments <- "There is a high likelihood that you had an affair in past 12 months." 
	}
	comments
}

shinyServer(
	function(input, output) {
		
		sex <- reactive({as.factor(input$sex)})
		age <- reactive({as.numeric(input$age)})
		ym <- reactive({as.numeric(input$ym)})
		child <- reactive({as.factor(input$child)})
		religious <- reactive({as.numeric(input$religious)})
		education <- reactive({as.numeric(input$education)})
		occupation <- reactive({as.numeric(input$occupation)})
		rate <- reactive({as.numeric(input$rate)})
		
		output$inputValue <- renderPrint({input$glucose})
		output$prediction <- renderPrint({diabetesRisk(input$glucose)})
		
		
		output$probability <- renderText({calculate.prob(input$sex, input$age, input$ym, input$child, 
		                               input$religious, input$education, input$occupation, input$rate)})	
		output$comments <- renderText({comments(input$sex, input$age, input$ym, input$child, 
		                               input$religious, input$education, input$occupation, input$rate)})
	}
	
		
		

	
)