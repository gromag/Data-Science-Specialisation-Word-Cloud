
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
require(RCurl)
source("helper.R")

#options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

shinyServer(function(input, output, session) {

        text <- reactive(getText(input$pageUrl))
        
        terms <- reactive({
                        getTermMatrix(text())
        })        
        

       # Make the wordcloud drawing predictable during a session
        wordcloud_rep <- repeatable(wordcloud)
    
       output$plot <- renderPlot({
               
               if(input$fetchButton !=0){

                       v <- isolate(terms())
                       
                       wordcloud_rep(names(v), v, scale=c(4,0.5),
                                     min.freq = input$freq, max.words=input$max,
                                     colors=brewer.pal(8, "Spectral"))
                       
               }
       })
       
       
       output$text <- renderText({
               
               if(input$fetchButton != 0){
                       isolate(text())
               }
        })
       
       output$commonTable <- renderDataTable(data.frame(terms = names(terms()), frequency = terms()))
       
})
