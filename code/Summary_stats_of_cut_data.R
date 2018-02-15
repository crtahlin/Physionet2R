# str(all_db_data)
# make an overview of data by:
# interval_type
# interval_length

# table(all_db_data$Interval_type, all_db_data$Interval_length)
library(ggplot2)
# todo: ohrani samo unique values za database + interval_ID
# in to plotaj
library(dplyr)
all_db_data_info <- distinct(all_db_data[, c("interval_ID","database","Interval_length", "Interval_type")])
str(all_db_data_info)
# save dataframe
save(all_db_data_info, file = "./data/all_db_data_info.Rdata")

ggplot(data = all_db_data_info) + geom_histogram(aes(x = Interval_length)) + facet_wrap(~ Interval_type) 
table(all_db_data_info$Interval_type, all_db_data_info$database)

# kako pridemo do normal_to_normal in AFIB_to_AFIB intervalov? sicer jih ni veliko, mogoče zanemarim?
# na hitro razmisli. sicer postaj blog post o ostalih podatkih:
# - iz katerih baz
# - kako jih razrešeš
# - kaj ostane (table, ggplot, ... ? )

# normal_to_normal so tudi tisti iz normal HR databases
ggplot(data = all_db_data_info) + 
  geom_histogram(aes(x = Interval_length)) + 
  facet_grid(database ~ Interval_type ) 


# Podatke smo črpali iz sledečih physionet.org baz podatkov:
unique(all_db_data_info$database)
unique(all_db_data$database)


# Imamo nekaj intervalov, ki so tipa normal_to_normal ali pa AFIB_to_AFIB. Slednji so za nas nezanimivi, saj izhajajo iz nepopolnih podatkov (kjer ni informacijo iz začetka ali pa iz konca meritve za posameznika). Zato jih bomo v nadaljevanju zavrgli.

#all_db_data_info <- 
#  all_db_data_info[!(all_db_data_info$Interval_type %in% c("normal_to_normal", "AFIB_to_AFIB")), ]

ggplot(data = all_db_data_info) + 
  geom_histogram(aes(x = Interval_length)) +
  facet_grid(database ~ Interval_type)  +
  xlim(0, 5000)  

table(all_db_data_info$database, all_db_data_info$Interval_length)

summary(all_db_data_info$Interval_length)
