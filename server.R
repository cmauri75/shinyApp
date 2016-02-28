library(shiny)
library(UsingR)

formatTime <- function (secs) {
    cH <- trunc(secs / 3600,0)
    cM <- trunc((secs - cH * 3600) / 60,0)
    cS <- round(secs - cH * 3600 - cM * 60,0)

    paste (cH," Hours ",cM, " minutes ", cS, " seconds")
}

## get class of athelte depending on his marathon time
getClass <- function (maraSec) {
    maraMin <- maraSec / 60
    ifelse(maraMin > 4 * 60 + 43, 10,
           ifelse(maraMin > 3 * 60 + 44,  9,
                  ifelse(
                      maraMin > 3 * 60 + 34,  8,
                      ifelse(maraMin > 3 * 60 + 9,  7,
                             ifelse(
                                 maraMin > 3 * 60 + 0,  6,
                                 ifelse(
                                     maraMin > 2 * 60 + 50,  5,
                                     ifelse(
                                         maraMin > 2 * 60 + 40 + 1 / 3,  4,
                                         ifelse(maraMin > 2 * 60 + 31 + 1 / 6,  3,
                                                ifelse(maraMin > 2 * 60 + 17,  2,
                                                       1))
                                     )
                                 )
                             ))
                  )))
}

shinyServer(function(input, output) {
    output$predictTable <- renderTable({
        isMetric <- input$isMetric

        min <- input$min
        sec <- input$sec

        ##find pacePerKm from 3 kms or 2 miles (=3.2km)
        paceTest = ifelse(isMetric,
                          ((min * 60) + sec) / 3,
                          ((min * 60) + sec) / 3.21869)

        # http://www.fulviomassini.com/tabella-330-maratona-di-roma
        tenKSec <- paceTest * 1.1 * 10

        # http://da0a42.blogspot.it/2014/01/proiezioni-tempi-10k-mezza-maratona.html
        tenMSec <- tenKSec * (16.095 / 10) ^ 1.06
        halfSec <- tenKSec * (21.095 / 10) ^ 1.06

        # http://www.albanesi.it/corsa/tempomaratona.htm  mara  --> 1/2
        maraSec <- halfSec * 2.1

        # http://www.albanesi.it/arearossa/articoli/categoria.htm
        class <- getClass(maraSec)

        res <- data.frame();


        if (isMetric) {
            res <-
                rbind(res,
                      data.frame(
                          Distance = "10 Km",Prediction = formatTime(tenKSec), stringsAsFactors =
                              FALSE))
        }
        else {
            res <-
                rbind(res,
                      data.frame(
                          Distance = "10 Miles",Prediction = formatTime(tenMSec), stringsAsFactors =
                              FALSE))
        }

        res <-
            rbind(
                res,data.frame(
                    Distance = "Half marathon",Prediction = formatTime(halfSec), stringsAsFactors =
                        FALSE
                )
            )
        res <-
            rbind(
                res,data.frame(
                    Distance = "Marathon",Prediction = formatTime(maraSec), stringsAsFactors =
                        FALSE
                )
            )
        res <-
            rbind(
                res,data.frame(
                    Distance = "Athlete class",Prediction = getClass(maraSec), stringsAsFactors =
                        FALSE
                )
            )
    })

    output$table <- renderTable(iris)

    output$unit <- renderText({
        isMetric <- input$isMetric
        unit <- ifelse(isMetric,"3 Km","2 Miles")
        unit <- paste ("You run ",unit," in: ")
    })

})
