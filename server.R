
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# shinyServer(function(input, output) {
#
#   output$distPlot <- renderPlot({
#
#     # generate bins based on input$bins from ui.R
#     x    <- faithful[, 2]
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
#
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
#
#   })
#
# })
#
library(UsingR)
data(galton)

shinyServer(
    function(input, output) {
        output$newHist <- renderPlot({
            hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
            mu <- input$mu
            lines(c(mu, mu), c(0, 200),col="red",lwd=5)
            mse <- mean((galton$child - mu)^2)
            text(63, 150, paste("mu = ", mu))
            text(63, 140, paste("MSE = ", round(mse, 2)))
        })
    }
)
