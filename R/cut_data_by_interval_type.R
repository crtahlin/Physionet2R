#' @title Put all data into a dataframe, labelled by the kind of interval they are
#' 
#' @export
cut_data_by_interval_type <- function(annotation_data, heart_beat_data) {
  # get interval boundaries
  interval_boundaries <- return_interval_boundaries(annotation_data = annotation_data, heart_beat_data = heart_beat_data)
  # label intervals
  labeled_intervals <- label_interval_type_AFIB(interval_boundaries)
  # calculate interval length
  labeled_intervals[, "Interval_length"] <- (labeled_intervals$Interval_end - labeled_intervals$Interval_start)
  # add annotation data to heartbeat data
  # the best way to do this?
  # maybe do a for loop across all the data and ad to each line the data from the labeled intervals
  heart_beat_data[, names(labeled_intervals)] <- NA
  for (row in 1:dim(heart_beat_data)[1]) {
    # if time at last value for 
    # print(row)
    if ( heart_beat_data[row, "time"] < tail(labeled_intervals$Interval_end, 1) ) {
      interval_true <- ((heart_beat_data[row, "time"] >= labeled_intervals$Interval_start) & (heart_beat_data[row, "time"] < labeled_intervals$Interval_end))  
    } else {
      interval_true <- (heart_beat_data[row, "time"] == labeled_intervals$Interval_end)
    }
    
    heart_beat_data[row, names(labeled_intervals)] <- labeled_intervals[interval_true,]
  }
  
  
  return(heart_beat_data)
}