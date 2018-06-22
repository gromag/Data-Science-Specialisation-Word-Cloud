
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
require(markdown)

shinyUI(navbarPage(

  # Application title
  title = "Website Word Analysis",
  
  tabPanel('App',

        # Sidebar with a slider input for number of bins
        sidebarLayout(
                sidebarPanel(
                        textInput("pageUrl",
                                value="https://arstechnica.com/information-technology/2015/12/demystifying-artificial-intelligence-no-the-singularity-is-not-just-around-the-corner/", label = "Page URL:"),
                        actionButton("fetchButton", "Fetch"),
                        
                        h3("Further settings"),
                        
                        textInput("excludedWords",
                                  value="ars, technica", label = "Excluded words (comma separated):"),
          
                        sliderInput("freq", "Frequency Range:",
                                min = 1,  max = 30, value = c(3,15)),
                        sliderInput("max",
                                "Maximum Number of Words:",
                                min = 1,  max = 300,  value = 100)
                ),

                # Show a plot of the generated distribution
                mainPanel(
                        tabsetPanel(
                                tabPanel("Words cloud", plotOutput("plot")), 
                                tabPanel("Words list", h3("All words sorted by relevance"), dataTableOutput("commonTable")),
                                tabPanel("Text corpus", br(), textOutput("text"))
                                 
                        )
                )
        )
  ),
  tabPanel('Usage', includeMarkdown("README.md"))
))
