#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("physionet heart rate viewer"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      # add: select dataset (sddb, ...), select record, select zoom, select annotations
       uiOutput("select_data_file"),
       uiOutput("select_record")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       textOutput("header"),
       plotOutput("plot_record",
                  brush = brushOpts(
                    id = "plot_record_brush",
                    resetOnNew = TRUE)
                  ),
       plotOutput("plot_record_zoomed")
    )
  )
))
