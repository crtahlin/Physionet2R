#' @title Remove lines with some pattern
#' 
#' @param file file to check
#' @param pattern pattern in line to remove 
#' 
#' @export
remove_lines_with_pattern <- function(file, pattern) {
  # read in text
  text <- readLines(file)
  # remove lines with pattern (keep only lines without pattern)
  text <- text[!grepl(x=text, pattern = pattern )]
  # write lines back to file
  writeLines(text, con = file)
}