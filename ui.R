
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Link counter"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
          textInput("pageUrl",
                  value="http://www.google.com", label = "Page URL:"),
          submitButton("Fetch"),
          sliderInput("freq",
                      "Minimum Frequency:",
                      min = 1,  max = 50, value = 15),
          sliderInput("max",
                      "Maximum Number of Words:",
                      min = 1,  max = 300,  value = 100)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h2("Stats"),
      plotOutput("plot")
    )
  )
))
