#' @title Find annotations in annotation txt file
#' 
#' @export
find_annotation <- function(annotation_time = "Seconds",
                            annotation_data,
                            lookup_column = "Aux",
                            lookup_texts) {
  # vrne naj Seconds in Annotation=lookupt column, kjer najde match v lookup column
  result <- annotation_data[(annotation_data[, lookup_column] %in% lookup_texts), c(annotation_time, lookup_column)]
  return(result)
}