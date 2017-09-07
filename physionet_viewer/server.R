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

  # select data file - list all rdata files in a folder
  output$select_data_file <- renderUI({
    selectInput("selected_data", "Select data file",
                choices = c("",data_files_list), selected = "")
  })   
  
  # load the selected data
  active_data <- reactive({
    load(paste0("./data/", input$selected_data))
  })
  
  # gets the name of the "active" dataset
  active_dataset_name <- reactive({
    file_path_sans_ext(input$selected_data)
    })
  
  # list all records of the active dataset
  all_records <- reactive({
    names(get(active_dataset_name()) )
  })
  
  # construct menu to select a record
  output$select_record <- renderUI({
    selectInput("selected_record", "Select record", choices = all_records())
  })
  
  # header for the output
  output$header <- renderText({
    paste("Selected record: ", input$selected_record)
  })
  
  # get data for the selecte record
  active_record_data <- reactive({
    data <- get(active_dataset_name())
    return(data[[input$selected_record]])
  })
  
  # link the two plots
  ranges_zoomed <- reactiveValues(x = NULL, y = NULL)
  
  # zoom when brushed
  observe({
    brush <- input$plot_record_brush
    
    if (!is.null(brush)) {
      ranges_zoomed$x <- c(brush$xmin, brush$xmax)
      ranges_zoomed$y <- c(brush$ymin, brush$ymax)
    } else {
      ranges_zoomed$x <- NULL
      ranges_zoomed$y <- NULL
    }
  })
  
  # plot the graph of selected record
  output$plot_record <- renderPlot({
    ggplot() + 
      geom_line(aes(x = time, y = BPM), data = active_record_data()[["unadited_HR_constant_interval"]]) +
      geom_text(aes(x = Seconds, y = 50, label = Aux), data = active_record_data()[["unadited_annotations"]])
  })
  
  # plot the zoomed portion of graph
  output$plot_record_zoomed <- renderPlot({
    ggplot() + 
      geom_line(aes(x = time, y = BPM), data = active_record_data()[["unadited_HR_constant_interval"]]) +
      geom_text(aes(x = Seconds, y = 50, label = Aux), data = active_record_data()[["unadited_annotations"]]) +
      coord_cartesian(xlim = ranges_zoomed$x, ylim = ranges_zoomed$y, expand = FALSE)
    
  })
  
})
