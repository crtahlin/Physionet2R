#' @title extract intervals from a database
#' 
#' @export
extract_intervals_for_all_records_in_database <- function (database, db_name, cores = 6) {
  print(database)
  print(db_name)
  print(cores)
  rm("results")
  database <- get(database)
  # for (record in names(database)) {
  #   print(record)
  #   temp <- cut_data_by_interval_type2(database[[record]]$annotations, database[[record]]$HR_constant_interval)
  #   # add a column listing the record
  #   temp$record <- record
  #   if (exists("results", inherits = FALSE)) {
  #     print("previous results exist")
  #     results <- rbind(results, temp)
  #   } else {
  #     print("previous results do not exist")
  #     results <- temp}
  # }
  
  # register parallel backend
  library(doParallel)
  registerDoParallel(cores = cores)
  library(foreach)
  
  # multicore variant of for loop
  results <- 
    foreach (record = names(database), .combine = rbind) %dopar% {
    # determine interval type for each piece of recorded data
    temp <- cut_data_by_interval_type2(database[[record]]$annotations, database[[record]]$HR_constant_interval)
    # add a column listing the record
    temp$record <- record
    # return the result
    return(temp)
  }
  
  # add name of database
  results[, "database"] <- db_name
  # return results
  return(results)
}
