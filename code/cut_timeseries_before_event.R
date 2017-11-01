# cut up timeseries into series before the event taking place

# najprej za probo sddb
str(sddb_data)
# lahko se začne z (N ali pa ne
# kar je med (AFIB in (N zavržemo
# 1. za prvi del vzamem vse do prvega (AFIB
# 2. za naslednji del vzamem vse od naslednjega (N do (AFIB oz. do konca če ni več AFIB
# 3. ponovim 2.
# v prvi fazi zapisujem samo začetke in konce intervalov

str(sddb_data$`30`$annotations)

find_annotation <- function(annotation_time = "Seconds",
                            annotation_data,
                            lookup_column = "Aux",
                            lookup_texts) {
  # vrne naj Seconds in Annotation=lookupt column, kjer najde match v lookup column
  result <- annotation_data[(annotation_data[, lookup_column] %in% lookup_texts), c(annotation_time, lookup_column)]
  return(result)
}

result <- find_annotation(annotation_data = sddb_data$`30`$annotations, lookup_texts = c("(N", "(AFIB"))
head(result)
result
str(result)
head(sddb_data$`30`$annotations)

# napiši funkcijo, ki pogleda zanimivie annotacije in vrne začetek in konec intervalov brez dogodka
# za prvi interval doda na -0.1 sekundo, da je začetek non-eventa (to bi moralo biti OK generalno?)
return_interval_boundaries <- function(
  data, # one record
  event_start_signal = "(AFIB",
  event_end_signal = "(N" ) {
  
  # return a list or a dtaframe ? of start/ end pairs; 
  # go through all records in the list
  # for each record extract annotaions of interest
  # add non-event to time 0
  # go through list and if consecutive Aux entries are diffrent, 
  # save their times to Interval_start, Interval_end,
  # also save Signal_at_start and Signal_at_end and
  # Interval_type (event OR non-event)
  
  # extract annotaions
  annotations_data <- find_annotation(annotation_data = data,
                                      lookup_texts = c(event_start_signal, event_end_signal))
  
  # add non-event at the begining
  annotations_data <- rbind( data.frame(Seconds=0.0, Aux = event_end_signal), annotations_data)
  # add a non-event at the end
  annotations_data <- rbind( annotations_data, data.frame( Seconds = max(annotations_data$Seconds), Aux = as.character(tail(annotations_data$Aux, 1) ) ))
  str(annotations_data)
  annotations_data
  
  # check if consecutive Aux entries are different and process them
  intervals_data <- data.frame()
  i <- 1
  while (i <= dim(annotations_data)[1]) {
    j <- 1
    while (annotations_data[i] != annotations_data[i+j]) { j <- j + 1 }
    intervals_data
  }
  
}
  
return_interval_boundaries(data = sddb_data$`30`$annotations)  
