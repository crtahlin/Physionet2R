#' @title funkcija ki vrne vse interval določenega tipa in pri kateri točki naj odreže podatke
#' 
#' @description to je input za funkcijo, ki računa BoPe
#' 
#' @export
determine_analysis_intervals <- function (
  all_db_data_info, # the info about the data - specific to physionet and output of some other function
  Interval_type, # which interval types to keep in analysis
  Min_interval_length, # how long they have to be at minimum
  Keep_total_interval_length = NULL, # shorten interval kept?
  Cut_off_last_X_seconds # cut off some data at interval en?
) {
  result <- 
    all_db_data_info[(all_db_data_info$Interval_type == Interval_type & 
                        all_db_data_info$Interval_length > Min_interval_length), ]
  # scenario if Keep_total_interval_lenght is set
  # keep only intervals that are still long enough
  # and the start of the interval is moved
  if (is.null(Keep_total_interval_length) != TRUE ) {
    result <- result[((result$Interval_length - Cut_off_last_X_seconds) >= Keep_total_interval_length), ]
    result$Analysis_interval_start <- (result$Interval_end - Cut_off_last_X_seconds - Keep_total_interval_length)
  } else {
    # otherwise keep start of interval as it is
    result$Analysis_interval_start <- result$Interval_start
  }
  
  result$Min_interval_length <- Min_interval_length
  result$Cut_off_last_X_seconds <- Cut_off_last_X_seconds
  result$Analysis_interval_end <- result$Interval_end - Cut_off_last_X_seconds
  result$Analysis_interval_length <- result$Analysis_interval_end - result$Analysis_interval_start
  result$Keep_total_interval_length <- Keep_total_interval_length
  
  # return result
  return(result)
}
