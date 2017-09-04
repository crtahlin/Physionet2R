#' @title Import physionet generated data, saved in a txt file
#' 
#' # TODO : redo help section after making the function more general 
#' 
#' @param workingDir The directory the data and RECORDS file (containing
#' the list of samples) are located.
#' @param fileSuffix The suffix of the files from which data should be imported.
#' E.g. "".unauditedHRconstint.txt" by default.
#' 
#' @description Imports data from a txt file (csv), that contains two columns:
#' time of measurement in seconds and
#' heart rate in beats per minute (BPM). 
#' Meant to be used on constant interval measurements.
#' Outputs a data frame wih same two cloumns.
#' 
#' @export
Import_physionet_HR <- function (workingDir) {
  # load RECORDS list
  parseRecords <- paste("cat ",workingDir, "RECORDS", sep="")
  Records <- system(parseRecords, intern=TRUE)
  
  # create list and data frame to hold results for each record file
  result <- list()
  # loop through all records
   for (rec in Records) {
    # unadited HR data
    filename <- paste(workingDir, rec, ".unaudited_HR_constint.txt", sep="")
    dataframe <- read.table(filename, sep="\t", dec=".")
    colnames(dataframe) <- c("time","BPM")
    result[[rec]][["unadited_HR_constant_interval"]] <- dataframe
    
    # annotation data
    filename <- paste(workingDir, rec, ".unaudited_annotations.txt", sep="")
    dataframe <- read.table(filename, sep="", dec=".", fill = TRUE)
    colnames(dataframe) <- c("Seconds", "Minutes", "Hours", "Type", "Sub", "Chan", "Num",	"Aux")
    result[[rec]][["unadited_annotations"]] <- dataframe
    
  }
  # return list of results
  return(result)
}
