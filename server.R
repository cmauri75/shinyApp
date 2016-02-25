library(shiny)
library(UsingR)

formatTime <- function (secs) {
    cH <- trunc(secs / 3600,0)
    cM <- trunc((secs-cH*3600)/60,0)
    cS <- round(secs-cH*3600-cM*60,0)

    paste (cH," Hours ",cM, " minutes ", cS, " seconds")
}

getClass <- function (maraSec) {
    maraMin <- maraSec/60
    ifelse(maraMin > 4*60+43, 10,
    ifelse(maraMin > 3*60+44,  9,
    ifelse(maraMin > 3*60+34,  8,
    ifelse(maraMin > 3*60+9,  7,
    ifelse(maraMin > 3*60+0,  6,
    ifelse(maraMin > 2*60+50,  5,
    ifelse(maraMin > 2*60+40+1/3,  4,
    ifelse(maraMin > 2*60+31+1/6,  3,
    ifelse(maraMin > 2*60+17,  2,
    1)))))))))
}

shinyServer(function(input, output) {



    output$value <- renderPrint({
        min <- input$min
        sec <- input$sec

        paceTest = ((min*60)+sec)/3

        # http://www.fulviomassini.com/tabella-330-maratona-di-roma
        tenSec <- paceTest*1.1*10

        # http://da0a42.blogspot.it/2014/01/proiezioni-tempi-10k-mezza-maratona.html
        halfSec <- tenSec*(21.095/10)^1.06

        # http://www.albanesi.it/corsa/tempomaratona.htm  mara  --> 1/2
        maraSec <- halfSec*2.1

        # http://www.albanesi.it/arearossa/articoli/categoria.htm
        class <- getClass(maraSec)


        data.frame(formatTime(tenSec), formatTime(halfSec), formatTime(maraSec), getClass(maraSec))
    })

})
