#' @title Put all data into a dataframe, labelled by the kind of interval they are
#' 
#' @export
cut_data_by_interval_type2 <- function(annotation_data, heart_beat_data) {
  # get interval boundaries
  interval_boundaries <- return_interval_boundaries(annotation_data = annotation_data, heart_beat_data = heart_beat_data)
  # label intervals
  labeled_intervals <- label_interval_type_AFIB(interval_boundaries)
  # calculate interval length
  labeled_intervals[, "Interval_length"] <- (labeled_intervals$Interval_end - labeled_intervals$Interval_start)
  # add annotation data to heartbeat data
  # the best way to do this?
  # maybe do a for loop across all the data and ad to each line the data from the labeled intervals
  # heart_beat_data[, names(labeled_intervals)] <- NA
  # for (row in 1:dim(heart_beat_data)[1]) {
  #   # if time at last value for 
  #   # print(row)
  #   if ( heart_beat_data[row, "time"] < tail(labeled_intervals$Interval_end, 1) ) {
  #     interval_true <- ((heart_beat_data[row, "time"] >= labeled_intervals$Interval_start) & (heart_beat_data[row, "time"] < labeled_intervals$Interval_end))  
  #   } else {
  #     interval_true <- (heart_beat_data[row, "time"] == labeled_intervals$Interval_end)
  #   }
  #   
  #   heart_beat_data[row, names(labeled_intervals)] <- labeled_intervals[interval_true,]
  # }
  
  # add an ID column to labeled_intervals
  labeled_intervals$interval_ID <- 1:dim(labeled_intervals)[1]
  
  # do an lapply version
  get_interval_data <- function (x, labeled_intervals) {
    if (x < max(labeled_intervals$Interval_end)) {
      result <- labeled_intervals[((x >= labeled_intervals$Interval_start) & (x < labeled_intervals$Interval_end)) , "interval_ID"] 
    } else {
      result <- labeled_intervals[ (x == labeled_intervals$Interval_end), "interval_ID"]
    }
    return(result)
  }
  
  interval_IDs <- lapply(heart_beat_data$time, get_interval_data, labeled_intervals = labeled_intervals)
  heart_beat_data[, "interval_ID"] <- unlist(interval_IDs)
  result <- merge(heart_beat_data, labeled_intervals, by.x = "interval_ID", by.y = "interval_ID")
  
  return(result)
}