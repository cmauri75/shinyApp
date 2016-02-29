#
# # This is the user-interface definition of a Shiny web application.
# # You can find out more about building applications with Shiny here:
# #
# # http://shiny.rstudio.com
# #
#
library(shiny)


shinyUI(
    fluidPage(
        titlePanel("Running race predictor"),
        sidebarLayout(
            sidebarPanel(
                h3("Documentation"),
                div("This application helps you discovering your excepeted time for 10 Km o 10 miles, half marathon and marathon."),
                div("The basic requirement is that you run 3 km or 2 miles at top of your possibilites, it's important you run all the distance at costant pace, if you must decelerate in last meters or if you don't feel to tired at the end, you should retry the test running slower or faster, respectevely"),
                div("The route should be as plain as possible (7.5 laps in a ring track is the best)"),
                div("Once you have the time insert it in the 2 boxes (minutes and seconds) and choosen if you like to use metric or imperial system, the system will calculate in real time the excepeted times."),
                div("The system will also tell your athlete class (1 is the best for elite runner, 10 is the worst)"),
                div("App link:"),a(href="https://cmauri.shinyapps.io/cpShiny/","shinyapps"),
                div("Github repo: "),a(href="https://github.com/cmauri75/shinyApp","GitHub")
            ),
            mainPanel(
                h3(textOutput("unit")),
                fluidRow(
                    column(2, numericInput("min", label = "minutes", value = "12", min = 7, max=30, width = "80px")),
                    column(2, numericInput("sec", label = "seconds", value = "00", min = 0, max=59, width = "80px"))),
                fluidRow(
                    column(2, "Unit of measure: "),
                    column(2, checkboxInput(inputId="isMetric", label="Metric", value = TRUE))
                ),
                tableOutput('predictTable')
            )
        )
    )
)
