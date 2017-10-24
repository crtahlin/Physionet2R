#' @title Import physionet generated data, saved in a txt file
#' 
#' # TODO : redo help section after making the function more general 
#' 
#' @param workingDir The directory the data and RECORDS file (containing
#' the list of samples) are located.
#' @param fileSuffix_HR_constint The suffix of the files from which HR constant interval data should be imported.
#' E.g. "".unauditedHRconstint.txt" by default.
#' 
#' @param fileSuffix_annotations Suffix for annotations file.
#'  
#' @description Imports data from a txt file (csv), that contains two columns:
#' time of measurement in seconds and
#' heart rate in beats per minute (BPM). 
#' Meant to be used on constant interval measurements.
#' Outputs a data frame wih same two cloumns.
#' 
#' @export
Import_physionet_HR <- function (workingDir, 
                                 fileSuffix_HR_constint,
                                 fileSuffix_annotations) {
  
  # load RECORDS list
  parseRecords <- paste("cat ",workingDir, "RECORDS", sep="")
  Records <- system(parseRecords, intern=TRUE)
  
  # create list and data frame to hold results for each record file
  result <- list()
  # loop through all records
  for (rec in Records) {
    # try({
    #   # unaudited HR data
    #   filename <- paste(workingDir, rec, ".unaudited_HR_constint.txt", sep="")
    #   dataframe <- read.table(filename, sep="\t", dec=".")
    #   colnames(dataframe) <- c("time","BPM")
    #   result[[rec]][["unadited_HR_constant_interval"]] <- dataframe
    # })
    # try({
    #   # audited HR data
    #   filename <- paste(workingDir, rec, ".reference_HR_constint.txt", sep="")
    #   dataframe <- read.table(filename, sep="\t", dec=".")
    #   colnames(dataframe) <- c("time","BPM")
    #   result[[rec]][["reference_HR_constant_interval"]] <- dataframe
    # })
    
    try({
        # HR data
        filename <- paste(workingDir, rec, fileSuffix_HR_constint, sep="")
        dataframe <- read.table(filename, sep="\t", dec=".")
        colnames(dataframe) <- c("time","BPM")
        result[[rec]][["HR_constant_interval"]] <- dataframe
      })
    
    # try({
    #   # unaudited annotation data
    #   filename <- paste(workingDir, rec, ".unaudited_annotations.txt", sep="")
    #   dataframe <- read.table(filename, sep="", dec=".", fill = TRUE, header = TRUE,
    #                           colClasses = c("numeric", "numeric", "numeric", "factor", "factor", "factor", "factor", "factor" ))
    #   colnames(dataframe) <- c("Seconds", "Minutes", "Hours", "Type", "Sub", "Chan", "Num",	"Aux")
    #   result[[rec]][["unadited_annotations"]] <- dataframe
    # })
    
    try({
      # annotation data
      filename <- paste(workingDir, rec, fileSuffix_annotations, sep="")
      print(filename)
      # remove lines with \001
      remove_lines_with_pattern(file = filename, pattern = "\001")
      # load annotations to dataframe
      dataframe <- read.table(filename, sep="", dec=".", fill = TRUE, header = TRUE,
                              colClasses = c("numeric", "numeric", "numeric", "factor", "factor", "factor", "factor", "factor" ))
      colnames(dataframe) <- c("Seconds", "Minutes", "Hours", "Type", "Sub", "Chan", "Num",	"Aux")
      result[[rec]][["annotations"]] <- dataframe
    })
    
    # try({
    #   # audited annotation data
    #   filename <- paste(workingDir, rec, ".reference_annotations.txt", sep="")
    #   dataframe <- read.table(filename, sep="", dec=".", fill = TRUE, header = TRUE,
    #                           colClasses = c("numeric", "numeric", "numeric", "factor", "factor", "factor", "factor", "factor" ))
    #   colnames(dataframe) <- c("Seconds", "Minutes", "Hours", "Type", "Sub", "Chan", "Num",	"Aux")
    #   result[[rec]][["reference_annotations"]] <- dataframe
    # })
    
  }
  # return list of results
  return(result)
}
