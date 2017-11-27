#' @title extract intervals from a database
#' 
#' @export
extract_intervals_for_all_records_in_database <- function (database, db_name) {
  print(database)
  print(db_name)
  rm("results")
  database <- get(database)
  for (record in names(database)) {
    print(record)
    temp <- cut_data_by_interval_type2(database[[record]]$annotations, database[[record]]$HR_constant_interval)
    if (exists("results", inherits = FALSE)) {
      print("previous results exist")
      results <- rbind(results, temp)
    } else {
      print("previous results do not exist")
      results <- temp}
  }
  # add name of database
  results[, "database"] <- db_name
  # return results
  return(results)
}
