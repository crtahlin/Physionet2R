str(all_db_data)
# make an overview of data by:
# interval_type
# interval_length

table(all_db_data$Interval_type, all_db_data$Interval_length)
library(ggplot2)
# todo: ohrani samo unique values za database + interval_ID
# in to plotaj
library(dplyr)
all_db_data_info <- distinct(all_db_data[, c("interval_ID","database","Interval_length", "Interval_type")])
ggplot(data = all_db_data_info) + geom_histogram(aes(x = Interval_length)) + facet_wrap(~ Interval_type) 
table(all_db_data_info$Interval_type)
