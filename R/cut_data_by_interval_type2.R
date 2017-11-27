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

  # add an ID column to labeled_intervals
  labeled_intervals$interval_ID <- 1:dim(labeled_intervals)[1]
  
  # define an lapply version
  get_interval_data <- function (x, labeled_intervals) {
    if (x < max(labeled_intervals$Interval_end)) {
      result <- labeled_intervals[((x >= labeled_intervals$Interval_start) & (x < labeled_intervals$Interval_end)) , "interval_ID"] 
    } else {
      result <- labeled_intervals[ (x == labeled_intervals$Interval_end), "interval_ID"]
    }
    return(result)
  }
  
  # run the lapply version
  interval_IDs <- lapply(heart_beat_data$time, get_interval_data, labeled_intervals = labeled_intervals)
  heart_beat_data[, "interval_ID"] <- unlist(interval_IDs)
  result <- merge(heart_beat_data, labeled_intervals, by.x = "interval_ID", by.y = "interval_ID")
  
  return(result)
}