library(shiny)
library(MASS)
library(datasets)
data(mtcars)

model <- lm(mpg ~ wt+cyl+disp+hp+am, mtcars)
step <- stepAIC(model)
model<-lm(mpg~wt+cyl+hp,mtcars)
model
##lm(formula = mpg ~ wt + cyl + hp, data = mtcars)

##Coefficients:
##  (Intercept)     wt          cyl           hp  
##  38.75179     -3.16697     -0.94162     -0.01804  

mpg <- function(wt, cyl, hp){
  out <- 38.75179 -3.16697 * as.numeric(wt) - 0.94162 * as.numeric(cyl) - 0.01804 * as.numeric(hp)
  round(out,2)
}

monthly_distance <- function(distance, days) {
  distance <- as.numeric(distance) * 2 * as.numeric(days)
  distance
}

cars <- data.frame(rownames(mtcars), mtcars)
colnames(cars)[1]="name"
cars <- cars[,c(1,2)]
cars$color <- "gray"

shinyServer(
  function(input, output){
    
    output$distance <- renderPrint(
      monthly_distance(input$distance, input$days)
    )
    
    output$mpg <- renderPrint( 
      mpg(input$wt, as.numeric(input$cyl), input$hp)
    )
    
    output$m_cost <- renderPrint( 
      round(monthly_distance(input$distance, input$days) / mpg(input$wt,input$cyl, input$hp) * as.numeric(input$cost),2)
    )
    
    output$y_cost <- renderPrint(
      round(monthly_distance(input$distance, input$days) / mpg(input$wt, input$cyl, input$hp) * as.numeric(input$cost) * 12,2)
    )
    
    
    
    output$compare <- renderPlot({
      cars[1]<- lapply(cars[1], as.character)
      you <- c("You", mpg(input$wt, input$cyl, input$hp), "red")
      cars <- rbind(cars, you)
      cars[2] <- lapply(cars[2], as.numeric)
      cars <-cars[order(cars[,2]),]
      
      # Fitting Labels 
      par(las=2) # make label text perpendicular to axis
      par(mar=c(2,8,2,2)) # increase y-axis margin.
      barplot(cars$mpg, names.arg=cars$name, col = cars$color, 
              main="How you car compares to others (in mpg)",
              xlab="mpg",
              
              cex.names=0.9, cex.axis=1.0,
              horiz=TRUE,  las=1)
      
    })
  }
)