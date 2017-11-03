#' @title Returns data frame of interval boundaries
#' 
#' @export
return_interval_boundaries <- function(
  annotation_data, 
  heart_beat_data, 
  event_start_signal = "(AFIB",
  event_end_signal = "(N" ) {
  
  # return a list or a dtaframe ? of start/ end pairs; 
  # go through all records in the list
  # for each record extract annotaions of interest
  # add non-event to time 0
  # go through list and if consecutive Aux entries are diffrent, 
  # save their times to Interval_start, Interval_end,
  # also save Signal_at_start and Signal_at_end and
  # Interval_type (event OR non-event)
  
  # extract annotaions
  annotations_data <- find_annotation(annotation_data = annotation_data,
                                      lookup_texts = c(event_start_signal, event_end_signal))
  
  # add non-event at the begining
  annotations_data <- rbind( data.frame(Seconds=0.0, Aux = event_end_signal), annotations_data)
  # add a non-event at the end
  annotations_data <- rbind( annotations_data, data.frame( Seconds = max(heart_beat_data$time, na.rm = TRUE), Aux = as.character(tail(annotations_data$Aux, 1) ) ))
  str(annotations_data)
  annotations_data
  
  # check if consecutive Aux entries are different and process them
  intervals_data <- data.frame()
  i <- 1
  while (i < dim(annotations_data)[1]) {
    j <- 1
    while ( (annotations_data[i, "Aux"] == annotations_data[(i+j), "Aux"] ) & ( (i + j) < dim(annotations_data)[1] )  ) { j <- (j + 1) }
    last_interval_data <- data.frame(Interval_start = annotations_data[i, "Seconds"],
                                     Interval_end = annotations_data[(i+j), "Seconds"],
                                     Signal_at_start = as.character(annotations_data[i, "Aux"]),
                                     Signal_at_end = as.character(annotations_data[(i + j), "Aux"]))
    if (dim(intervals_data)[1] > 0) {intervals_data <- rbind(intervals_data, last_interval_data)} else {intervals_data <- last_interval_data}
    i <- i + j
  }
  
  # remove intervals of zero lenght
  intervals_data <- intervals_data[ (intervals_data$Interval_start != intervals_data$Interval_end ), ]
  
  return(intervals_data)
}
