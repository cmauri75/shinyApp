#
# # This is the user-interface definition of a Shiny web application.
# # You can find out more about building applications with Shiny here:
# #
# # http://shiny.rstudio.com
# #
#
library(shiny)


shinyUI(fluidPage(
    headerPanel("Pace calculator "),
    h3("I run 3 km in: "),
    numericInput("min", label = "minutes", value = "12", min = 7, max=30, width = "100px"),
    numericInput("sec", label = "seconds", value = "00", min = 0, max=59, width = "100px"),

    hr(),
    fluidRow(column(8, verbatimTextOutput("value")))
))
