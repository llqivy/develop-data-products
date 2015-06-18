library(shiny)
library(markdown)

shinyUI(fluidPage(
  # Application title
  titlePanel("Annual Fuel Cost"),
  helpText("Calculate your estimated annual petrol cost for driving to work"),
  
  sidebarLayout(
    sidebarPanel(        
      helpText("Provide information about your home-to-work distance, your car and estimated petrol cost"),
      h3("Your work trip:"),
      textInput('distance', 'Home to work distance (in miles):'),
      textInput('days', 'Average number of work days (in a month):'),
      
      h3("Your car:"),
      textInput("wt", "Weight of the car (in 1000lb)"),
      textInput("hp", "Gross horsepower"),
      radioButtons("cyl","Number of Cylinders:",
                   list("4 Cylinders"="4","6 Cylinders"="6","8 Cylinders"="8")),
      
      h3("Estimated petrol cost:"),
      textInput('cost', 'Petrol Price (per gallon):')
      
      
    ),
    
    mainPanel(
      tabsetPanel(
        
        tabPanel("Calculator",
                 h3("Results of prediction"),
                 
                 h4("Based on the information you have provided:"),

                 tabsetPanel(
                   tabPanel("distance",verbatimTextOutput("distance")),
                   tabPanel("mpg",verbatimTextOutput("mpg")),
                   tabPanel("monthly cost",verbatimTextOutput("m_cost")),
                   tabPanel("annual cost",verbatimTextOutput("y_cost")),
                   tabPanel("Compare",plotOutput("compare"))
                 )
                 
        ),
        tabPanel("Documentation",
                 h3("Annual Fuel Cost Calculator"),
                 
                 p("This app helps calculate the estimated mpg of the car, 
                   based on car's weight, number of cylinders and horsepower,usinginear regression model based on the mtcars dataset from R. 
                   It estimates mpg, monthly work distance and petrol cost,then computes monthly and annual petrol costs."),
                 
                 
                 h3("Information need:"),
                 
                 p("1. distance of your home to work trip and average working days in a month."),
                 
                 p("2. weight, cylinders and horsepower of the car."),
                 
                 p("3. current petrol cost.")
                 
                 )
                 )            
                 )
  )
))