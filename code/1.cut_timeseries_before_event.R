# loads each physionet database that is suitable for analysis
# add data to a dataframe with additional info about the type of interval of the data
# basicaly - attaches additional columns needed for analysis to the data!

library(physionet2R)
# cut up timeseries into series before the event taking place

# # najprej za probo sddb
# str(sddb_data)
# 
# str(sddb_data$`30`$annotations)
# 
# result <- find_annotation(annotation_data = sddb_data$`30`$annotations, lookup_texts = c("(N", "(AFIB"))
# head(result)
# result
# str(result)
# head(sddb_data$`30`$annotations)
# 
# 
# interval_boundaries <- return_interval_boundaries(annotation_data = sddb_data$`30`$annotations, heart_beat_data = sddb_data$`30`$HR_constant_interval)  
# 
# label_interval_type_AFIB(interval_boundaries)
# 
# str(sddb_data$`30`$HR_constant_interval)

# detach("package:Physionet2R", unload = TRUE)
# library(physionet2R)
# system.time(temp <- cut_data_by_interval_type(sddb_data$`30`$annotations, sddb_data$`30`$HR_constant_interval)) # [350000:353587,] 
# system.time(temp2 <- cut_data_by_interval_type2(sddb_data$`30`$annotations, sddb_data$`30`$HR_constant_interval)) # [350000:353587,] 
# 
# str(sddb_data)
# tail(temp)
# tail(temp2)
# 
# to_compare <- c("time", "BPM", "Interval_start", "Interval_end", "Interval_type", "Interval_length")
# identical(temp[, to_compare], temp2[, to_compare])
# # JUPI!

detach("package:physionet2R", unload = TRUE)
library(physionet2R)
# str(sddb_data[1])
# results <- extract_intervals_for_all_records_in_database(sddb_data[1:2], db_name = "sddb")
# dim(results)
# str(results)
# unique(results$database)

# load the parsed database data
load(file = "./physionet_viewer/data/afdb_data.Rdata")
load(file = "./physionet_viewer/data/ltafdb_data.Rdata")
load(file = "./physionet_viewer/data/mitdb_data.Rdata")
load(file = "./physionet_viewer/data/nsr2db_data.Rdata")
load(file = "./physionet_viewer/data/nsrdb_data.Rdata")
load(file = "./physionet_viewer/data/sddb_data.Rdata")


# start the extraction
databases_list <- c("afdb_data", "ltafdb_data", "mitdb_data", "nsr2db_data", "nsrdb_data", "sddb_data")
# databases_list <- c("sddb_data")
rm("all_db_data")
rm("all_db_data_info")
system.time ({
  for (database in databases_list) {
    results <- extract_intervals_for_all_records_in_database(database = database, db_name = database, cores = 6)
    if (exists("all_db_data")) {
      all_db_data <- rbind(all_db_data, results)
      } else {
        all_db_data <- results
      }
    }
})

dim(all_db_data)
unique(all_db_data$database)
head(all_db_data)
save(all_db_data, file = "./data/all_db_data.Rdata")

