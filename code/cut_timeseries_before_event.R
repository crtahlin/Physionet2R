# cut up timeseries into series before the event taking place

# najprej za probo sddb
str(sddb_data)

str(sddb_data$`30`$annotations)

result <- find_annotation(annotation_data = sddb_data$`30`$annotations, lookup_texts = c("(N", "(AFIB"))
head(result)
result
str(result)
head(sddb_data$`30`$annotations)


interval_boundaries <- return_interval_boundaries(annotation_data = sddb_data$`30`$annotations, heart_beat_data = sddb_data$`30`$HR_constant_interval)  

label_interval_type_AFIB(interval_boundaries)

str(sddb_data$`30`$HR_constant_interval)

detach("package:Physionet2R", unload = TRUE)
library(physionet2R)
system.time(temp <- cut_data_by_interval_type(sddb_data$`30`$annotations, sddb_data$`30`$HR_constant_interval)) # [350000:353587,] 
system.time(temp2 <- cut_data_by_interval_type2(sddb_data$`30`$annotations, sddb_data$`30`$HR_constant_interval)) # [350000:353587,] 

str(sddb_data)
tail(temp)
tail(temp2)

to_compare <- c("time", "BPM", "Interval_start", "Interval_end", "Interval_type", "Interval_length")
identical(temp[, to_compare], temp2[, to_compare])
# JUPI!


# TODO: tole še v separate funkcijo.
extract_intervals_for_all_records_in_database <- function (database) {
  rm("results")
  for (record in names(database)) {
    print(record)
    temp <- cut_data_by_interval_type2(database[[record]]$annotations, database[[record]]$HR_constant_interval)
    if (exists("results")) {
      print("previous results exist")
      results <- rbind(results, temp)
    } else {
      print("previous results do not exist")
      results <- temp}
  }
  # add name of database
  results[, "database"] <- database
  # return results
  return(results)
}

results <- extract_intervals_for_all_records_in_database(sddb_data)
dim(results)

databases_list <- c("afdb_data", "ltafdb_data", "mitdb_data", "nsr2db_data", "nsrdb_data", "sddb_data")
for (database in databases_list) {
  results <- extract_intervals_for_all_records_in_database(database = database)
  if (exists("all_db_data")) {
    all_db_data <- rbind(all_db_data, results)
  } else {
    all_db_data <- results
  }
}

dim(all_db_data)

