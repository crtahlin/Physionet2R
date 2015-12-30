#' @title Import physionet generated data, saved in a txt file
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
ImportHRConstantInterval <- function (
  workingDir,
  fileSuffix=".unauditedHRconstint.txt") {
  # load RECORDS list
  parseRecords <- paste("cat ",workingDir, "RECORDS", sep="")
  Records <- system(parseRecords, intern=TRUE)
  
  # create list and data frame to hold results for each record file
  result <- list()
  dataframe <- data.frame()
  # loop through all records
  i <- 1
  for (rec in Records) {
    filename <- paste(workingDir, rec, fileSuffix, sep="")
    dataframe <- read.table(filename, sep="\t", dec=".")
    colnames(dataframe) <-
      c("time","BPM")
    result[[i]] <- dataframe
    names(result)[i] <- paste(rec)
    i <- i+1
  }
  # return list of results
  return(result)
}
