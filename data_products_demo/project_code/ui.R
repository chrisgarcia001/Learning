shinyUI(
	pageWithSidebar(
		headerPanel("Extramarital Affair Likelihood Estimator"),
		sidebarPanel(		
			numericInput('age', 'Your Age:', 30, min = 18, max = 100, step = 1),
			numericInput('ym', 'Years Married:', 5, min = 0, max = 100, step = 1),
			
			numericInput('education', 'Years of Education (12 = High School, 16 = B.S/B.A, etc.):', 12, min = 7, max = 25, step = 1),
			selectInput("sex", "Your Gender:", list("male", "female")),
			selectInput("child", "Have Children?:", list("yes", "no")),
			br(),
			sliderInput("rate",
                "Rate Your Marriage (Left = Very Unhappy, Right = Very Happy):",
                min = 1,  max = 5, value = 3),
			br(),
			sliderInput("religious",
                "Religious Devotion (Left = Dislike Religion, Right = Very Devoted):",
                min = 1,  max = 5, value = 3),
			br(),
			sliderInput("occupation",
                "Occupational Level (Left = 7th Grade Education or Below, Right = Requires Graduate/Professional Training):",
                min = 1,  max = 7, value = 3),
			
			submitButton('Submit')
		),
		mainPanel(
			h4("Usage"),
			p("This app gives an estimated probability that you had an extramarital affair within the past 12 months. 
			   To use this tool, just enter the requested information and press the submit button, and 
			   an estimated probability will appear below."),
			h3('Your Estimated Probability of Affair in Past 12 Months:'),
			br(), 
			h2(textOutput("probability")),
			br(),
			h3('What This Means:'),
			textOutput("comments")
		)
	)
)