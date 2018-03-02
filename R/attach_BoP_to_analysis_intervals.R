#' @title attach BoP to interval built with determine_analysis_intervals function
#' 
#' @export
attach_BoP_to_analysis_intervals <- function (
  all_db_data,
  analysis_intervals,
  subsequenceSize = 4 * 60, 
  alphabetSize = 5,
  wordSize = 4,
  doNumerosityReduction = TRUE) {
  
  results <- 
    foreach (analysis = (1:dim(analysis_intervals)[1]), .combine = rbind, .errorhandling = "stop" ) %dopar% {
      # take only the required analysis info
      analysis_interval <- analysis_intervals[analysis, ]
      
      # determine the data subset in analysis
      data_subset <- (all_db_data$database == analysis_interval$database &
                        all_db_data$record == analysis_interval$record &
                        all_db_data$interval_ID == analysis_interval$interval_ID &
                        all_db_data$time >= analysis_interval$Analysis_interval_start &
                        all_db_data$time <= analysis_interval$Analysis_interval_end)
      
      # make the BoP
      result <- 
        makeBoP2(data = all_db_data[data_subset, "BPM"],
                 subsequenceSize = subsequenceSize, 
                 alphabetSize = alphabetSize,
                 wordSize = wordSize,
                 doNumerosityReduction = doNumerosityReduction)
      # save the additional data
      analysis_interval$subsequenceSize <- subsequenceSize
      analysis_interval$alphabetSize <- alphabetSize
      analysis_interval$wordSize <- wordSize
      analysis_interval$doNumerosityReduction <- doNumerosityReduction
      # finaly, the BoP
      analysis_interval$BoP <- list(result)
      
      return(analysis_interval)
    }
  
  return(results)
}
