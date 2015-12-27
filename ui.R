
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(navbarPage(

  # Application title
  title = "Website Word Analysis",
  
  tabPanel('App',

  # Sidebar with a slider input for number of bins
        sidebarLayout(
                sidebarPanel(
                        textInput("pageUrl",
                                value="", label = "Page URL:"),
                        actionButton("fetchButton", "Fetch"),
                        
                        h3("Word Cloud settings"),
          
                        sliderInput("freq", "Minimum Frequency:",
                                min = 1,  max = 10, value = 2),
                        sliderInput("max",
                                "Maximum Number of Words:",
                                min = 1,  max = 300,  value = 100)
                ),

                # Show a plot of the generated distribution
                mainPanel(
                        tabsetPanel(
                                tabPanel("Words cloud", plotOutput("plot")), 
                                tabPanel("Text corpus", br(), textOutput("text")),
                                tabPanel("Words list", h3("All words sorted by relevance"), dataTableOutput("commonTable"))
                                 
                        )
                )
        )
  ),
  tabPanel('Usage', includeMarkdown("README.md"))
))
