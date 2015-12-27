

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
        # Split excluded words input
        excludedWords <-
                reactive({
                        strsplit(input$excludedWords, "\\s*,\\s*")[[1]]
                })
        
        # fetch text from webpage
        text <- reactive(getText(input$pageUrl))
        
        # turn text into a term matrix using tm library
        terms <- reactive(getTermMatrix(text()))
        
        # filtering based on widget settings
        filteredTerms <- reactive({
                # Making this reactive on fetchButton only
                input$fetchButton
                
                t <- isolate(terms())
                t <- t[(t >= input$freq[1] & t <= input$freq[2])]
                t <- t[!(names(t) %in% excludedWords())]
                t <- head(t, n = input$max)
        })
        
        
        
        
        # Make the wordcloud drawing predictable during a session
        wordcloud_rep <- repeatable(wordcloud)
        
        # Outputting for the word cloud
        output$plot <- renderPlot({
                if (input$fetchButton != 0) {
                        t <- filteredTerms()
                        
                        if (length(t) > 1) {
                                wordcloud_rep(
                                        names(t), t, scale = c(4,0.5),
                                        max.words = input$max,
                                        colors = brewer.pal(8, "Spectral")
                                )
                        }
                        
                }
                
        })
        
        # Output for tabular data
        output$commonTable <- renderDataTable({
                if (input$fetchButton != 0) {
                        t <- filteredTerms()
                        
                        isolate({
                                data.frame(terms = names(t), frequency = t)
                        })
                }
        })
        
        # Output original corpus
        output$text <- renderText({
                if (input$fetchButton != 0) {
                        isolate(text())
                }
        })
        
})
