#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tools)

# read all files in data folder
data_files_list <- list.files(path = "./data")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$select_data_file <- renderUI({
    selectInput("selected_data", "Select data file",
                choices = c("",data_files_list), selected = "")
  })   
  
  active_data <- reactive({
    load(paste0("./data/", input$selected_data))
  })
  
  active_dataset_name <- reactive({
    file_path_sans_ext(input$selected_data)
    })
  
  all_records <- reactive({
    names(get(active_dataset_name()) )
  })
  
  output$select_record <- renderUI({
    selectInput("select_record", "Select record", choices = all_records())
  })
  
})
